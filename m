From: "Steve Sakoman" <sakoman@gmail.com>
Subject: Re: [PATCH 6/7] OMAP3 EVM: add lcd support (resubmit to respond to feedback)
Date: Fri, 9 May 2008 10:35:29 -0700
Message-ID: <5e088bd90805091035lbd4bf0ei6febbc463275c48a@mail.gmail.com>
References: <5e088bd90804292353t9e05fcatf1505a086770cb63@mail.gmail.com>
	 <2a4801c741aef4f504dbaf153b85afab@felipebalbi.com>
	 <5e088bd90804300714p5349a257rf1b89ddd347bb72@mail.gmail.com>
	 <5D9B6FC3-222B-4315-9DA9-62C8FFFB4537@student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:63499 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753483AbYEIRfd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 May 2008 13:35:33 -0400
Received: by fg-out-1718.google.com with SMTP id 19so898350fgg.17
        for <linux-omap@vger.kernel.org>; Fri, 09 May 2008 10:35:29 -0700 (PDT)
In-Reply-To: <5D9B6FC3-222B-4315-9DA9-62C8FFFB4537@student.utwente.nl>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <k.kooi@student.utwente.nl>
Cc: linux-omap@vger.kernel.org

>  I strongly suspect the above comments needs to be "/* in kHz */ ...

That is correct - a cut and paste from the old style driver that I did not fix.

I will submit a cleanup patch later today.

Thanks!

Steve

On Fri, May 9, 2008 at 9:35 AM, Koen Kooi <k.kooi@student.utwente.nl> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
>  Hash: SHA1
>
>
>  Op 30 apr 2008, om 16:14 heeft Steve Sakoman het volgende geschreven:
>
> >
> > From: Steve Sakoman <steve@sakoman.com>
> >
> > Add LCD support for OMAP3 EVM
> >
> > Signed-off-by: Steve Sakoman <steve@sakoman.com>
> > ---
> >
> >
> > +#define LCD_PIXCLOCK_MAX       41700 /* in pico seconds  */
> > +#define LCD_PIXCLOCK_MIN       38000 /* in pico seconds */
> >
>
>  I strongly suspect the above comments needs to be "/* in kHz */ ...
>
>
>
> >
> > +struct lcd_panel omap3evm_panel = {
> > +       .name           = "omap3evm",
> > +       .config         = OMAP_LCDC_PANEL_TFT | OMAP_LCDC_INV_VSYNC |
> > +                         OMAP_LCDC_INV_HSYNC,
> > +
> > +       .bpp            = 16,
> > +       .data_lines     = 18,
> > +       .x_res          = LCD_XRES,
> > +       .y_res          = LCD_YRES,
> > +       .hsw            = 3,            /* hsync_len (4) - 1 */
> > +       .hfp            = 3,            /* right_margin (4) - 1 */
> > +       .hbp            = 39,           /* left_margin (40) - 1 */
> > +       .vsw            = 1,            /* vsync_len (2) - 1 */
> > +       .vfp            = 2,            /* lower_margin */
> > +       .vbp            = 7,            /* upper_margin (8) - 1 */
> > +
> > +       .pixel_clock    = LCD_PIXCLOCK_MAX,
> >
>
>  ... since pixel_clock seems to be in kHz. Could someone confirm this?
>
>  regards,
>
>  Koen
>  -----BEGIN PGP SIGNATURE-----
>  Version: GnuPG v1.4.5 (Darwin)
>
>  iD8DBQFIJH1KMkyGM64RGpERAifEAJwLITHNkhjJ/zhKKiTFdVEq+6AuMgCfVoXd
>  oFX58FQibqqSyaIk4sTVCNE=
>  =yJ/0
>  -----END PGP SIGNATURE-----
>  --
>  To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>  the body of a message to majordomo@vger.kernel.org
>  More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
