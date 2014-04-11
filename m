From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 05/14] arm: common: edma: Select event queue 1 as
 default when booted with DT
Date: Fri, 11 Apr 2014 17:01:54 +0530
Message-ID: <20140411113154.GB32284@intel.com>
References: <1396357575-30585-1-git-send-email-peter.ujfalusi@ti.com>
 <1396357575-30585-6-git-send-email-peter.ujfalusi@ti.com>
 <5347A4FD.1030803@ti.com>
 <5347ACDE.7040407@ti.com>
 <5347AE49.5020109@ti.com>
 <5347B7F8.2000508@ti.com>
 <20140411094217.GA32284@intel.com>
 <5347D2CC.4030407@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5347D2CC.4030407@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Sekhar Nori <nsekhar@ti.com>, dan.j.williams@intel.com, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, joelf@ti.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, davinci-linux-open-source@linux.davincidsp.com, mporter@linaro.org, Mark Brown <broonie@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.de>
List-Id: linux-omap@vger.kernel.org

On Fri, Apr 11, 2014 at 02:32:28PM +0300, Peter Ujfalusi wrote:
> Hi Vinod,
>=20
> On 04/11/2014 12:42 PM, Vinod Koul wrote:
> > On Fri, Apr 11, 2014 at 12:38:00PM +0300, Peter Ujfalusi wrote:
> >> On 04/11/2014 11:56 AM, Sekhar Nori wrote:
> >>> On Friday 11 April 2014 02:20 PM, Peter Ujfalusi wrote:
> >>>> On 04/11/2014 11:17 AM, Sekhar Nori wrote:
> >>>>> On Tuesday 01 April 2014 06:36 PM, Peter Ujfalusi wrote:
> >>>>>> Use the EVENTQ_1 for default and leave the EVENTQ_0 to be used=
 by high
> >>>>>> priority channels, like audio.
> >>>>>>
> >>>>>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> >>>>>
> >>>>> Acked-by: Sekhar Nori <nsekhar@ti.com>
> >>>>>
> >>>>>> ---
> >>>>>>  arch/arm/common/edma.c | 3 ++-
> >>>>>>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>>>>>
> >>>>>> diff --git a/arch/arm/common/edma.c b/arch/arm/common/edma.c
> >>>>>> index 86a8b263278f..19520e2519d9 100644
> >>>>>> --- a/arch/arm/common/edma.c
> >>>>>> +++ b/arch/arm/common/edma.c
> >>>>>> @@ -1546,7 +1546,8 @@ static int edma_of_parse_dt(struct devic=
e *dev,
> >>>>>> =20
> >>>>>>  	pdata->queue_priority_mapping =3D queue_priority_map;
> >>>>>> =20
> >>>>>> -	pdata->default_queue =3D 0;
> >>>>>> +	/* select queue 1 as default */
> >>>>>
> >>>>> It will be nice to expand the comment with explanation of why t=
his is
> >>>>> being chosen as default (lower priority queue by default for ty=
pical
> >>>>> bulk data transfer).
> >>>>
> >>>> Yes, extended comment is a good idea.
> >>>>
> >>>> For the next version I think I'm going to change the code around=
 default
> >>>> TC/Queue and the non default queue selection, mostly based on Jo=
el's comment:
> >>>>
> >>>> EVENTQ_1 as default queue.
> >>>> Set the EVENTQ_1 priority to 7
> >>>> EVENTQ_0 priority is going to stay 0 and EVENTQ_2 as 2
> >>>>
> >>>> Add new member to struct edma, like high_pri_queue.
> >>>> When we set the queue priorities in edma_probe() we look for the=
 highest
> >>>> priority queue and save the number in high_pri_queue.
> >>>>
> >>>> I will rename the edma_request_non_default_queue() to
> >>>> edma_request_high_pri_queue() and it will assign the channel to =
the high
> >>>> priority queue.
> >>>>
> >>>> I think this way it is going to be more explicit and IMHO a bit =
more safer in
> >>>> a sense the we are going to get high priority when we ask for it=
=2E
> >>>
> >>> Sounds much better. I had posted some ideas about adding support =
for
> >>> channel priority in the core code but we can leave that for Vinod=
 and
> >>> Dan to say if they really see a need for that.
> > Is it part of this series?
>=20
> No, it is not. The original series tackled the DMA queue selection wi=
thin the
> edma driver stack. It was selecting high priority channel for cyclic =
(audio)
> use only, all other DMA channels were executed on a lower priority qu=
eue.
>=20
> >> If we do it via the dmaengine core I think it would be better to h=
ave a new
> >> flag to be passed to dmaengine_prep_dma_*().
> >> We could have for example:
> >> DMA_PREP_HIGH_PRI as flag to indicate that we need high priority D=
MA if it is
> >> possible.
> >> We can watch for this flag in the edma driver and act accordingly.
> >> ALSA's dmaengine_pcm_prepare_and_submit() could set this flag unco=
nditionally
> >> since audio should be treated in this way if the DMA IP can do thi=
s.
> >
> > Will the priority be different for each descriptor or would be base=
d on channel
> > usage.
>=20
> I would say that it is channel based config. I don't see the reason w=
hy would
> one mix different priorities on a configured channel between descript=
ors.
>=20
> > If not then we can add this in dma_slave_config ?
>=20
> So adding to the struct for example:
> bool high_priority;

In designware controller, we can have channel priorties from 0 to 7 whi=
ch IIRC 7
being highest. So bool wont work. unsigned int/u8 would be good. How ab=
out your
controller, is it binary?

--=20
~Vinod

>=20
> I'm not sure if it helps if we have let's say three priority level li=
ke, low,
> normal and high.
> I don't think that any client would ask for low priority instead usin=
g the
> normal priority.
>=20
> > I can forsee its usage on slave controllers, so yes its useful :)
>=20
> True I'm sure it is going to be used as soon as it is available if th=
e HW
> supports priorities.
>=20
> --=20
> P=E9ter

--=20
