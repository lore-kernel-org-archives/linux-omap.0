From: Kyle Manna <kyle.manna@gmail.com>
Subject: Re: [PATCH 1/1] ARM: OMAP: Add conditional compilation for board
 specific init functions
Date: Tue, 18 Oct 2011 13:36:32 -0500
Message-ID: <CAM9fjH6TZnAWAPvp8Uvr4hHpf77CeRz3k=hv6FGN73X1aXTXQQ@mail.gmail.com>
References: <1318629618-5313-1-git-send-email-martinez.javier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:54141 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751410Ab1JRSgd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Oct 2011 14:36:33 -0400
Received: by wwe6 with SMTP id 6so1335881wwe.1
        for <linux-omap@vger.kernel.org>; Tue, 18 Oct 2011 11:36:32 -0700 (PDT)
In-Reply-To: <1318629618-5313-1-git-send-email-martinez.javier@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <martinez.javier@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

Looks like you're missing one more section for OMAP3. Will reply with
a complete patch I was about to submit.

@@ -382,11 +387,14 @@ void __init omap2430_init_early(void)
        omap_hwmod_init_postsetup();
        omap2430_clk_init();
 }
+#endif

 /*
  * Currently only board-omap3beagle.c should call this because of the
  * same machine_id for 34xx and 36xx beagle.. Will get fixed with DT.
  */
+#if defined(CONFIG_ARCH_OMAP3)
+
 void __init omap3_init_early(void)
 {
        omap2_set_globals_3xxx();
@@ -398,6 +406,7 @@ void __init omap3_init_early(void)
        omap_hwmod_init_postsetup();
        omap3xxx_clk_init();
 }
+#endif

 void __init omap3430_init_early(void)
 {


On Fri, Oct 14, 2011 at 5:00 PM, Javier Martinez Canillas
<martinez.javier@gmail.com> wrote:
>
> The definition for board specific initialization functions:
> - omap2_set_globals_xxxx
> - omapxxxx_powerdomains_init
> - omapxxxx_clockdomains_init
> - omapxxxx_hwmod_init
>
> is conditionally compiled. So we also have to conditionally compile
> the call to these functions or the linker will find undefined symbols=
=2E
>
> Signed-off-by: Javier Martinez Canillas <martinez.javier@gmail.com>
> ---
> =A0arch/arm/mach-omap2/io.c | =A0 =A06 ++++++
> =A01 files changed, 6 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
> index aa96538..d2d045b 100644
> --- a/arch/arm/mach-omap2/io.c
> +++ b/arch/arm/mach-omap2/io.c
> @@ -359,6 +359,7 @@ static void __init omap_hwmod_init_postsetup(void=
)
> =A0 =A0 =A0 =A0omap_pm_if_early_init();
> =A0}
>
> +#ifdef CONFIG_SOC_OMAP2420
> =A0void __init omap2420_init_early(void)
> =A0{
> =A0 =A0 =A0 =A0omap2_set_globals_242x();
> @@ -370,7 +371,9 @@ void __init omap2420_init_early(void)
> =A0 =A0 =A0 =A0omap_hwmod_init_postsetup();
> =A0 =A0 =A0 =A0omap2420_clk_init();
> =A0}
> +#endif
>
> +#ifdef CONFIG_SOC_OMAP2430
> =A0void __init omap2430_init_early(void)
> =A0{
> =A0 =A0 =A0 =A0omap2_set_globals_243x();
> @@ -382,6 +385,7 @@ void __init omap2430_init_early(void)
> =A0 =A0 =A0 =A0omap_hwmod_init_postsetup();
> =A0 =A0 =A0 =A0omap2430_clk_init();
> =A0}
> +#endif
>
> =A0/*
> =A0* Currently only board-omap3beagle.c should call this because of t=
he
> @@ -431,6 +435,7 @@ void __init ti816x_init_early(void)
> =A0 =A0 =A0 =A0omap3xxx_clk_init();
> =A0}
>
> +#ifdef CONFIG_ARCH_OMAP4
> =A0void __init omap4430_init_early(void)
> =A0{
> =A0 =A0 =A0 =A0omap2_set_globals_443x();
> @@ -442,6 +447,7 @@ void __init omap4430_init_early(void)
> =A0 =A0 =A0 =A0omap_hwmod_init_postsetup();
> =A0 =A0 =A0 =A0omap4xxx_clk_init();
> =A0}
> +#endif
>
> =A0void __init omap_sdrc_init(struct omap_sdrc_params *sdrc_cs0,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0struct omap_sdrc_params *sdrc_cs1)
> --
> 1.7.4.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
