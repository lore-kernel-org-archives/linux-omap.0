From: "Dr. H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: DSS display-new custom enable/disable hooks
Date: Wed, 25 Sep 2013 14:26:30 +0200
Message-ID: <9172D29D-118B-4B6F-A454-BD359C5D97D4@goldelico.com>
References: <CAAfyv349Xjt7Wy-R34OW81SzmUX-1WhfVZdbhWVDoOXpUKa9ug@mail.gmail.com> <52427ECA.1080500@ti.com> <CAAfyv37sSa=7x=p1wgX+Rhdxh=WMB4DhmC9ZQMpxB_rb30Aurw@mail.gmail.com> <3A4BA9B4-262C-4F0A-95B7-D243065D01BA@goldelico.com> <52429F06.6030609@ti.com> <307BD8A2-738A-4A66-8FD5-98C37AD4BCA3@goldelico.com> <5242BFEA.1090200@ti.com>
Mime-Version: 1.0 (Apple Message framework v1085)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:29311 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752428Ab3IYM0j convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Sep 2013 08:26:39 -0400
In-Reply-To: <5242BFEA.1090200@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, Belisko Marek <marek.belisko@gmail.com>

Hi Tomi,

Am 25.09.2013 um 12:50 schrieb Tomi Valkeinen:

> On 25/09/13 12:00, Dr. H. Nikolaus Schaller wrote:
> 
>>> Well, OPA is a distinct hardware block in the video path, I see no issue
>>> in having an OPA encoder driver, that sits in between VENC and the
>>> connector.
>>> 
>>> The driver should handle things described in the OPA datasheet. With a
>>> quick glance, there seems to be one GPIO and one power line to OPA.
>> 
>> Hm. Why need a driver for a specific piece of hardware? For software it is just an
>> analog TV out with additional control options.
> 
> I'm not sure I follow. Linux device drivers are drivers for specific
> pieces of hardware. If the hardware needs to be controlled somehow, like
> setting gpios, enabling regulators, then we need a driver for that piece
> of hardware.

> 
>> And, it must not be the OPA362 - it could be something completely different.
> 
> Right. If it's something completely different, then you need a driver
> for the completely different piece of hardware. At the board code, or
> board's device tree data, you specify which pieces of hardware you have
> on your board, and the respective drivers are then used

> 
>>> So, is the GPIO the one that goes to OPA?
>> 
>> Yes. Like the enable_gpio in struct panel_dpi_platform_data.
>> 
>> So I now think we would be happy if the connector-analog-tv would have a gpio
>> in its platform data that can handle such an enable/disable.
> 
> Sure, but the gpio is not related to the connector, it's related to
> another component.

I would see it as a part of the interface.

> And say, if we added the enable gpio to the
> connector. What if the next board uses another version of OPA that
> requires two gpios. Should we then add another gpio to the connector?
> Maybe third also? How about a bunch of regulators? Where does it end?

Yes. Because we did have this already for the LCD panels (before display-new)
and it was reduced in the latest updates to a single gpio for reasons I don't know.

But why should we hesitate to solve an existing problem because there could
arrive a not-yet existing one of low likelihood?

> 
>>> The DEVCONF1 register is problematic. For that we need some kind of
>>> platform hooks. We have some already for PM and DSI pins, so we could
>>> add a new one for TV-out. However, the DSI pins (hopefully) could be
>>> handled by the pinmuxing framework. Maybe that would be applicable here
>>> also.
>> 
>> Hm. Looks like a complex solution for a simple problem and isn't related to
>> pinmuxing (IMHO).
> 
> Right, I only suggested pinmuxing as that's why we need the callback for
> DSI. I don't remember the details about DEVCONF1 and tv-out.
> 
> And I disagree that it's a simple problem =). Making generic, reusable
> drivers is not simple.
> Making a hack to make it work on your particular
> platform and board is simple, though.

But could be a good starting point until someone else has a real need for
a different solution :)

And in my view our "hack" would just be an add-on, not removing any existing
functionality. I.e. all those who were happy with the existing solution will be
as well in the future.

The only conflict I currently see is that if they don't initialize the enable_gpio to -1
and happen to have a gpio #0 there would be an initialization problem.

Anyways the connector-analog-tv is really new in the kernel and we are probably
the first ones who try to use it in real life.

> 
>> Could we just add a "enable_ac" and "enable_bypass"  to struct connector_atv_platform_data,
>> that sets/resets these flags in the DEVCONF1 register each time the tvout is enabled?
> 
> No, those are properties of the SoC, as far as I understand, nothing to
> do with the connector.

Hm. I again get the impression that we have a different view on what a "connector" is.

For me "the connector" that should be seen in kernel code are the analog video
outputs of the SoC (i.e. TVOUT1, TV_VFB1, TV_OU2, TV_VFB2). Not the physical
one going to some TV screen or other video signal consumer outside the board.

Like with UARTs. They are not drivers for a 9 or 25 pin socket. And there may be
a level shifetr chip in between that the software does not see.

> Although I have to say I have no idea what "TV AC
> coupled load enable" or "Active high enable AVDAC TV out bypass" do.
> 
> I guess I need to refresh my memory on the VENC, although if I recall
> right, it wasn't explained very well in the TRM.

There is a post-amplifier stage right after the Video DAC on the DM3730 chip
and these bits we discuss control some electrical properties of that post-amplifier.

I.e. bypass means that it is turned off and the VDAC signal is directly fed to the
output pin.

Section 7.2.3 and 7-58 to 7-61 depict this.

> Also, note that drivers cannot touch DEVCONF1 register. That can only be
> touched by the OMAP's platform code.

Ah, I see.

That may be one of the reasons why it did end up in our 2.6.32 board file,
because there we know that it is an OMAP3 and can directly read/write registers.

But I wonder how drivers access the DISPC to modify e.g. sync polarity or
the video timing?

Is this also an API exposed by the OMAP core driver or is it part of the DSS
drivers? So somewhere in the complex thing someone must know the
register address and be able to write to it.

> So there has to be some kind of
> callback or API to do that. And while the display drivers for OMAP are
> currently OMAP specific, they will be made generic at some point, and
> actually are already designed to be so. So they may not contain any
> OMAP'isms.
> 
>> I think this would be very similar to the "invert_polarity" property.
> 
> I have to say that I don't quite remember what the invert_polarity is
> used for, but I think invert_polarity might be misplaced also. Is the
> analog video signal that goes out from the connector inverted? I don't
> think so. Does the connector require an inverted signal? No, as the
> connector is really nothing else than a pass-though connector.

Hm. Could you define the word "connector" here? Do you mean the
physical plug (S-Video socket or RCA/Chinch composite video)?

Or a logical connector (i.e. the DM3730 port ignoring the hardware
that may come behind until we end at some physical connector)?

> 
> Correct me if I'm wrong, but I think the invert_polarity is required if
> there's something on the board that requires the signal to be inverted
> (OPA?), and it'll be re-inverterted before the signal goes to the analog
> connector.

Yes. There can be three different hardware designs. One with an inverting
amplifier (like we have) and some without. And some without any amplifier
(AFAIK like the Beagle Board).

Depending on that, they need AC-Bias, invert and bypass or don't to
create a standards compliant composite video signal.

Apparently this should be configured through some platform data, because
it is board specific - but there is no reasonable need to switch it during
operation.

> 
>> Then, the platform data has more control over the shape of the signals created by
>> the VENC (independently of that we use an OPA362).
>> 
>> IMHO this topic is very similar to controlling the polarity and timing of the
>> HSYNC/VSYNC of a LCD (.flags in struct display_timing), i.e. shaping the
>> interface signals so that they are accepted by the hardware connected to
>> the DM3730.
> 
> Well, I was never too well into the analog TV-out side, so please argue
> if I say something silly here. But generally speaking, there are two
> different kinds of properties here.
> 
> Consider DPI output from the SoC, and a DPI panel. Let's say the DPI
> panel requires horizontal sync signal to be active high. It's a property
> of the panel, and it makes sense (at least to me) to think that the DPI
> panel asks the DPI encoder to provide a signal with hsync active high.

Yes. I don't see much difference to connecting a video amplifier to the VENC
output pins from connecting a panel to the DSS output pins and configuring
them. They need some specific signal shapes.

> Also, it doesn't matter what kind of DPI encoder there is, the hsync
> active high is a "universal" property.

Yes and therefore I would suggest to see inverted, ac-bias, bypass as
such "universal" properties of the VENC driver.

> Then, let's say the board has some electrical issues and requires the
> DPI signals to be of slightly higher voltage than normally. I think OMAP
> at least has bits to driver some pins with higher voltage.

I think an even better example would be a panel that requires 3.3V I/O
levels instead of the 1.8V levels the DM3730 provides.

Now there could be some scenarios:
a) the DM3730 were able to be switched to provide either 1.8V or 3.3V (like on
the MMC interface)
b) In such a case one would add some level shifter chips (that usually don't
invert anything) and there is no need to switch anything by software
c) there could be level shifters that invert all signals. Then, there would be
need for a different control bit in the DM3730.

But in practice the DM3730 has no control for that at all and there are no
inverting level shifter chips. So software doesn't see these options at all.

> This property
> is not about panel.

Well, it would be imposed by choosing a specific panel - either a 1.8V or
a 3.3V model. So I'd argue that from platform data point of view it is no
difference to specifying different hsync polarity or front porch timing. All
those are found and defined in the panel data sheet.

> There could be lots of different kinds of tweaks for
> different SoCs, and they are SoC (or DPI encoder) specific things. Here
> is makes no sense to have a property for the panel.

Yes, as long as the hardware does a modification that is transparent (i.e. no
change in logic) to the software, it does not need a control...

> To me, enable_ac and enable_bypass sound like the latter kind.

But the controls are part of the DM3730 and not our external hardware. I.e. they
should IMHO be part of the set of the DM3730 drivers and not a separate
one related to our hardware around. It is of course our hardware that asks
to modify the DM3730 settings during boot or operation.

Hm. Indeed diffiicult for an apparently simple problem and I hadn't expected
that it gets so a long discussion :) But really good solutions need that before.

BR,
Nikolaus


