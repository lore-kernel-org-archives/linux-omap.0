From: "Dr. H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: DSS display-new custom enable/disable hooks
Date: Wed, 25 Sep 2013 11:00:17 +0200
Message-ID: <307BD8A2-738A-4A66-8FD5-98C37AD4BCA3@goldelico.com>
References: <CAAfyv349Xjt7Wy-R34OW81SzmUX-1WhfVZdbhWVDoOXpUKa9ug@mail.gmail.com> <52427ECA.1080500@ti.com> <CAAfyv37sSa=7x=p1wgX+Rhdxh=WMB4DhmC9ZQMpxB_rb30Aurw@mail.gmail.com> <3A4BA9B4-262C-4F0A-95B7-D243065D01BA@goldelico.com> <52429F06.6030609@ti.com>
Mime-Version: 1.0 (Apple Message framework v1085)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:27845 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751267Ab3IYJAZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Sep 2013 05:00:25 -0400
In-Reply-To: <52429F06.6030609@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, Belisko Marek <marek.belisko@gmail.com>

Hi Tomi,

Am 25.09.2013 um 10:29 schrieb Tomi Valkeinen:

> On 25/09/13 10:45, Dr. H. Nikolaus Schaller wrote:
>> Hi,
>> 
>> Am 25.09.2013 um 09:09 schrieb Belisko Marek:
>> 
>>> CC - Nikolaus Schaller
>>> 
>>> On Wed, Sep 25, 2013 at 8:12 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>>>> On 24/09/13 23:04, Belisko Marek wrote:
>>>>> Hi,
>>>>> 
>>>>> we're using connector-analog-tv driver to enable TV out on gta04
>>>>> board. There is exception that we need to change some twl registers +
>>>>> some gpio when enable/disable TV output. My question is if there is
>>>>> some way how to do that or do we need to copy'n'paste code from
>>>>> connector-analog-tv driver and extend it for handling we need (let's
>>>>> call it hack)?
>>>> 
>>>> What are those TWL registers and GPIO used for?
>> 
>> The GTA04 devices uses an OPA362 video amplifier connected to the TV_VFB1 pin
>> of the DM3730. According to some not well known discussion with TI [1] we must
>> therefore configure the AC bias and Bypass through the DEVCONF1 register.
> 
> Ah, OPA. A blast from the past =).
> 
> Well, OPA is a distinct hardware block in the video path, I see no issue
> in having an OPA encoder driver, that sits in between VENC and the
> connector.
> 
> The driver should handle things described in the OPA datasheet. With a
> quick glance, there seems to be one GPIO and one power line to OPA.

Hm. Why need a driver for a specific piece of hardware? For software it is just an
analog TV out with additional control options.

And, it must not be the OPA362 - it could be something completely different.

> 
>> [1] https://e2e.ti.com/support/dsp/omap_applications_processors/f/447/p/94072/343691.aspx
>> 
>> And we have to disable (High-Z) the OPA362 amplifier if TVout is not in use since the
>> line is shared with a different function (microphone input).
>> 
>> The reasons to use the OPA362 at all are to do short circuit protection and to high-Z
>> the driver (both are n/a with the DM3730 as far as we know).
>> 
>> The code we did use successfully in the 2.6.32 board file is:
>> 
>> 120 #define TV_OUT_GPIO     23
>> 
>> 374 static int gta04_panel_enable_tv(struct omap_dss_device *dssdev)
>> 375 {
>> 376         u32 reg;
>> 377 
>> 378 #define ENABLE_VDAC_DEDICATED           0x03
>> 379 #define ENABLE_VDAC_DEV_GRP             0x20
>> 380 #define OMAP2_TVACEN                            (1 << 11)
>> 381 #define OMAP2_TVOUTBYPASS                       (1 << 18)
>> 382 
>> 383         twl_i2c_write_u8(TWL_MODULE_PM_RECEIVER,
>> 384                         ENABLE_VDAC_DEDICATED,
>> 385                         TWL4030_VDAC_DEDICATED);
>> 386         twl_i2c_write_u8(TWL_MODULE_PM_RECEIVER,
>> 387                         ENABLE_VDAC_DEV_GRP, TWL4030_VDAC_DEV_GRP);
> 
> All that i2c stuff should be handled by using the normal regulator
> framework.
> 
>> 388 
>> 389         /* idea taken from https://e2e.ti.com/support/dsp/omap_applications_processors/f/447/p/94072/343691.aspx */
>> 390         reg = omap_ctrl_readl(OMAP343X_CONTROL_DEVCONF1);
>> 391 //      printk(KERN_INFO "Value of DEVCONF1 was: %08x\n", reg);
>> 392         reg |= OMAP2_TVOUTBYPASS;       /* enable TV bypass mode for external video driver (for OPA362 driver) */
>> 393         reg |= OMAP2_TVACEN;            /* assume AC coupling to remove DC offset */
>> 394         omap_ctrl_writel(reg, OMAP343X_CONTROL_DEVCONF1);
>> 395         reg = omap_ctrl_readl(OMAP343X_CONTROL_DEVCONF1);
>> 396 //      printk(KERN_INFO "Value of DEVCONF1 now: %08x\n", reg);
>> 397 
>> 398         gpio_set_value(TV_OUT_GPIO, 1); /* enable output driver (OPA362) */
>> 399 
>> 400         return 0;
>> 401 }
>> 402 
>> 403 static void gta04_panel_disable_tv(struct omap_dss_device *dssdev)
>> 404 {
>> 405         gpio_set_value(TV_OUT_GPIO, 0); /* disable output driver (and re-enable microphone) */
>> 406 
>> 407         twl_i2c_write_u8(TWL_MODULE_PM_RECEIVER, 0x00,
>> 408                         TWL4030_VDAC_DEDICATED);
>> 409         twl_i2c_write_u8(TWL_MODULE_PM_RECEIVER, 0x00,
>> 410                         TWL4030_VDAC_DEV_GRP);
>> 411 }
>> 412
>> 413 static struct omap_dss_device gta04_tv_device = {
>> 414         .name = "tv",
>> 415         .driver_name = "venc",
>> 416         .type = OMAP_DISPLAY_TYPE_VENC,
>> 417         /* GTA04 has a single composite output (with external video driver) */
>> 418         .phy.venc.type = OMAP_DSS_VENC_TYPE_COMPOSITE,
>> 419         .phy.venc.invert_polarity = true,       /* needed if we use external video driver */
>> 420         .platform_enable = gta04_panel_enable_tv,
>> 421         .platform_disable = gta04_panel_disable_tv,
>> 422 };
>> 
>> I think (but don't know) that controlling the TWL/VDAC is no longer needed because
>> it should be done through the connector-analog-tv driver.
> 
> I don't think VDAC is related to the connector (although I didn't
> actually look at the analog video when I created the new
> connector-analog-driver). If there's something specifically related to
> an analog tv out connector that requires power, then, yes, it's needed.
> But if it's all about OMAP's VENC and OPA, then the connector itself
> does not require anything.
> 
> As an example, DVI connector does require a +5V (if I recall right), and
> that +5V is not related to the DVI video source, it's only about the
> connector. So in that case, the DVI connector driver should handle the
> +5V (it doesn't, currently, but will soon be added).
> 
>> So we need to
>> 1. control a GPIO - very similar to a TFT panel
>> 2. invert polarity
>> 3. configure the OMAP343X_CONTROL_DEVCONF1 register as needed
>> 
>> I don't know if we must do step 3. each time we enable TVout (because we can't
>> assume that no other part of the kernel code writes to the DEVCONF1 register) so that
>> it could be done in the board init code.
> 
> So, is the GPIO the one that goes to OPA?

Yes. Like the enable_gpio in struct panel_dpi_platform_data.

So I now think we would be happy if the connector-analog-tv would have a gpio
in its platform data that can handle such an enable/disable.

> Is VDAC the power to OPA?

No. The OPA is powered by an external 3.3V rail. I don't really remember why
we control VDAC in that piece of code. It was copied from the beagle board
validation kernel. Maybe it was not done automatically by the 2.6.32 DSS code.

> VDAC
> is already used by VENC, which manages it, so if VDAC is only used for
> VENC, there's no need for to handle it anywhere else.

That is what I also would assume.

> 
> The DEVCONF1 register is problematic. For that we need some kind of
> platform hooks. We have some already for PM and DSI pins, so we could
> add a new one for TV-out. However, the DSI pins (hopefully) could be
> handled by the pinmuxing framework. Maybe that would be applicable here
> also.

Hm. Looks like a complex solution for a simple problem and isn't related to
pinmuxing (IMHO).

Could we just add a "enable_ac" and "enable_bypass"  to struct connector_atv_platform_data,
that sets/resets these flags in the DEVCONF1 register each time the tvout is enabled?

I think this would be very similar to the "invert_polarity" property.

Then, the platform data has more control over the shape of the signals created by
the VENC (independently of that we use an OPA362).

IMHO this topic is very similar to controlling the polarity and timing of the
HSYNC/VSYNC of a LCD (.flags in struct display_timing), i.e. shaping the
interface signals so that they are accepted by the hardware connected to
the DM3730.

If you think this would be a reasonable approach, we can try to prepare a
patch to connector-analog-tv.c for further discussion.

BR,
Nikolaus

