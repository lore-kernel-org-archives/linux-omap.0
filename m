From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [RFC v2] dmaengine: omap-dma: Start DMA without delay for cyclic
 channels
Date: Wed, 3 Apr 2013 13:52:25 +0200
Message-ID: <515C17F9.4040300@ti.com>
References: <1364987862-14597-1-git-send-email-peter.ujfalusi@ti.com> <515C117A.6060700@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <515C117A.6060700@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <djbw@fb.com>, Tony Lindgren <tony@atomide.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Felipe Balbi <balbi@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Peter Meerwald <pmeerw@pmeerw.net>
List-Id: linux-omap@vger.kernel.org

On 04/03/2013 01:24 PM, Santosh Shilimkar wrote:
> On Wednesday 03 April 2013 04:47 PM, Peter Ujfalusi wrote:
>> cyclic DMA is only used by audio which needs DMA to be started witho=
ut a
>> delay.
>> If the DMA for audio is started using the tasklet we experience rand=
om
>> channel switch (to be more precise: channel shift).
>>
>> Reported-by: Peter Meerwald <pmeerw@pmeerw.net>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>> Hi Russell,
>>
>> Instead of removing the tasklet we can identify the DMA channel used=
 by audio
>> based on the cyclic flag of the channel.
>> I think this can be used as a short term solution to fix the audio c=
hannel shift
>> issue and later when we have the dynamic DMA channel allocation we c=
an adjust
>> the code.
>>
>> Regards,
>> Peter
>>
>>  drivers/dma/omap-dma.c | 20 ++++++++++++++------
>>  1 file changed, 14 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
>> index 2ea3d7e..ec3fc4f 100644
>> --- a/drivers/dma/omap-dma.c
>> +++ b/drivers/dma/omap-dma.c
>> @@ -282,12 +282,20 @@ static void omap_dma_issue_pending(struct dma_=
chan *chan)
>> =20
>>  	spin_lock_irqsave(&c->vc.lock, flags);
>>  	if (vchan_issue_pending(&c->vc) && !c->desc) {
> If you add "!c->cyclic" in above if then you can avoid
> indentation change and just have else for cyclic case.

It can not be embedded there because of the existing tests. How would w=
e
handle the case when c->desc is _not_ NULL and c->cyclic is false? We w=
ould
need to test again in else, but we can not do this for the
vchan_issue_pending(&c->vc).

>=20
>> -		struct omap_dmadev *d =3D to_omap_dma_dev(chan->device);
>> -		spin_lock(&d->lock);
>> -		if (list_empty(&c->node))
>> -			list_add_tail(&c->node, &d->pending);
>> -		spin_unlock(&d->lock);
>> -		tasklet_schedule(&d->task);
>> +		/*
>> +		 * c->cyclic is used only by audio and in this case the DMA need
>> +		 * to be started without delay.
>> +		 */
>> +		if (!c->cyclic) {
>> +			struct omap_dmadev *d =3D to_omap_dma_dev(chan->device);
>> +			spin_lock(&d->lock);
>> +			if (list_empty(&c->node))
>> +				list_add_tail(&c->node, &d->pending);
>> +			spin_unlock(&d->lock);
>> +			tasklet_schedule(&d->task);
>> +		} else {
>> +			omap_dma_start_desc(c);
>> +		}
>>  	}
>>  	spin_unlock_irqrestore(&c->vc.lock, flags);
>>  }
>>
>=20


--=20
P=E9ter
