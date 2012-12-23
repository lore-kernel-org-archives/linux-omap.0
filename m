From: Paul Walmsley <paul@pwsan.com>
Subject: Re: reset handling in am335x hwmod data
Date: Sun, 23 Dec 2012 20:58:13 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1212232033030.8937@utopia.booyaka.com>
References: <87ehij8lpb.fsf@dell.be.48ers.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:56928 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752626Ab2LWU6O (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 23 Dec 2012 15:58:14 -0500
In-Reply-To: <87ehij8lpb.fsf@dell.be.48ers.dk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Korsgaard <jacmet@sunsite.dk>
Cc: linux-omap@vger.kernel.org

Hi Peter,

On Fri, 21 Dec 2012, Peter Korsgaard wrote:

> On a custom am335x board I was surprised to see the kernel resetting
> gpio pins not mentioned anywhere in the dts.

The original plan with DT was to start by focusing on devices on the 
board, rather than devices on the SoC.  The GPIO is an SoC device, so 
it's currently managed by the hwmod data.  (This will probably change with 
future kernel releases.)

> In this specific case the pin is connected to nCONFIG of a FPGA. The
> FPGA is commanded to start configuration from a SPI flash in the
> bootloader, so it can happen in parallel with kernel
> load/uncompress/startup, but as the kernel resets the gpio during
> initialization this doesn't work.
> 
> Digging a bit into it, I see the hwmod of the gpio controller is
> configured to reset at startup, and it works correctly (E.G. the pin is
> left asserted) if I change it to HWMOD_INIT_NO_RESET:
> 
> --- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
> @@ -992,7 +992,7 @@ static struct omap_hwmod am33xx_gpio1_hwmod = {
>         .name           = "gpio2",
>         .class          = &am33xx_gpio_hwmod_class,
>         .clkdm_name     = "l4ls_clkdm",
> -       .flags          = HWMOD_CONTROL_OPT_CLKS_IN_RESET,
> +       .flags          = (HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET),
>         .mpu_irqs       = am33xx_gpio1_irqs,
>         .main_clk       = "l4ls_gclk",
>         .prcm           = {
> 
> Now the question is why is this configured like this?

This behavior is intended to decouple the kernel from the bootloader, or 
previously-booted operating system (e.g., the kexec case).  The original 
goal was to place the system in an known safe state as soon as possible 
after the kernel starts.  This is to prevent misconfigured or 
previously-configured devices from trashing memory or chip power 
management in the currently-booted kernel.  It also avoids adding 
inadvertent bootloader dependencies in driver code.

N.B., the plan is to change this behavior over the next few releases.  
Devices that have drivers associated with them will be reset when the 
driver loads.  Driverless devices will be reset after drivers load, late 
in boot.

> Should E.G. the gpio controllers be changed to not reset or should it be 
> configurable in the dts?

Probably the DTS is the right place, since this is a board- and 
bootloader-specific quirk.  The original intention was to allow board 
files to set this HWMOD_INIT_NO_RESET flag themselves - see mach-omap2/ 
omap_hwmod.c:omap_hwmod_no_setup_reset().  But since we've deprecated the 
board files, the DT data seems like the right place.  

It probably shouldn't be a GPIO-specific property.  Other devices like DSS 
will also need some kind of 'no-init-reset' property, since on many 
commercial devices, it's expected that some kind of splash screen will be 
presented by the bootloader and stay on during the boot process.

However, it is probably safest in the long run if you can change the board 
design to require the SoC to actively reset the FPGA, rather than making 
reset the default state.  That way, if there's some hardware bug that 
requires the GPIO block to be reset, or if there's some GPIO glitch during 
power management, the FPGA won't be inadvertently reset.


regards,

- Paul
