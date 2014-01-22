From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH 4/6] ARM: OMAP2+: add legacy display for omap3 DBB056
Date: Tue, 21 Jan 2014 21:10:52 -0300
Message-ID: <CABxcv=nnkahNQBL3sjtd8zxevP+jT_pbKUChz-fr6wRXuuxGCQ@mail.gmail.com>
References: <1390333660-30573-1-git-send-email-chf.fritz@googlemail.com>
	<1390333660-30573-5-git-send-email-chf.fritz@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:38014 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752094AbaAVAKz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Jan 2014 19:10:55 -0500
Received: by mail-wi0-f179.google.com with SMTP id hr1so49275wib.6
        for <linux-omap@vger.kernel.org>; Tue, 21 Jan 2014 16:10:53 -0800 (PST)
In-Reply-To: <1390333660-30573-5-git-send-email-chf.fritz@googlemail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Christoph Fritz <chf.fritz@googlemail.com>
Cc: Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Benoit Cousson <bcousson@baylibre.com>, Archit Taneja <archit@ti.com>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Daniel Mack <zonque@gmail.com>, "Hans J. Koch" <hjk@hansjkoch.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hello Christoph,

On Tue, Jan 21, 2014 at 4:47 PM, Christoph Fritz
<chf.fritz@googlemail.com> wrote:
> Full device tree support for omapdss is not yet accomplished. Until
> then, init display by legacy platform code.
>
> Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
> ---
>  arch/arm/mach-omap2/dss-common.c   |   49 ++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/dss-common.h   |    1 +
>  arch/arm/mach-omap2/pdata-quirks.c |    8 +++++-
>  3 files changed, 57 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-omap2/dss-common.c b/arch/arm/mach-omap2/dss-common.c
> index dadccc9..b8b4e39 100644
> --- a/arch/arm/mach-omap2/dss-common.c
> +++ b/arch/arm/mach-omap2/dss-common.c
> @@ -257,3 +257,52 @@ void __init omap3_igep2_display_init_of(void)
>         platform_device_register(&omap3_igep2_tfp410_device);
>         platform_device_register(&omap3_igep2_dvi_connector_device);
>  }
> +
> +/* OMAP3 dbb056 data */
> +
> +#define DBB056_DISPLAY_ENABLE_GPIO 156
> +
> +static const struct display_timing dbb056_lcd_videomode = {
> +       .pixelclock = { 0, 19200000, 0 },
> +
> +       .hactive = { 0, 640, 0 },
> +       .hfront_porch = { 0, 104, 0 },
> +       .hback_porch = { 0, 8, 0 },
> +       .hsync_len = { 0, 8, 0 },
> +
> +       .vactive = { 0, 480, 0 },
> +       .vfront_porch = { 0, 104, 0 },
> +       .vback_porch = { 0, 8, 0 },
> +       .vsync_len = { 0, 8, 0 },
> +
> +       .flags = DISPLAY_FLAGS_HSYNC_LOW | DISPLAY_FLAGS_VSYNC_LOW |
> +               DISPLAY_FLAGS_DE_HIGH | DISPLAY_FLAGS_PIXDATA_NEGEDGE,
> +};
> +
> +static struct panel_dpi_platform_data dbb056_lcd_pdata = {
> +       .name                   = "lcd",
> +       .source                 = "dpi.0",
> +
> +       .data_lines             = 18,
> +
> +       .display_timing         = &dbb056_lcd_videomode,
> +
> +       .enable_gpio            = DBB056_DISPLAY_ENABLE_GPIO,
> +       .backlight_gpio         = -1,
> +};
> +
> +static struct platform_device dbb056_lcd_device = {
> +       .name                   = "panel-dpi",
> +       .id                     = 0,
> +       .dev.platform_data      = &dbb056_lcd_pdata,
> +};
> +
> +static struct omap_dss_board_info omap_dbb056_dss_data = {
> +       .default_display_name = "lcd",
> +};
> +
> +void __init omap3_dbb056_display_init_of(void)
> +{
> +       platform_device_register(&dbb056_lcd_device);
> +       omap_display_init(&omap_dbb056_dss_data);
> +}
> diff --git a/arch/arm/mach-omap2/dss-common.h b/arch/arm/mach-omap2/dss-common.h
> index a9becf0..a125b55 100644
> --- a/arch/arm/mach-omap2/dss-common.h
> +++ b/arch/arm/mach-omap2/dss-common.h
> @@ -9,5 +9,6 @@
>  void __init omap4_panda_display_init_of(void);
>  void __init omap_4430sdp_display_init_of(void);
>  void __init omap3_igep2_display_init_of(void);
> +void __init omap3_dbb056_display_init_of(void);
>
>  #endif
> diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
> index 39f020c..bce8020 100644
> --- a/arch/arm/mach-omap2/pdata-quirks.c
> +++ b/arch/arm/mach-omap2/pdata-quirks.c
> @@ -92,6 +92,11 @@ static void __init omap3_zoom_legacy_init(void)
>  {
>         legacy_init_wl12xx(WL12XX_REFCLOCK_26, 0, 162);
>  }
> +
> +static void __init omap3_dbb056_legacy_init(void)
> +{
> +       omap3_dbb056_display_init_of();
> +}
>  #endif /* CONFIG_ARCH_OMAP3 */
>
>  #ifdef CONFIG_ARCH_OMAP4
> @@ -139,10 +144,11 @@ struct of_dev_auxdata omap_auxdata_lookup[] __initdata = {
>
>  static struct pdata_init pdata_quirks[] __initdata = {
>  #ifdef CONFIG_ARCH_OMAP3
> +       { "incostartec,omap3-lilly-dbb056", omap3_dbb056_legacy_init, },
> +       { "isee,omap3-igep0020", omap3_igep0020_legacy_init, },
>         { "nokia,omap3-n900", hsmmc2_internal_input_clk, },
>         { "nokia,omap3-n9", hsmmc2_internal_input_clk, },
>         { "nokia,omap3-n950", hsmmc2_internal_input_clk, },
> -       { "isee,omap3-igep0020", omap3_igep0020_legacy_init, },
>         { "ti,omap3-evm-37xx", omap3_evm_legacy_init, },
>         { "ti,omap3-zoom3", omap3_zoom_legacy_init, },
>  #endif
> --
> 1.7.10.4
>

I don't think that makes sense to add more legacy display support
right now since Tomi has sent a v3 of his OMAPDSS DT support which
hopefully will be merged in v3.14.

Thanks a lot and best regards,
Javier
