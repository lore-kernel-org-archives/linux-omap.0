From: Anand Gadiyar <gadiyar@ti.com>
Subject: RE: gpio126: Multiple gpio paths (2) : CAM_STROBE & SDMMC1_DAT4
Date: Tue, 22 Feb 2011 15:23:25 +0530
Message-ID: <d788d25561dc676a189686737c97a95f@mail.gmail.com>
References: <FCCFB4CDC6E5564B9182F639FC3560870370562CF6@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:59759 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753480Ab1BVJx1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Feb 2011 04:53:27 -0500
Received: by mail-fx0-f42.google.com with SMTP id 20so2202388fxm.1
        for <linux-omap@vger.kernel.org>; Tue, 22 Feb 2011 01:53:26 -0800 (PST)
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC3560870370562CF6@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Abhilash Koyamangalath <abhilash.kv@ti.com>, linux-omap@vger.kernel.org

Koyamangalath, Abhilash wrote:
> There is this boot-time message on the am3517evm (and possibly
> other omap 35xx based boards as well)
> [    0.000000] _omap_mux_init_gpio: Multiple gpio paths
>  (2) for gpio126
> I realized that this happens due to dual mappings for
> gpio_126 in arch/arm/mach-omap2/mux34xx.c:
>
> static struct omap_mux __initdata omap3_muxmodes[] = {
> :
> _OMAP3_MUXENTRY(CAM_STROBE, 126,
>                 "cam_strobe", NULL, NULL, NULL,
>                 "gpio_126", "hw_dbg11", NULL, "safe_mode"),
> :
> _OMAP3_MUXENTRY(SDMMC1_DAT4, 126,
>                 "sdmmc1_dat4", NULL, "sim_io", NULL,
>                 "gpio_126", NULL, NULL, "safe_mode"),
> :
> #if defined(CONFIG_OMAP_MUX) &&
> defined(CONFIG_OMAP_PACKAGE_CBB) static struct omap_mux
> __initdata omap3_cbb_subset[] = {
> :
>        _OMAP3_MUXENTRY(CAM_STROBE, 126,
>                 "cam_strobe", NULL, NULL, NULL,
>                 "gpio_126", NULL, NULL, "safe_mode"),
>
> Removing one instance of CAM_STROBE from omap3_muxmodes rids us
> of this (pr_info) message and should be fine as this is defined in
> omap3_xxx_subset as well. But I'm concerned if this would
> break things
> on the other omap3 boards?
>
> For completeness, I've listed my patch (only for the CBB
> package) below
> (this also modifies the Mode 5 value of CAM_STROBE from NULL
> to hw_dbg11
> in omap3_cbb_subset, which is incorrect right now); please comment:
>
> ---

The GPIO 126 signal is available on two pads of that package.
You will therefore need to update the caller to use
omap_mux_init_signal specifying the full name as "cam_strobe.gpio_126"
or equivalent.

I'm not sure if you can do something similar using omap_mux_init_gpio.

Dropping an entry from the table is not the right way to go.

- Anand
