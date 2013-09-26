From: "Dr. H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: DSS display-new custom enable/disable hooks
Date: Thu, 26 Sep 2013 14:37:40 +0200
Message-ID: <54A492D6-DE01-4EF4-90CA-1ADF2B6CE8D2@goldelico.com>
References: <CAAfyv349Xjt7Wy-R34OW81SzmUX-1WhfVZdbhWVDoOXpUKa9ug@mail.gmail.com> <52427ECA.1080500@ti.com> <CAAfyv37sSa=7x=p1wgX+Rhdxh=WMB4DhmC9ZQMpxB_rb30Aurw@mail.gmail.com> <3A4BA9B4-262C-4F0A-95B7-D243065D01BA@goldelico.com> <52429F06.6030609@ti.com> <307BD8A2-738A-4A66-8FD5-98C37AD4BCA3@goldelico.com> <5242BFEA.1090200@ti.com> <9172D29D-118B-4B6F-A454-BD359C5D97D4@goldelico.com> <5242EBB7.2090006@ti.com> <A88E32D7-26DC-4E22-A30D-098F174EB896@goldelico.com> <5243EE61.3000408@ti.com> <F101C925-6FA8-4813-955D-1B145FB2711E@goldelico.com> <52441F5A.2040102@ti.com>
Mime-Version: 1.0 (Apple Message framework v1085)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:28115 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756612Ab3IZMho convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Sep 2013 08:37:44 -0400
In-Reply-To: <52441F5A.2040102@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, Belisko Marek <marek.belisko@gmail.com>


Am 26.09.2013 um 13:49 schrieb Tomi Valkeinen:

> On 26/09/13 14:01, Dr. H. Nikolaus Schaller wrote:
> 
>> So this essentially means that the "invert" property and the "bypass", "acen" properties
>> should be defined for the VENC (if it also controls the DAC-Stage).
>> 
>> I.e. I am not sure if invert is really a property (control) of the connector or an amplifier.
> 
> Invert bit is programmed to VENC, so it is a property of VENC. At least
> in the end.
> 
> The question is, does it need to be changed dynamically at runtime? I
> don't think so. OPA always wants its input inverted. Without OPA, the TV
> out signal is always un-inverted. So we can have it as a property of
> VENC, just like bypass and acen.
> 
> True, it's currently set at the connector, but I think that's wrong.

Yes, this is how I would have argued as well.

> 
>>>> The OPA itself then should also participate in suspend/resume. Well, that
>>>> would be something important for proper power management. Only then
>>>> we can make sure the OPA is disabled correctly.
>>> 
>>> There isn't really anything to suspend/resume on that level. If the
>>> display is enabled, it stays enabled, there's no automatic suspend. If
>>> there's a system suspend, omapfb (or similar component) will disable the
>>> displays.
>>> 
>>> So it's only about enable/disable on this level.
>> 
>> Ok. I think this is also sufficient since the OPA362 is in low power if it is
>> disabled. I.e. suspend and disable are the same.
> 
> I think that fits more or less all hardware.
> 
> Well, sometimes there could be different power-states, and waking up
> from those takes different amounts of time. I think that's normally not
> needed for display, it doesn't matter if enabling a display encoder
> takes 15ms or 100ms.
> 
>> Although one could argue that one is just controlling the GPIO and the other
>> one is controlling some regulator...
> 
> Sorry, didn't understand that one...

I meant that there could be a differece between enable/disable and power-on/off
(e.g. retaining register values vs. loosing everything). But I can't imagine that for
a simple video amplifier.

> 
>>> Well, this is perhaps a bit about semantics, but it is a driver for
>>> OPA362 hardware. Sure, we can make a more generic driver if we see that
>>> there are other external amps that have very similar controls.
>> 
>> That was my assumption. Analog amplifiers just have an input and an output.
>> And can be powered on or off. This would imho fit 99% of all such amplifiers.
>> Well, one could think about switching different signal strenghts but this is AFAIK
>> not defined by the composite video standards.
> 
> Ok.
> 
> But I would presume all of them have power and gpio inputs. Does the
> power need to be enabled before enabling the gpio, and if so, for how
> long does the power need to be enabled until the gpio can be set? Etc. I
> don't know if simple components like analog amp needs those, but very
> often display component datasheets list quite specifically the order and
> timing of all the powers and gpios.
> 
> That said... Maybe a generic amp driver would work for the 99% of cases.
> It's always difficult to guess what kind of hardware there is out there =).

Yes, and therefore I think we should focus on the 362 first like the 410.

> 
>>> But it's
>>> still an OPA362 driver, but it would also be OPA123, OPA321, etc. driver.
>>> 
>>> Making it "external-video-amplifier" driver is probably taking it too
>>> far. We don't know what kind of amps there are. Maybe some are
>>> controlled via i2c. Dumping all the different functionality for
>>> different amps into one driver would just make one messy driver.
>> 
>> Ok, I will start to write an "amplifier-opa362.c" based on the "encoder-ftp410.c"
>> code.
> 
> Yep, I don't have a strong opinion on whether to create opa362, or more
> generic driver. Try one =).

Well, let's start with amplifier-opa362 and see if someone else ever needs
a different one. And "amplifier-generic" would be a quite strange name...

> 
>>> That said, if the feature, "invert" in this case, never needs to be
>>> changed at runtime, there's no real reason to have that kind of method
>>> for OPA to change the inversion. So the board file could just pass the
>>> invert flag as a parameter to VENC.
>> 
>> Yes, that is what I now also think. And the flag should/could be removed from
>> the connector-analog-tv at all. I.e. I think the opa362 driver should have a call
>> 
>> 	in->ops.atv->invert_vid_out_polarity(in, true);
>> 
>> in the opa362_enable() code because it knows that it wants to see an inverted
>> input.
> 
> I think the whole function should be removed. Again, if there's no need
> to ever change it during runtime by OPA, the call is quite unnecessary.
> And the invert flag could just be passed to VENC in platform data.

Yes, that is how I also would prefer it.

> And note that with "change it during runtime" I don't mean VENC could
> not change it during runtime. If the bit needs to be cleared when the
> output is disabled, VENC can do that. But that is VENC's internal thing,
> no need for a invert_vid_out_polarity() API for it.

Yes.

> 
>>>> Now how can we proceed?
>>>> 
>>>> For the moment we could try to get the DEVCONF1 setup into the board_init
>>>> until a DAC Stage driver and some platform independent API for DEVCONF1
>>>> modifications exists.
>>> 
>>> Well, as I don't see the need for the DAC driver, I would just add the
>>> function pointers to change DEVCONF1 to struct omap_dss_board_info.
>>> Also, the flags to enable/disable invert, bypass and AC would be added
>>> to the same struct.
>> 
>> An alternative could be that the opa362 driver can ask the VENC to set these
>> values each time it is enabled. This would follow the backwards call chain you
>> did describe and would be similar to invert_vid_out_polarity.
> 
> I don't know... Again, not so familiar with analog TV signal, but the
> ac_en and bypass sound very much like OMAP VENC specific things.
> 
> If they can be considered as generic features with analog TV signaling,
> at least the names should probably be re-thought. "Bypass" means
> VENC/DAC bypasses something. It doesn't sound that it has anything to do
> with the signal. If this is something that OPA would touch, the naming
> conventions should be something generic. I have no idea what that would
> be, but somehow it would need to describe the signal or the connection,
> not OMAP VENC/DAC's internal functionality.
> 
> But anyway, as I said, I think these can be just set for VENC in
> platform data, and I don't see a need for OPA to have any notion of these.

Yes, I think we don't have to follow up on this idea.

> 
>> But for proper power management I am not sure if we should give this responsibility
>> to a second stage (and optional) driver.
>> 
>> And: not every opa362 will be connected the same way to a DM3730. I.e. this
>> would introduce another set of dependencies.
> 
> What options are there? In the TRM I see only one picture, the bypass
> one, which depicts an amplifier. The other pictures show a connector, no
> amp.

Well, there could be systems where an OPA363 is not connected to an OMAP3
but some other video source. And then the source would not have the bypass and
acen flags.

This is IMHO another argument for having all this in the VENC platform data.

> 
>>> Note that at the moment we have just struct omap_dss_board_info, which
>>> is platform data for the whole DSS driver, i.e. we don't have separate
>>> platform data for VENC. That will probably change at some point in the
>>> future.
>> 
>> Ok. I think this can be a second step (if enabling the bypass in the board file
>> works). We may require it soon since we are trying to squeeze out every mA
>> from the platform and therefore we should have optimal power management
>> here as well.
> 
> Well, you can try setting it in the board file, but I think the patches
> for mainline should have the function pointers. Board files do not exist
> when booting with device tree, and I will probably reject any changes
> that will not work with DT. No need to add any DT support yet, but the
> model should be DT-friendly.

Well, we can't boot w/o the board file yet for other reasons, i.e. a DT only
approach isn't our target yet.

> 
>>>> For the external amplifier (OPA362) enable, we can write a simple driver (it just
>>>> needs to control a GPIO whose number is passed from the platform data).
>>> 
>>> Yes, and also the regulator code to handle V+.
>> 
>> In our design the V+ is tied to a 3.3V rail and the enable-gpio is also a
>> "power-down" input. Like the TFP410 has no dedicated regulator control (yet).
>> So I think we don't add this yet (since we can't test).
> 
> Yes, I think that's fine.
> 
>>>> What I don't know is how such a driver should be integrated into the pipeline
>>> 
>>> Look at the board files. The display components there have "source"
>>> field, which points to the source component in the pipeline.
>> 
>> Here is a draft based on your description how I plan to make it work:
>> 
>> static struct connector_dvi_platform_data gta04_dvi_connector_pdata = {
>> 	.name                   = "dvi",
>> 	.source                 = "tfp410.0",
>> 	.i2c_bus_num            = 3,
>> };
>> 
>> static struct platform_device gta04_dvi_connector_device = {
>> 	.name                   = "connector-dvi",
>> 	.id                     = 0,
>> 	.dev.platform_data      = &gta04_dvi_connector_pdata,
>> };
>> 
>> static struct encoder_tfp410_platform_data gta04_tfp410_pdata = {
>> 	.name                   = "tfp410.0",
>> 	.source                 = "dpi.0",
>> 	.data_lines             = 24,
>> 	.power_down_gpio        = -1,
>> };
>> 
>> static struct platform_device gta04_tfp410_device = {
>> 	.name                   = "encoder-tfp410",
>> 	.id                     = 0,
>> 	.dev.platform_data      = &gta04_tfp410_pdata,
>> };
>> 
>> static struct amplifier_opa362_platform_data gta04_opa362_pdata = {
>> 	.name                   = "opa362.0",
>> 	.source                 = "venc.0",
>> 	.enable_gpio            = TV_OUT_GPIO,
>> };
>> 
>> static struct platform_device gta04_opa362_device = {
>> 	.name                   = "amplifier-opa362",
>> 	.id                     = 0,
>> 	.dev.platform_data      = &gta04_opa362_pdata,
>> };
>> 
>> static struct connector_atv_platform_data gta04_tv_pdata = {
>> 	.name                   = "tv",
>> 	.source                 = "opa362.0",
>> 	.connector_type         = OMAP_DSS_VENC_TYPE_COMPOSITE,
>> 	.invert_polarity        = true,	/* needed if we use external video driver */
>> };
> 
> Looks fine, except I think you should try to move invert_polarity to
> omap_dss_board_info. At least after initial testing.
> 
> I don't want to make this more confusing, but... I wonder about the
> connector_type field. It's only function is to pass the value to VENC,
> which will then work differently. And it's also something that cannot be
> changed at runtime. Perhaps that, too, should be moved to VENC's
> platform data.

I was also thinking about this topic. Well, the connector type is correctly
a property of the connector... But it logically controls some registers
in the DAC Output stage. So I had thought that the opa362 driver will
hand it over to the VENC and could check if it is really a composite
video (since AFAIK the OPA can't be used in a S-Video sytem).
But that again would be another chain of information flow from the
connector to the VENC making their APIs dependent.

BR,
Nikolaus Schaller


