From: "Dr. H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: DSS display-new custom enable/disable hooks
Date: Thu, 26 Sep 2013 13:01:08 +0200
Message-ID: <F101C925-6FA8-4813-955D-1B145FB2711E@goldelico.com>
References: <CAAfyv349Xjt7Wy-R34OW81SzmUX-1WhfVZdbhWVDoOXpUKa9ug@mail.gmail.com> <52427ECA.1080500@ti.com> <CAAfyv37sSa=7x=p1wgX+Rhdxh=WMB4DhmC9ZQMpxB_rb30Aurw@mail.gmail.com> <3A4BA9B4-262C-4F0A-95B7-D243065D01BA@goldelico.com> <52429F06.6030609@ti.com> <307BD8A2-738A-4A66-8FD5-98C37AD4BCA3@goldelico.com> <5242BFEA.1090200@ti.com> <9172D29D-118B-4B6F-A454-BD359C5D97D4@goldelico.com> <5242EBB7.2090006@ti.com> <A88E32D7-26DC-4E22-A30D-098F174EB896@goldelico.com> <5243EE61.3000408@ti.com>
Mime-Version: 1.0 (Apple Message framework v1085)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:50009 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756500Ab3IZLBN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Sep 2013 07:01:13 -0400
In-Reply-To: <5243EE61.3000408@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, Belisko Marek <marek.belisko@gmail.com>

Hi Tomi,

Am 26.09.2013 um 10:20 schrieb Tomi Valkeinen:

> On 25/09/13 19:11, Dr. H. Nikolaus Schaller wrote:
> 
>> Well, I understand it that way:
>> 
>> RAM -> DISPC -> Video Encoder -> DAC-Stage (the DAC and an output amplifier within the OMAP chip) -> OMAP pins -> external amplifier (OPA) -> physical Connector -> cable -> TVset connector -> some more processing -> panel/screen -> Consumer
>> 
>> or simplified to the most important parts:
>> 
>> DISPC -> Video Encoder -> DAC-Stage -> external amplifier -> physical Connector
> 
> Well, this brings up the question, how small parts is it necessary to
> split the pipeline.
> 
> For example, DISPC consists of multiple stages. In theory, we could
> model all those stages with individual SW entities. In practice, that
> doesn't really give us anything, they are always one whole entity, DISPC.
> 
> I think the same applies for VENC. There's no need to separate DAC from
> VENC, they are always one whole entity (as far as I see).

I agree.

> Now, you could argue that DISPC and VENC (and the other DSS components)
> also form one whole entity, the DSS. But here the difference is that we
> already have different versions of DSS, that have different components.
> Some don't have VENC, etc. But in all the different DSS versions, VENC
> and DAC go together.

So this essentially means that the "invert" property and the "bypass", "acen" properties
should be defined for the VENC (if it also controls the DAC-Stage).

I.e. I am not sure if invert is really a property (control) of the connector or an amplifier.

> 
>> the external amplifier is something specific to our board so that we have to insert it into the pipeline.
>> 
>> As you said above, if it would not have any controls we wouldn't have to care about it. But it needs to be enabled/disabled.
> 
> Note also that even if there weren't any controls (like gpios), the
> components usually require power. On one board the power could come from
> VBAT or some other "always on" source, but on some other, the regulator
> needs to be turned on. So even if there are no controls, there could be
> need for a driver.
> 
> That said, it feels a bit silly to have a driver, whose only function
> would be to turn on one regulator...

Yes, essentially it is - not through a regulator but an enable-GPIO.

> 
>> The other controls are:
>> 
>> "Bypass" means to bypass something in the DAC-Stage
>> "AC" means to modify the DAC-Stage output level.
>> "Invert" is probably a property of the VENC or could also be part of the DAC stage (I don't know).
>> 
>> BTW: I have seen a CAUTION block that describes in the last section how some registers
>> must be set to avoid current leakage. That should be done (if not yet) in the suspend
>> code.
> 
> Yes, I don't think we manage VENC very well at the moment.
> 
>>> VENC outputs a video signal, and obviously any register changes required
>>> which affect the signal need to be done directly or indirectly by the
>>> VENC driver.
>>> 
>>> If OPA requires an inverted signal, it's between VENC and OPA to handle
>>> that. Connector is not involved.
>> 
>> So we are not really missing an OPA362 driver but the DAC Stage driver within the DM3730 SoC.
> 
> As I said, I think we can consider DAC as part of VENC.

Ok.

> And I think we are really missing OPA362 driver. OPA requires someone to
> control the enable GPIO (and maybe the regulators), and OPA driver is
> the only logical place for those.
> 
>> And a mechanism that enabling/disabling the "tv" display automatically enables/disables
>> all those stages + including an external OPA362.
>> 
>> This raises some questions: So how can such a pipeline be individually set up
>> by platform data? How does enable/disable work along the chain?
> 
> The pipeline is setup in the board file. Each component is given
> component specific parameters, and the name of its source component.

Ok, I think I did understand it by looking into the DVI encoder and connector
setup in the beagle board boardfile.

> Enable/disable works "backwards". Omapfb (or some other component) calls
> enable on the last entity in the pipeline (connector in this case). The
> connector driver in turn calls enable on its source entity, which would
> be OPA. And so on.

This appears to fit exactly.

> 
>> The OPA itself then should also participate in suspend/resume. Well, that
>> would be something important for proper power management. Only then
>> we can make sure the OPA is disabled correctly.
> 
> There isn't really anything to suspend/resume on that level. If the
> display is enabled, it stays enabled, there's no automatic suspend. If
> there's a system suspend, omapfb (or similar component) will disable the
> displays.
> 
> So it's only about enable/disable on this level.

Ok. I think this is also sufficient since the OPA362 is in low power if it is
disabled. I.e. suspend and disable are the same.

Although one could argue that one is just controlling the GPIO and the other
one is controlling some regulator...

> 
>> But then I would not call it opa362 driver but "external-video-amplifier"
>> with an enable-gpio that can be defined in the platform data or -1 if it is not
>> required. In the latter case the driver simply does nothing functional.
> 
> Well, this is perhaps a bit about semantics, but it is a driver for
> OPA362 hardware. Sure, we can make a more generic driver if we see that
> there are other external amps that have very similar controls.

That was my assumption. Analog amplifiers just have an input and an output.
And can be powered on or off. This would imho fit 99% of all such amplifiers.
Well, one could think about switching different signal strenghts but this is AFAIK
not defined by the composite video standards.

> But it's
> still an OPA362 driver, but it would also be OPA123, OPA321, etc. driver.
> 
> Making it "external-video-amplifier" driver is probably taking it too
> far. We don't know what kind of amps there are. Maybe some are
> controlled via i2c. Dumping all the different functionality for
> different amps into one driver would just make one messy driver.

Ok, I will start to write an "amplifier-opa362.c" based on the "encoder-ftp410.c"
code.

> 
>>> The question here is how to handle the above. Should OPA driver request
>>> VENC driver to invert the signal? Or should VENC driver just be passed
>>> parameters from the board code making it invert the signal?
>> 
>> Well, I think that it is the responsibility of those who have designed such a
>> board and they have to configure the drivers for each pipeline stage in a
>> consistent way (i.e. if one is inverted the other should be as well, unless
>> they want to see an inverted signal).
>> 
>> Your idea of the OPA driver notifying the VENC driver would introduce an
>> information flow that does not exist at all in hardware. I.e. there is no "invert me"-wire
>> in either direction. And that inversion could even happen behind the connector...
> 
> Well, there doesn't need to be a hardware information flow that would
> match the SW. In fact, if there was, there would be no need for the SW
> to do it.
> 
> Consider this:
> 
> DPI output (i.e. parallel RGB) and a DPI panel, connected with 24
> datalines. The panel can be controlled via i2c, and you can send
> commands to it to function in 16 or 24 bit modes. Here I think it makes
> sense that when the user, via some method, commands the panel to use 16
> bit mode, the panel driver would send the command to the panel hardware
> and would then tell the DPI output to use 16 datalines. There's no
> "use-16-bit"-wire from the panel.
> 
> I know there are different schools of thought how (and by who) the above
> should happen, but that's the model current used in omap display drivers.
> 
> That said, if the feature, "invert" in this case, never needs to be
> changed at runtime, there's no real reason to have that kind of method
> for OPA to change the inversion. So the board file could just pass the
> invert flag as a parameter to VENC.

Yes, that is what I now also think. And the flag should/could be removed from
the connector-analog-tv at all. I.e. I think the opa362 driver should have a call

	in->ops.atv->invert_vid_out_polarity(in, true);

in the opa362_enable() code because it knows that it wants to see an inverted
input.

> 
>> Now how can we proceed?
>> 
>> For the moment we could try to get the DEVCONF1 setup into the board_init
>> until a DAC Stage driver and some platform independent API for DEVCONF1
>> modifications exists.
> 
> Well, as I don't see the need for the DAC driver, I would just add the
> function pointers to change DEVCONF1 to struct omap_dss_board_info.
> Also, the flags to enable/disable invert, bypass and AC would be added
> to the same struct.

An alternative could be that the opa362 driver can ask the VENC to set these
values each time it is enabled. This would follow the backwards call chain you
did describe and would be similar to invert_vid_out_polarity.

But for proper power management I am not sure if we should give this responsibility
to a second stage (and optional) driver.

And: not every opa362 will be connected the same way to a DM3730. I.e. this
would introduce another set of dependencies.

> 
> Note that at the moment we have just struct omap_dss_board_info, which
> is platform data for the whole DSS driver, i.e. we don't have separate
> platform data for VENC. That will probably change at some point in the
> future.

Ok. I think this can be a second step (if enabling the bypass in the board file
works). We may require it soon since we are trying to squeeze out every mA
from the platform and therefore we should have optimal power management
here as well.

> 
>> For the external amplifier (OPA362) enable, we can write a simple driver (it just
>> needs to control a GPIO whose number is passed from the platform data).
> 
> Yes, and also the regulator code to handle V+.

In our design the V+ is tied to a 3.3V rail and the enable-gpio is also a
"power-down" input. Like the TFP410 has no dedicated regulator control (yet).
So I think we don't add this yet (since we can't test).

> 
>> What I don't know is how such a driver should be integrated into the pipeline
> 
> Look at the board files. The display components there have "source"
> field, which points to the source component in the pipeline.

Here is a draft based on your description how I plan to make it work:

static struct connector_dvi_platform_data gta04_dvi_connector_pdata = {
	.name                   = "dvi",
	.source                 = "tfp410.0",
	.i2c_bus_num            = 3,
};

static struct platform_device gta04_dvi_connector_device = {
	.name                   = "connector-dvi",
	.id                     = 0,
	.dev.platform_data      = &gta04_dvi_connector_pdata,
};

static struct encoder_tfp410_platform_data gta04_tfp410_pdata = {
	.name                   = "tfp410.0",
	.source                 = "dpi.0",
	.data_lines             = 24,
	.power_down_gpio        = -1,
};

static struct platform_device gta04_tfp410_device = {
	.name                   = "encoder-tfp410",
	.id                     = 0,
	.dev.platform_data      = &gta04_tfp410_pdata,
};

static struct amplifier_opa362_platform_data gta04_opa362_pdata = {
	.name                   = "opa362.0",
	.source                 = "venc.0",
	.enable_gpio            = TV_OUT_GPIO,
};

static struct platform_device gta04_opa362_device = {
	.name                   = "amplifier-opa362",
	.id                     = 0,
	.dev.platform_data      = &gta04_opa362_pdata,
};

static struct connector_atv_platform_data gta04_tv_pdata = {
	.name                   = "tv",
	.source                 = "opa362.0",
	.connector_type         = OMAP_DSS_VENC_TYPE_COMPOSITE,
	.invert_polarity        = true,	/* needed if we use external video driver */
};

static struct platform_device gta04_tv_connector_device = {
	.name                   = "connector-analog-tv",
	.id                     = 0,
	.dev.platform_data      = &gta04_tv_pdata,
};

static struct omap_dss_board_info gta04_dss_data = {
	.default_display_name = "lcd",
};

static struct regulator_consumer_supply gta04_vdvi_supplies[] = {
	REGULATOR_SUPPLY("vdds_sdi", "omapdss"),
	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dpi.0"),
	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dsi.0"),
};


and omap-panel-data.h will be augmented by:

/**
 * amplifier_opa362_platform_data platform data
 * @name: name for this display entity
 * @source: name of the display entity used as a video source
 * @enable_gpio: gpio number for enable pin (or -1 if not available - but then you don't need this driver)
 */
struct amplifier_opa362_platform_data {
	const char *name;
	const char *source;
	int enable_gpio;
};


> 
>> and by which means it gets notified that the "tv" display is enabled/disabled/suspended/resumed.
>> Or does it simply receive its individual enable/disable calls?
> 
> OPA would receive enable from the Connector driver. And OPA would need
> to call enable in the VENC driver.
> 
>> And is this similar to configuring and running the TFP410 driver? Then, we could
>> try to take parts of that driver.
> 
> Yes, TFP410 can be used as an example.

Ok, the code looks quite straightforward (as soon as we did understand the architecture).

> 
>> And if I understand the TFP410 -> DVI example correctly such drivers are chained
>> and share the same video timings (even if they are not relevant for a specific stage)?
> 
> No, they don't (need to) share the video timings. The TFP410 example
> does share, because there are no real buffers or such in the pipeline
> which would allow to change the timings. But in some cases there are
> line buffers, and there, for example, the horizontal blanking intervals
> may be changed. And sometimes there are full frame buffers, in which
> case the timings can change totally.

I see. So the opa362 driver can also just pass it along and ignore it.

We will submit real patches as soon as we have plumbed those things together
so that they compile well.

-- hns