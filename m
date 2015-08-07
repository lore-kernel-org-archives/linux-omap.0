From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] dma: omap-dma: add support for pause of non-cyclic
 transfers
Date: Fri, 7 Aug 2015 14:44:13 +0300
Message-ID: <55C49A0D.10600@ti.com>
References: <1438936917-7254-1-git-send-email-bigeasy@linutronix.de>
 <55C47DE1.9020902@ti.com> <55C48A1E.3070007@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55C48A1E.3070007@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Vinod Koul <vinod.koul@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, john.ogness@linutronix.de, Russell King <rmk+kernel@arm.linux.org.uk>
List-Id: linux-omap@vger.kernel.org

On 08/07/2015 01:36 PM, Sebastian Andrzej Siewior wrote:
> On 08/07/2015 11:44 AM, Peter Ujfalusi wrote:
>> On 08/07/2015 11:41 AM, Sebastian Andrzej Siewior wrote:
>>> This DMA driver is used by 8250-omap on DRA7-evm. There is one
>>> requirement that is to pause a transfer. This is currently used on =
the RX
>>> side. It is possible that the UART HW aborted the RX (UART's RX-tim=
eout)
>>> but the DMA controller starts the transfer shortly after.
>>> Before we can manually purge the FIFO we need to pause the transfer=
,
>>> check how many bytes it already received and terminate the transfer
>>> without it making any progress.
>>>
>>> From testing on the TX side it seems that it is possible that we in=
voke
>>> pause once the transfer has completed which is indicated by the mis=
sing
>>> CCR_ENABLE bit but before the interrupt has been noticed. In that c=
ase the
>>> interrupt will come even after disabling it.
>>>
>>> The AM572x manual says that we have to wait for the CCR_RD_ACTIVE &
>>> CCR_WR_ACTIVE bits to be gone before programming it again here is t=
he
>>> drain loop. Also it looks like without the drain the TX-transfer ma=
kes
>>> sometimes progress.
>>>
>>> One note: The pause + resume combo is broken because after resume t=
he
>>> the complete transfer will be programmed again. That means the alre=
ady
>>> transferred bytes (until the pause event) will be sent again. This =
is
>>> currently not important for my UART user because it does only pause=
 +
>>> terminate.
>>
>> with a short testing audio did not broke (the only user of pause/res=
ume)
>> Some comments embedded.
>>
>>> Cc: <stable@vger.kernel.org>
>>
>> Why stable? This is not fixing any bugs since the PAUSE was not allo=
wed for
>> non cyclic transfers.
>=20
> Hmmm. The DRA7x was using pause before for UART. I just did not see i=
t
> coming that it was not allowed here. John made a similar change to th=
e
> edma driver and I assumed it went stable but now I see that it was ju=
st
> cherry-picked into the ti tree.
> If you are not comfortable it being stable material I can drop it.

This change is needed for the UART DMA support if I'm not mistaken and =
this
mode is not really supported by older kernels, so having this to implem=
ent
something which is not going to be used in the stable kernels feels som=
ehow wrong.

>>> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>>> ---
>>>  drivers/dma/omap-dma.c | 54 ++++++++++++++++++++++++++++++++++++++=
------------
>>>  1 file changed, 41 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
>>> index 249445c8a4c6..6b8497203caf 100644
>>> --- a/drivers/dma/omap-dma.c
>>> +++ b/drivers/dma/omap-dma.c
>>> @@ -299,7 +299,7 @@ static void omap_dma_start(struct omap_chan *c,=
 struct omap_desc *d)
>>>  	omap_dma_chan_write(c, CCR, d->ccr | CCR_ENABLE);
>>>  }
>>> =20
>>> -static void omap_dma_stop(struct omap_chan *c)
>>> +static int omap_dma_stop(struct omap_chan *c)
>>>  {
>>>  	struct omap_dmadev *od =3D to_omap_dma_dev(c->vc.chan.device);
>>>  	uint32_t val;
>>> @@ -342,8 +342,26 @@ static void omap_dma_stop(struct omap_chan *c)
>>> =20
>>>  		omap_dma_glbl_write(od, OCP_SYSCONFIG, sysconfig);
>>>  	} else {
>>> +		int i =3D 0;
>>> +
>>> +		if (!(val & CCR_ENABLE))
>>> +			return -EINVAL;
>>> +
>>>  		val &=3D ~CCR_ENABLE;
>>>  		omap_dma_chan_write(c, CCR, val);
>>> +		do {
>>> +			val =3D omap_dma_chan_read(c, CCR);
>>> +			if (!(val & (CCR_RD_ACTIVE | CCR_WR_ACTIVE)))
>>> +				break;
>>> +			if (i > 100)
>>
>> if (++i > 100)
>> 	break;
>> to avoid infinite loop?
>=20
> Ah. So I forgot to increment the counter. A few lines above there is
> the same loop as a workaround for something. This is the same loop. I
> could merge the loop + warning if you prefer. to have those things in
> one place. I could also just increment i. Merging the two loops might
> be better.

The other loop is for handling the ERRATA i541 and the two loops can no=
t be
merged since the errata handling also require to change in SYSCONFIG re=
gister.

>=20
>>> +				break;
>>> +			udelay(5);
>>> +		} while (1);
>>> +
>>> +		if (val & (CCR_RD_ACTIVE | CCR_WR_ACTIVE))
>>
>> if (i > 100) ?
>=20
> While that would work, too I think it is more explicit to the reader =
if
> you check for the condition that is important to you.

Yeah, I see that the errata handling is doing the same, fine by me.

>>> +			dev_err(c->vc.chan.device->dev,
>>> +				"DMA drain did not complete on lch %d\n",
>>> +				c->dma_ch);
>>>  	}
>>> =20
>>>  	mb();
>=20
> Sebastian
>=20


--=20
P=E9ter
