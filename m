From: "arun c" <arun.edarath@gmail.com>
Subject: Re: Does DSS support 24 bits_per_pixel?
Date: Tue, 29 Jul 2008 17:10:43 +0530
Message-ID: <c656a4d20807290440s4c79d9f1wb56057f52a5f14cc@mail.gmail.com>
References: <c656a4d20807282143kb3e36e4p36662d7eda4b1861@mail.gmail.com>
	 <0680EC522D0CC943BC586913CF3768C00208A69C1C@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.188]:1615 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755385AbYG2Lko (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Jul 2008 07:40:44 -0400
Received: by ti-out-0910.google.com with SMTP id b6so2588905tic.23
        for <linux-omap@vger.kernel.org>; Tue, 29 Jul 2008 04:40:43 -0700 (PDT)
In-Reply-To: <0680EC522D0CC943BC586913CF3768C00208A69C1C@dbde02.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Syed Mohammed, Khasim" <khasim@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, Jul 29, 2008 at 4:37 PM, Syed Mohammed, Khasim <khasim@ti.com> wrote:
>
>> Hi all,
>>
>> Does omap (2&3) DSS support 24 bit output?
>>
>> I was trying to enable DVI support for omap2evm(data lines=24, bits
>> per pixel =24), I couldn't find
>> 24 bit support in omapfb driver(git) and omap24xxfb(linux-2.6.14-omap2-v5).
>>
>> In TRM its given that it supports 24 BPP. Then why its absent in both
>> the drivers?. Does the hardware
>> really support 24 bit format?
>>
> Hardware does support RGB 24 packed and unpacked modes.
>
> In TI code it is implemented in V4L based Video driver and also in FB driver,             omap2_disp_config_gfxlayer selects the bpp and configures DISPC_GFX_ATTRIBUTES register accordingly.
>

But in the TI code,

omap24xxfb_check_mode(const struct omap24xxfb_info *oinfo,
                      struct fb_var_screeninfo *var)
{
        u32 pixclock, clkdiv;
        u32 display_xres, display_yres;
        int output_dev = omap2_disp_get_output_dev(OMAP2_GRAPHICS);

        omap2_disp_get_panel_size(output_dev, &display_xres, &display_yres);
        if (oinfo->rotation_support) {

                if (var->rotate % 90 != 0)
                        return -EINVAL;

                if (!((var->bits_per_pixel == 8) ||
                      (var->bits_per_pixel == 16)))
                        return -EINVAL;

in the check var fn it returns -EINVAL if it encounters any bpp other
than 16 or 8

I am using linux-2.6.14-omap2-v5 from TI website, whether this is the
correct version?


> Regards,
> Khasim
> http://khasim.blogspot.com
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
