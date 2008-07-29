From: "Syed Mohammed, Khasim" <khasim@ti.com>
Subject: RE: Does DSS support 24 bits_per_pixel?
Date: Tue, 29 Jul 2008 17:25:14 +0530
Message-ID: <0680EC522D0CC943BC586913CF3768C00208A69C3B@dbde02.ent.ti.com>
References: <c656a4d20807282143kb3e36e4p36662d7eda4b1861@mail.gmail.com>
	 <0680EC522D0CC943BC586913CF3768C00208A69C1C@dbde02.ent.ti.com>
 <c656a4d20807290440s4c79d9f1wb56057f52a5f14cc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from calf.ext.ti.com ([198.47.26.144]:40020 "EHLO calf.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755106AbYG2LzY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Jul 2008 07:55:24 -0400
In-Reply-To: <c656a4d20807290440s4c79d9f1wb56057f52a5f14cc@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arun c <arun.edarath@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



> -----Original Message-----
> From: arun c [mailto:arun.edarath@gmail.com]
> Sent: Tuesday, July 29, 2008 5:11 PM
> To: Syed Mohammed, Khasim
> Cc: linux-omap@vger.kernel.org
> Subject: Re: Does DSS support 24 bits_per_pixel?
>
> On Tue, Jul 29, 2008 at 4:37 PM, Syed Mohammed, Khasim <khasim@ti.com> wrote:
> >
> >> Hi all,
> >>
> >> Does omap (2&3) DSS support 24 bit output?
> >>
> >> I was trying to enable DVI support for omap2evm(data lines=24, bits
> >> per pixel =24), I couldn't find
> >> 24 bit support in omapfb driver(git) and omap24xxfb(linux-2.6.14-omap2-v5).
> >>
> >> In TRM its given that it supports 24 BPP. Then why its absent in both
> >> the drivers?. Does the hardware
> >> really support 24 bit format?
> >>
> > Hardware does support RGB 24 packed and unpacked modes.
> >
> > In TI code it is implemented in V4L based Video driver and also in FB driver,
> omap2_disp_config_gfxlayer selects the bpp and configures DISPC_GFX_ATTRIBUTES register accordingly.
> >
>
> But in the TI code,
>
> omap24xxfb_check_mode(const struct omap24xxfb_info *oinfo,
>                       struct fb_var_screeninfo *var)
> {
>         u32 pixclock, clkdiv;
>         u32 display_xres, display_yres;
>         int output_dev = omap2_disp_get_output_dev(OMAP2_GRAPHICS);
>
>         omap2_disp_get_panel_size(output_dev, &display_xres, &display_yres);
>         if (oinfo->rotation_support) {
>
>                 if (var->rotate % 90 != 0)
>                         return -EINVAL;
>
>                 if (!((var->bits_per_pixel == 8) ||
>                       (var->bits_per_pixel == 16)))
>                         return -EINVAL;
>

As this was the last update for OMAP2 platforms, I expect it to have support for 24 as well. I am downloading the code base to check for the same. In the latest code for 3530 I have
                if (!((var->bits_per_pixel == 8) ||
                                        (var->bits_per_pixel == 16)||
                                        (var->bits_per_pixel == 32))) {

Actually you can even refer to omap3530 code base and port this functionality to OMAP2.

Regards,
Khasim
http://khasim.blogspot.com

