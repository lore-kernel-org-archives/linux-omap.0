From: Archit Taneja <a0393947@ti.com>
Subject: Re: OMAP34xx
Date: Thu, 9 Feb 2012 12:22:42 +0530
Message-ID: <4F336D3A.2060302@ti.com>
References: <20120204185453.GB17309@n2100.arm.linux.org.uk> <20120204190109.GL20333@atomide.com> <20120204203453.GD17309@n2100.arm.linux.org.uk> <20120205125626.GA11372@n2100.arm.linux.org.uk> <20120205143824.GA12577@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52167 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751208Ab2BIGw5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 9 Feb 2012 01:52:57 -0500
In-Reply-To: <20120205143824.GA12577@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

Hi,

On Sunday 05 February 2012 08:08 PM, Russell King - ARM Linux wrote:
> On Sun, Feb 05, 2012 at 12:56:26PM +0000, Russell King - ARM Linux wrote:
>> And here's another (set of) problem(s) on the 4430SDP board once the
>> previous have been worked around:
>>
>> omap_hwmod: l3_div_ck: missing clockdomain for l3_div_ck.
>> omap_hwmod: ipu: failed to hardreset
>> omap_hwmod: mcpdm: cannot be enabled (3)
>> ...
>> machine_constraints_voltage: VUSB: failed to apply 3300000uV constraint
>> ...
>> twl_reg twl_reg.46: can't register VUSB, -22
>> twl_reg: probe of twl_reg.46 failed with error -22
>> ...
>> omap_vc_i2c_init: I2C config for all channels must match.
>> omap_vc_i2c_init: I2C config for all channels must match.
>
> Fixing this error message to provide something useful allows this problem
> to be diagnosed.
>
> omap_vc_i2c_init: I2C config for vdd_iva does not match other channels (0).
> omap_vc_i2c_init: I2C config for vdd_mpu does not match other channels (0).
>
> Let's look at the PMIC data for OMAP4:
>
> static struct omap_voltdm_pmic omap3_mpu_pmic = {
>          .i2c_high_speed            = true,
> static struct omap_voltdm_pmic omap3_core_pmic = {
>          .i2c_high_speed            = true,
> static struct omap_voltdm_pmic omap4_mpu_pmic = {
>          .i2c_high_speed            = true,
> static struct omap_voltdm_pmic omap4_iva_pmic = {
>          .i2c_high_speed            = true,
> static struct omap_voltdm_pmic omap4_core_pmic = {
>
> So, OMAP4's PMIC information for the core domain does not have I2C high
> speed set, yet the others do.  So if this is an illegal configuration
> then the TWL data is plainly wrong.  If it's a legal configuration, the
> voltage domain code is talking utter crap about requiring all these to
> match.  They can't both be right.
>
> Has this code been tested on OMAP4 platforms?  I think not (or if it
> was, it was done blindly without regard for the messages the kernel
> was spitting out - again, that's a failing of people to properly test
> their code _before_ sending it upstream.)
>
>> Power Management for TI OMAP4.
>> clock: disabling unused clocks to save power
>> omapfb omapfb: no driver for display: lcd
>> omapfb omapfb: no driver for display: lcd2
>
> Okay, so this requires backlight support, and TAAL selected, so that sorts
> that error, but causes others:
>
> taal display0: taal panel revision e3.83.7d
> omapdss DSI error: DSI CIO error, cio irqstatus 200000
> DSI CIO IRQ 0x200000: ERRCONTENTIONLP1_1
> omapdss DSI error: DSI CIO error, cio irqstatus 200000
> DSI CIO IRQ 0x200000: ERRCONTENTIONLP1_1
> omapdss DSI error: DSI CIO error, cio irqstatus 200000
> DSI CIO IRQ 0x200000: ERRCONTENTIONLP1_1
> omapdss DSI error: DSI CIO error, cio irqstatus 200000
> DSI CIO IRQ 0x200000: ERRCONTENTIONLP1_1
> omapdss DSI error: DSI CIO error, cio irqstatus 200000
> DSI CIO IRQ 0x200000: ERRCONTENTIONLP1_1
> omapdss DSI error: DSI CIO error, cio irqstatus 200000
> DSI CIO IRQ 0x200000: ERRCONTENTIONLP1_1

This happens when the flex cable connected to the display is faulty or 
loose.

>
>> Failed to set PHY power mode to 1
>> omapdss HDMI error: failed to power on device
>
> For some reason, enabling TAAL fixes this HDMI error.  Why I don't
> understand but it's very very counter intuitive.

This was an issue with our driver. I've posted a fix for this.

Thanks,
Archit

>
>> ------------[ cut here ]------------
>> WARNING: at /home/rmk/git/linux-omap/arch/arm/mach-omap2/omap_hwmod.c:1604 _idle+0x34/0xc8()
>> omap_hwmod: dss_hdmi: idle state can only be entered from enabled state
>
> This message doesn't exist in the kernel source as far as I can find.
> Ah, yes it does, someone well wrapped the message.
>
>                  WARN(1, "omap_hwmod: %s: idle state can only be entered from "
>                       "enabled state\n", oh->name);
>
> So that goes into my patch of omap fixes.  There's others in that file
> which will get the same treatment.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

