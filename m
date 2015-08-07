From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] dma: omap-dma: add support for pause of non-cyclic transfers
Date: Fri, 07 Aug 2015 14:47:39 +0200
Message-ID: <55C4A8EB.3040301@linutronix.de>
References: <1438936917-7254-1-git-send-email-bigeasy@linutronix.de> <55C47DE1.9020902@ti.com> <55C48A1E.3070007@linutronix.de> <55C49A0D.10600@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55C49A0D.10600@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, Vinod Koul <vinod.koul@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, john.ogness@linutronix.de, Russell King <rmk+kernel@arm.linux.org.uk>
List-Id: linux-omap@vger.kernel.org

On 08/07/2015 01:44 PM, Peter Ujfalusi wrote:
>>>> Cc: <stable@vger.kernel.org>
>>>
>>> Why stable? This is not fixing any bugs since the PAUSE was not allowed for
>>> non cyclic transfers.
>>
>> Hmmm. The DRA7x was using pause before for UART. I just did not see it
>> coming that it was not allowed here. John made a similar change to the
>> edma driver and I assumed it went stable but now I see that it was just
>> cherry-picked into the ti tree.
>> If you are not comfortable it being stable material I can drop it.
> 
> This change is needed for the UART DMA support if I'm not mistaken and this
> mode is not really supported by older kernels, so having this to implement
> something which is not going to be used in the stable kernels feels somehow wrong.

We have the DT pieces since v3.19-rc1. And if I remember correctly I
tested this on am335x-evm and dra7-evm by I the time I posted the
patches. I agree that dra7 support was not the best back then but I am
almost sure that I had vanilla running for testing.
But I don't insist on the stable tag. Consider it dropped.

>>>> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>>>> ---
>>>>  drivers/dma/omap-dma.c | 54 ++++++++++++++++++++++++++++++++++++++------------
>>>>  1 file changed, 41 insertions(+), 13 deletions(-)
>>>>
>>>> diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
>>>> index 249445c8a4c6..6b8497203caf 100644
>>>> --- a/drivers/dma/omap-dma.c
>>>> +++ b/drivers/dma/omap-dma.c
>>>> @@ -299,7 +299,7 @@ static void omap_dma_start(struct omap_chan *c, struct omap_desc *d)
>>>>  	omap_dma_chan_write(c, CCR, d->ccr | CCR_ENABLE);
>>>>  }
>>>>  
>>>> -static void omap_dma_stop(struct omap_chan *c)
>>>> +static int omap_dma_stop(struct omap_chan *c)
>>>>  {
>>>>  	struct omap_dmadev *od = to_omap_dma_dev(c->vc.chan.device);
>>>>  	uint32_t val;
>>>> @@ -342,8 +342,26 @@ static void omap_dma_stop(struct omap_chan *c)
>>>>  
>>>>  		omap_dma_glbl_write(od, OCP_SYSCONFIG, sysconfig);
>>>>  	} else {
>>>> +		int i = 0;
>>>> +
>>>> +		if (!(val & CCR_ENABLE))
>>>> +			return -EINVAL;
>>>> +
>>>>  		val &= ~CCR_ENABLE;
>>>>  		omap_dma_chan_write(c, CCR, val);
>>>> +		do {
>>>> +			val = omap_dma_chan_read(c, CCR);
>>>> +			if (!(val & (CCR_RD_ACTIVE | CCR_WR_ACTIVE)))
>>>> +				break;
>>>> +			if (i > 100)
>>>
>>> if (++i > 100)
>>> 	break;
>>> to avoid infinite loop?
>>
>> Ah. So I forgot to increment the counter. A few lines above there is
>> the same loop as a workaround for something. This is the same loop. I
>> could merge the loop + warning if you prefer. to have those things in
>> one place. I could also just increment i. Merging the two loops might
>> be better.
> 
> The other loop is for handling the ERRATA i541 and the two loops can not be
> merged since the errata handling also require to change in SYSCONFIG register.

yes, but I had in mind is to put the loop into one function so we gain:

+static void omap_dma_drain_chan(struct omap_chan *c)
+{
+       int i;
+       uint32_t val;
+
+       /* Wait for sDMA FIFO to drain */
+       for (i = 0; ; i++) {
+               val = omap_dma_chan_read(c, CCR);
+               if (!(val & (CCR_RD_ACTIVE | CCR_WR_ACTIVE)))
+                       break;
+
+               if (i > 100)
+                       break;
+
+               udelay(5);
+       }
+
+       if (val & (CCR_RD_ACTIVE | CCR_WR_ACTIVE))
+               dev_err(c->vc.chan.device->dev,
+                       "DMA drain did not complete on lch %d\n",
+                       c->dma_ch);
+}

which is invoked by both parts of the if case (handling the errata not
not) instead of having the same loop twice.

>>>> +				break;
>>>> +			udelay(5);
>>>> +		} while (1);
>>>> +
>>>> +		if (val & (CCR_RD_ACTIVE | CCR_WR_ACTIVE))
>>>
>>> if (i > 100) ?
>>
>> While that would work, too I think it is more explicit to the reader if
>> you check for the condition that is important to you.
> 
> Yeah, I see that the errata handling is doing the same, fine by me.
good.

Sebastian
