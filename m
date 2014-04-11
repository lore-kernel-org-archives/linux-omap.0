From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 05/14] arm: common: edma: Select event queue 1 as
 default when booted with DT
Date: Fri, 11 Apr 2014 15:12:17 +0530
Message-ID: <20140411094217.GA32284@intel.com>
References: <1396357575-30585-1-git-send-email-peter.ujfalusi@ti.com>
 <1396357575-30585-6-git-send-email-peter.ujfalusi@ti.com>
 <5347A4FD.1030803@ti.com>
 <5347ACDE.7040407@ti.com>
 <5347AE49.5020109@ti.com>
 <5347B7F8.2000508@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:55333 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754151AbaDKJvh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Apr 2014 05:51:37 -0400
Content-Disposition: inline
In-Reply-To: <5347B7F8.2000508@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Sekhar Nori <nsekhar@ti.com>, dan.j.williams@intel.com, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, joelf@ti.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, davinci-linux-open-source@linux.davincidsp.com, mporter@linaro.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.de>

On Fri, Apr 11, 2014 at 12:38:00PM +0300, Peter Ujfalusi wrote:
> On 04/11/2014 11:56 AM, Sekhar Nori wrote:
> > On Friday 11 April 2014 02:20 PM, Peter Ujfalusi wrote:
> >> On 04/11/2014 11:17 AM, Sekhar Nori wrote:
> >>> On Tuesday 01 April 2014 06:36 PM, Peter Ujfalusi wrote:
> >>>> Use the EVENTQ_1 for default and leave the EVENTQ_0 to be used b=
y high
> >>>> priority channels, like audio.
> >>>>
> >>>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> >>>
> >>> Acked-by: Sekhar Nori <nsekhar@ti.com>
> >>>
> >>>> ---
> >>>>  arch/arm/common/edma.c | 3 ++-
> >>>>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/arch/arm/common/edma.c b/arch/arm/common/edma.c
> >>>> index 86a8b263278f..19520e2519d9 100644
> >>>> --- a/arch/arm/common/edma.c
> >>>> +++ b/arch/arm/common/edma.c
> >>>> @@ -1546,7 +1546,8 @@ static int edma_of_parse_dt(struct device =
*dev,
> >>>> =20
> >>>>  	pdata->queue_priority_mapping =3D queue_priority_map;
> >>>> =20
> >>>> -	pdata->default_queue =3D 0;
> >>>> +	/* select queue 1 as default */
> >>>
> >>> It will be nice to expand the comment with explanation of why thi=
s is
> >>> being chosen as default (lower priority queue by default for typi=
cal
> >>> bulk data transfer).
> >>
> >> Yes, extended comment is a good idea.
> >>
> >> For the next version I think I'm going to change the code around d=
efault
> >> TC/Queue and the non default queue selection, mostly based on Joel=
's comment:
> >>
> >> EVENTQ_1 as default queue.
> >> Set the EVENTQ_1 priority to 7
> >> EVENTQ_0 priority is going to stay 0 and EVENTQ_2 as 2
> >>
> >> Add new member to struct edma, like high_pri_queue.
> >> When we set the queue priorities in edma_probe() we look for the h=
ighest
> >> priority queue and save the number in high_pri_queue.
> >>
> >> I will rename the edma_request_non_default_queue() to
> >> edma_request_high_pri_queue() and it will assign the channel to th=
e high
> >> priority queue.
> >>
> >> I think this way it is going to be more explicit and IMHO a bit mo=
re safer in
> >> a sense the we are going to get high priority when we ask for it.
> >=20
> > Sounds much better. I had posted some ideas about adding support fo=
r
> > channel priority in the core code but we can leave that for Vinod a=
nd
> > Dan to say if they really see a need for that.
Is it part of this series?

> If we do it via the dmaengine core I think it would be better to have=
 a new
> flag to be passed to dmaengine_prep_dma_*().
> We could have for example:
> DMA_PREP_HIGH_PRI as flag to indicate that we need high priority DMA =
if it is
> possible.
> We can watch for this flag in the edma driver and act accordingly.
> ALSA's dmaengine_pcm_prepare_and_submit() could set this flag uncondi=
tionally
> since audio should be treated in this way if the DMA IP can do this.
Will the priority be different for each descriptor or would be based on=
 channel
usage. If not then we can add this in dma_slave_config ?

I can forsee its usage on slave controllers, so yes its useful :)

--=20
~Vinod

>=20
> Not sure what to do with eDMA's 8 priority level. With that we could =
have high
> priority; low priority; low, but not the lowest priority; about in th=
e middle
> priority; etc.
>=20
> We could have also new callback in the dma_device struct with needed =
wrappers
> to set priority level, but where to draw the range? High, Mid and Low=
? Range
> of 0 - 10?
>=20
> --=20
> P=E9ter

--=20
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
