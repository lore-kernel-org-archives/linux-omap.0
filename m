From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [RFC][RFT][PATCH] OMAPFB: LCDC: change update_mode to DISABLED when going suspend
Date: Sun, 23 May 2010 14:09:42 +0200
Message-ID: <201005231409.44541.jkrzyszt@tis.icnet.pl>
References: <201005170320.29580.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:50954 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753615Ab0EWMK3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 23 May 2010 08:10:29 -0400
In-Reply-To: <201005170320.29580.jkrzyszt@tis.icnet.pl>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>
Cc: linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@nokia.com>

Monday 17 May 2010 03:20:13 Janusz Krzysztofik wrote:
> I was observing the following error messages on my OMAP1 based Amstrad
> Delta board when first changing from text to graphics mode or vice versa
> after the LCD display had been blanked:
> 	omapfb omapfb: timeout waiting for FRAME DONE
> with a followup error message while unblanking it back:
> 	omapfb omapfb: resetting (status 0xffffffb2,reset count 1)
> As a visible result, image pixels happened to be shifted by a few bits,
> giving wrong colors.
>
> Examining the code, I found that this problem occures when an OMAP1
> internal LCD controller is disabled from omap_lcdc_suspend() and then a
> subsequent omap_lcdc_setup_plane() calls disable_controller() again. This
> potentially error provoking behaviour is triggered by the lcdc.update_mode
> flag being kept at OMAP_AUTO_UPDATE, regardless of the controller and panel
> being suspended.
>
> This patch tries to correct the problem by replacing both
> omap_lcdc_suspend() and omap_lcdc_resume() function bodies with single
> calls to
> omap_lcdc_set_update_mode() with a respective OMAP_UPDATE_DISABLE or
> OMAP_AUTO_UPDATE argument. As a result, exactly the same lower level
> operations are performed, with addition of changing the lcdc.update_mode
> flag to a value better suited for the controller state. This prevents any
> further calls to disable_controller() from omap_lcdc_setup_plane() while
> the display is suspended.

Hi,

One more week of successfull, trouble-free testing on my side. Although there 
were no other test reports, no objections nor change requests were raised as 
well on this relatively simple and straightforward patch. Could we then agree 
on it being accepted for inclusion? Tomi?

Thanks,
Janusz

> Created against linux-2.6.34-rc7.
> Tested on Amstrad Delta.
>
> Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
> ---
> Hi,
>
> Those of you having access to other display equipped OMAP1 boards, could
> you please test if this patch doesn't break anything?
>
> Thanks,
> Janusz
>
>  drivers/video/omap/lcdc.c |   14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
>
> --- git/drivers/video/omap/lcdc.c.orig	2010-05-16 21:39:20.000000000 +0200
> +++ git/drivers/video/omap/lcdc.c	2010-05-17 00:00:43.000000000 +0200
> @@ -572,22 +572,12 @@ static enum omapfb_update_mode omap_lcdc
>  /* PM code called only in internal controller mode */
>  static void omap_lcdc_suspend(void)
>  {
> -	if (lcdc.update_mode == OMAPFB_AUTO_UPDATE) {
> -		disable_controller();
> -		omap_stop_lcd_dma();
> -	}
> +	omap_lcdc_set_update_mode(OMAPFB_UPDATE_DISABLED);
>  }
>
>  static void omap_lcdc_resume(void)
>  {
> -	if (lcdc.update_mode == OMAPFB_AUTO_UPDATE) {
> -		setup_regs();
> -		load_palette();
> -		setup_lcd_dma();
> -		set_load_mode(OMAP_LCDC_LOAD_FRAME);
> -		enable_irqs(OMAP_LCDC_IRQ_DONE);
> -		enable_controller();
> -	}
> +	omap_lcdc_set_update_mode(OMAPFB_AUTO_UPDATE);
>  }
>
>  static void omap_lcdc_get_caps(int plane, struct omapfb_caps *caps)


