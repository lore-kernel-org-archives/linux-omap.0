From: "arun c" <arunedarath@mistralsolutions.com>
Subject: Re: [PATCH] OMAP2EVM: Fix for omapfb irq error messages
Date: Mon, 8 Sep 2008 08:22:19 -0400
Message-ID: <c656a4d20809080522x591b0b2dkcf012fce5255c46e@mail.gmail.com>
References: <c656a4d20809060301r374965cfk22ab21a8a62581cd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.189]:48990 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751605AbYIHMWW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Sep 2008 08:22:22 -0400
Received: by ti-out-0910.google.com with SMTP id b6so906133tic.23
        for <linux-omap@vger.kernel.org>; Mon, 08 Sep 2008 05:22:20 -0700 (PDT)
In-Reply-To: <c656a4d20809060301r374965cfk22ab21a8a62581cd@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Sat, Sep 6, 2008 at 6:01 AM, arun c <arunedarath@mistralsolutions.com> wrote:
> This patch fixes the irq error warnings from omapfb which
> was stalling the console.
>
> Only the below 2 errors are coming now
>
> omapfb omapfb: irq error status 00e2
> omapfb omapfb: irq error status 00c0
>
> Signed-off-by: Arun C <arunedarath@mistralsolutions.com>
> ---
>  drivers/video/omap/lcd_omap2evm.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/video/omap/lcd_omap2evm.c
> b/drivers/video/omap/lcd_omap2evm.c
> index 8a0105e..c58f2d0 100644
> --- a/drivers/video/omap/lcd_omap2evm.c
> +++ b/drivers/video/omap/lcd_omap2evm.c
> @@ -130,11 +130,11 @@ struct lcd_panel omap2evm_panel = {
>        .x_res          = LCD_XRES,
>        .y_res          = LCD_YRES,
>        .hsw            = 3,
> -       .hfp            = 0,
> +       .hfp            = 10,
>        .hbp            = 28,
>        .vsw            = 2,
> -       .vfp            = 1,
> -       .vbp            = 0,
> +       .vfp            = 3,
> +       .vbp            = 1,
>
>        .pixel_clock    = LCD_PIXCLOCK_MAX,
>
> --
> 1.5.3.4
>

Please ignore this patch as of now.

The problem is whenever I add support  for new device the
error(omapfb irq errors) is coming again. There was no issues
until we added support for nand. After nand support error
messages began to appear and this patch solved it.

Today I added support for touch screen and the errors
came again. I had to adjust the above values(hbp, hfp, vbp, vfp)
again to resolve the issues.

I am thinking that I will send the final stable values after
adding full support for OMAP2EVM.

Do anybody know how to optimize (hsw, hfp, hbp, vsw, vbp,
vfp) values?

Regards,
Arun C
