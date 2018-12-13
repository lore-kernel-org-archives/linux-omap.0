From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/2] Graph fixes for using multiple endpoints per port
Date: Thu, 13 Dec 2018 08:55:58 -0800
Message-ID: <20181213165558.GO6707@atomide.com>
References: <20181211045220.GI6707@atomide.com>
 <871s6obqkb.wl-kuninori.morimoto.gx@renesas.com>
 <20181211053536.GJ6707@atomide.com>
 <87wooga9an.wl-kuninori.morimoto.gx@renesas.com>
 <20181211141649.GL6707@atomide.com>
 <87ftv33bpg.wl-kuninori.morimoto.gx@renesas.com>
 <20181212001950.GX6707@atomide.com>
 <01e3f547-318e-8988-b48a-e10c0a2904d6@ti.com>
 <20181212145022.GB6707@atomide.com>
 <34191403-3c56-47ac-77d9-e900d88f2ae5@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <34191403-3c56-47ac-77d9-e900d88f2ae5@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [181213 06:52]:
> On 12/12/2018 16.50, Tony Lindgren wrote:
> > * Peter Ujfalusi <peter.ujfalusi@ti.com> [181212 13:03]:
> >> On 12/12/2018 2.19, Tony Lindgren wrote:
> >>> In my McBSP case there is only a single physical I2S port
> >>> that can be TDM split into timeslots.
> >>
> >> So what is missing from the McBSP driver is to configure the TDM. We
> >> never had a hardware which would require it so it is _not_ implemented.
> > 
> > Curiously.. Nothing needs to be done in the McBSP driver for the droid
> > 4 TDM configuration AFAIK.
> 
> So you always have 4 timeslot and that's it?

No.. "droid 4", not "4 timeslot" above :)

See the McBSP3 parts of the diagram at [0]. The PMIC has
register bits for timeslots 0 to 2:

$ git grep CPCAP | grep TIMESLOT

> > The CPCAP PMIC is the clock master, and only the PMIC registers need to
> > be configured in this case for the timeslot to switch between codecs
> > connected to McBSP3.
> 
> The McBSP TDM configuration is not master only.
> You basically tell McBSP on which timeslot to transmit/receive.
> Let's say you have two codecs connected to a single McBSP.
> codec1 is configured to listen for timeslot 0/1
> codec2 is configured to listen for timeslot 2/3

OK. Right now I'm only configuring things at the PMIC
end as the clocking is different compared to using CPCAP
PMIC voice codec and when routing data from the MDM voice
call codec to the CPCAP PMIC.

> If you open a stereo stream to codec1 then you tell McBSP to
> send/receive the data under timeslot 0/1 and ignore any other timeslots.
> 
> If you open a stereo stream to codec2 then you tell McBSP to
> send/receive the data under timeslot 2/3 and ignore any other timeslots.
> 
> For codec1 you don't really need anything regarding to TDM configuration
> as McBSP will send/receive right after the start condition on the FS,
> but for codec2 you need to configure the TDM mode of McBSP to ignore
> timeslot 0/1

OK. Sounds like what you're describing could be used to route the
MDM voice codec audio for capture to a file via McBSP etc.

> >> imho the 'only' thing is to implement the set_tdm_slot callback for the
> >> McBSP DAI. In DT you would have single card with two dai_link section
> >> and each section would set different tdm slots to use for the codecs
> >> listening on different slots.
> >>
> >> There is one issue for sure with this setup: the two PCM can not be used
> >> at the same time. But we have one DMA channel so if you would open both
> >> the PCM stream need to be set up in a way to match with the HW or create
> >> a asound.conf file to do some mapping.
> > 
> > Yes in the droid 4 TDM case only one device can be used at a time
> > and all that configuration is done in the PMIC codec .set_tdm_slot
> > function.
> 
> Hrm, do you have two DAIs on the PMIC side or different timeslots from
> the TDM stream is routed to different outputs, similarly to twl6040
> where timeslot 0/1 is Headset, timeslot 2/3 is Handsfree and timeslot 5
> is to drive a vibra?

Two DAIs on the PMIC, one at McBSP2 and one shared with MDM codec
at McBSP3.

> > I think it's possible to do more complex configurations where McBSP
> > is the master and would implement a .set_tdm_slot function. But I
> > don't know anything about that and I'm not aware of any such use
> > cases in the mainline kernel.
> 
> No, the set_tdm_slot is applicable for both master and slave mode of McBSP.

OK sure.

Regards,

Tony

[0] https://lkml.org/lkml/2018/3/28/405
