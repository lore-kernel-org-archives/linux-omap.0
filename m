From: "Dr. H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: DSS display-new custom enable/disable hooks
Date: Wed, 25 Sep 2013 18:11:06 +0200
Message-ID: <A88E32D7-26DC-4E22-A30D-098F174EB896@goldelico.com>
References: <CAAfyv349Xjt7Wy-R34OW81SzmUX-1WhfVZdbhWVDoOXpUKa9ug@mail.gmail.com> <52427ECA.1080500@ti.com> <CAAfyv37sSa=7x=p1wgX+Rhdxh=WMB4DhmC9ZQMpxB_rb30Aurw@mail.gmail.com> <3A4BA9B4-262C-4F0A-95B7-D243065D01BA@goldelico.com> <52429F06.6030609@ti.com> <307BD8A2-738A-4A66-8FD5-98C37AD4BCA3@goldelico.com> <5242BFEA.1090200@ti.com> <9172D29D-118B-4B6F-A454-BD359C5D97D4@goldelico.com> <5242EBB7.2090006@ti.com>
Mime-Version: 1.0 (Apple Message framework v1085)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:33824 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755923Ab3IYQLL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Sep 2013 12:11:11 -0400
In-Reply-To: <5242EBB7.2090006@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, Belisko Marek <marek.belisko@gmail.com>

Hi Tomi,

Am 25.09.2013 um 15:57 schrieb Tomi Valkeinen:

> On 25/09/13 15:26, Dr. H. Nikolaus Schaller wrote:
> 
>>> Sure, but the gpio is not related to the connector, it's related to
>>> another component.
>> 
>> I would see it as a part of the interface.
> 
> I don't know what you mean here with "interface".

interface = set of mechanical, electrical and logical definitions so that two components can be connected and work together for communication

Here I refer mostly to the signals coming out / going into the DM3730 chip.

> 
>> But why should we hesitate to solve an existing problem because there could
>> arrive a not-yet existing one of low likelihood?
> 
> Even if a solution works, but is clearly not correct in design-sense, I
> don't want to merge it. Why? In the future, if and when the wrong
> solution creates problems, somebody needs to fix it. Who'll it be? Yes,
> me, the maintainer of the software. And so I want to avoid merging
> anything that I know might cause problems in the future.

Yes, I understand that and therefore we discuss it before we expect that
you accept any code.

> 
>>> And I disagree that it's a simple problem =). Making generic, reusable
>>> drivers is not simple.
>>> Making a hack to make it work on your particular
>>> platform and board is simple, though.
>> 
>> But could be a good starting point until someone else has a real need for
>> a different solution :)
> 
> Well, see my comment above about who'll need to fix it =). Even if we
> don't find a good solution, and merge the hack, I want first to try to
> find a good solution.
> 
>> Anyways the connector-analog-tv is really new in the kernel and we are probably
>> the first ones who try to use it in real life.
> 
> Possibly. I did try it with Beagle, if I recall right, but I guess it's
> maybe the simplest possible hardware setup.
> 
>>>> Could we just add a "enable_ac" and "enable_bypass"  to struct connector_atv_platform_data,
>>>> that sets/resets these flags in the DEVCONF1 register each time the tvout is enabled?
>>> 
>>> No, those are properties of the SoC, as far as I understand, nothing to
>>> do with the connector.
>> 
>> Hm. I again get the impression that we have a different view on what a "connector" is.
> 
> "Connector" here means the physical component that is the
> S-video/composite connector, to which the cable is connected. In this
> case it doesn't really do much at all, but we have a driver for it
> because the display device model requires it. We need a kind of
> "terminator" at the end of the video pipeline, and that is either a
> panel driver or a connector driver.

Hm. I a not sure if this model is complete if it ends at the physical connector.
But that would be a different topic.

> Let me describe how DVI works on Beagle/Panda, to give a better example.
> We have the following components, arrows showing the dataflow:
> 
> DPI -> TFP410 -> DVI connector
> 
> DPI is the DPI encoder in the SoC's DSS. TFP410 takes DPI input, and
> outputs DVI. And DVI connector represents the physical connector on the
> board.

Ok!

> We have drivers for each of those components, and they handle things
> related only to that particular component:
> 
> - DPI driver handles programming the DPI registers on the SoC, and any
> regulators required to power the DPI encoder.

Ok!

> 
> - TFP410 driver handles power-down GPIO to enable/disable TFP410, and
> regulators related to it.

Ok!

> 
> - DVI connector driver uses i2c to read the EDID from the monitor, and
> also supplies the required +5V to the DVI connector. It could also
> handle hotplug detection.

Ah, I start to understand the way how you are thinking: a signal-transformation
pipeline starting with the framebuffer RAM and ending with something we can see.

This is much more fine grained than I had expected.

> Each driver should only be concerned about things related to that
> particular component. For example, you could change the SoC, you could
> change the TFP410, but DVI connector would still be the same.
> 
>> For me "the connector" that should be seen in kernel code are the analog video
>> outputs of the SoC (i.e. TVOUT1, TV_VFB1, TV_OU2, TV_VFB2). Not the physical
>> one going to some TV screen or other video signal consumer outside the board.
>> 
>> Like with UARTs. They are not drivers for a 9 or 25 pin socket. And there may be
>> a level shifetr chip in between that the software does not see.
> 
> Right. For UART, it works. For display, we have so complex video
> pipelines that such a simple model does not work.
> 
> Of course, if the video pipeline has so trivial components that require
> no control and no regulators, well, I don't see a need to have drivers
> for those.

Ok!

> 
>>> Although I have to say I have no idea what "TV AC
>>> coupled load enable" or "Active high enable AVDAC TV out bypass" do.
>>> 
>>> I guess I need to refresh my memory on the VENC, although if I recall
>>> right, it wasn't explained very well in the TRM.
>> 
>> There is a post-amplifier stage right after the Video DAC on the DM3730 chip
>> and these bits we discuss control some electrical properties of that post-amplifier.
>> 
>> I.e. bypass means that it is turned off and the VDAC signal is directly fed to the
>> output pin.
>> 
>> Section 7.2.3 and 7-58 to 7-61 depict this.
> 
> Yep, I see it, but I don't understand it =). As I said, I'm not familiar
> with analog TV signal, and I'm a SW guy.
> 
> Let me put it this way: In your case, there's the following video pipeline:
> 
> VENC -> OPA -> Connector
> 
> Here VENC is part of the SoC's DSS, and OPA and connector are external
> components on the board.

Well, I understand it that way:

RAM -> DISPC -> Video Encoder -> DAC-Stage (the DAC and an output amplifier within the OMAP chip) -> OMAP pins -> external amplifier (OPA) -> physical Connector -> cable -> TVset connector -> some more processing -> panel/screen -> Consumer

or simplified to the most important parts:

DISPC -> Video Encoder -> DAC-Stage -> external amplifier -> physical Connector

the external amplifier is something specific to our board so that we have to insert it into the pipeline.

As you said above, if it would not have any controls we wouldn't have to care about it. But it needs to be enabled/disabled.

The other controls are:

"Bypass" means to bypass something in the DAC-Stage
"AC" means to modify the DAC-Stage output level.
"Invert" is probably a property of the VENC or could also be part of the DAC stage (I don't know).

BTW: I have seen a CAUTION block that describes in the last section how some registers
must be set to avoid current leakage. That should be done (if not yet) in the suspend
code.

> VENC outputs a video signal, and obviously any register changes required
> which affect the signal need to be done directly or indirectly by the
> VENC driver.
> 
> If OPA requires an inverted signal, it's between VENC and OPA to handle
> that. Connector is not involved.

So we are not really missing an OPA362 driver but the DAC Stage driver within the DM3730 SoC.

And a mechanism that enabling/disabling the "tv" display automatically enables/disables
all those stages + including an external OPA362.

This raises some questions: So how can such a pipeline be individually set up
by platform data? How does enable/disable work along the chain?

The OPA itself then should also participate in suspend/resume. Well, that
would be something important for proper power management. Only then
we can make sure the OPA is disabled correctly.

But then I would not call it opa362 driver but "external-video-amplifier"
with an enable-gpio that can be defined in the platform data or -1 if it is not
required. In the latter case the driver simply does nothing functional.

> The question here is how to handle the above. Should OPA driver request
> VENC driver to invert the signal? Or should VENC driver just be passed
> parameters from the board code making it invert the signal?

Well, I think that it is the responsibility of those who have designed such a
board and they have to configure the drivers for each pipeline stage in a
consistent way (i.e. if one is inverted the other should be as well, unless
they want to see an inverted signal).

Your idea of the OPA driver notifying the VENC driver would introduce an
information flow that does not exist at all in hardware. I.e. there is no "invert me"-wire
in either direction. And that inversion could even happen behind the connector...

They are both defined and set to a fixed state once by the board designer.

> This is
> something I don't have an answer, and I've been wondering about this
> design question for other video interfaces also.
> 
> In both cases the VENC driver needs somehow get the DEVCONF1 register to
> be changed. For that we need some support from the core platform code,
> probably a function pointer in the DSS platform data, similar to, say
> "dsi_enable_pads".

Yes, that sounds reasonable.

> Or alternatively (but not so nicely), if there's no need to change the
> DEVCONF1 bits during normal operation, the DEVCONF1 could be configured
> once at boot time (although I don't know how to do that with DT boot),
> and it would be considered as a fixed setting.

Well, for the moment (before the DAC stage driver exists) we can try to
do that in the board_init function. We don't use the DT yet.

> Sometimes the latter approach is ok, but I dislike hardcoding things
> like that, as more often than not, it is a problem at some point in the
> future. Here, with analog TV out, I presume nobody will be using it in
> the future so perhaps it's not a problem =).
> 
>>> Also, note that drivers cannot touch DEVCONF1 register. That can only be
>>> touched by the OMAP's platform code.
>> 
>> Ah, I see.
>> 
>> That may be one of the reasons why it did end up in our 2.6.32 board file,
>> because there we know that it is an OMAP3 and can directly read/write registers.
>> 
>> But I wonder how drivers access the DISPC to modify e.g. sync polarity or
>> the video timing?
> 
> DISPC is handled by the DISPC driver (i.e. omapdss driver).
> 
>> Is this also an API exposed by the OMAP core driver or is it part of the DSS
>> drivers? So somewhere in the complex thing someone must know the
>> register address and be able to write to it.
> 
> DEVCONF1 is part of the CONTROL block, which is a core part of OMAP.
> DISPC is part of DSS block, which is not considered to be part of OMAP
> core. The idea here is that, in theory, the same DSS could be used in
> some other SoC, which has different methods to manage the things
> DEVCONF1 does.
> 
> So the DSS driver can just touch the DSS registers. Changing DEVCONF1
> must happen indirectly in a platform independent way.

Ah, I see.

> I think the rest of the comments in your email were more about our
> different understanding of what connector here means and of the display
> driver model in general. If there's something unclear, and I didn't
> answer to it, just ask again.

I think I have now understood your way of thinking. And the TFP410 example
is very similar. So an inverting analog amplifier is similar to an digital "encoder"
driver...

> 
>> Hm. Indeed diffiicult for an apparently simple problem and I hadn't expected
>> that it gets so a long discussion :) But really good solutions need that before.
> 
> Well, video is complex. People always think video is simple =). And the
> case here is even of the simpler ones. Just think about DSI bus with
> encoders with multiple inputs or outputs, and the complexity goes
> through the roof...

Now how can we proceed?

For the moment we could try to get the DEVCONF1 setup into the board_init
until a DAC Stage driver and some platform independent API for DEVCONF1
modifications exists.

For the external amplifier (OPA362) enable, we can write a simple driver (it just
needs to control a GPIO whose number is passed from the platform data).

What I don't know is how such a driver should be integrated into the pipeline
and by which means it gets notified that the "tv" display is enabled/disabled/suspended/resumed.
Or does it simply receive its individual enable/disable calls?

And is this similar to configuring and running the TFP410 driver? Then, we could
try to take parts of that driver.

And if I understand the TFP410 -> DVI example correctly such drivers are chained
and share the same video timings (even if they are not relevant for a specific stage)?

BR,
Nikolaus

