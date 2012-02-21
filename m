From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCHv5 06/14] arm: omap: add support for oscillator setup
Date: Tue, 21 Feb 2012 08:44:22 -0600
Message-ID: <CAOMWX4ccQ6Y4F-8YSD-6SNURCTYHi+MCEzJsVhCOb3CRwLoqmA@mail.gmail.com>
References: <1329833098-19900-1-git-send-email-t-kristo@ti.com> <1329833098-19900-7-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:43819 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751796Ab2BUOop convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Feb 2012 09:44:45 -0500
Received: by mail-wi0-f173.google.com with SMTP id hi20so4423315wib.4
        for <linux-omap@vger.kernel.org>; Tue, 21 Feb 2012 06:44:43 -0800 (PST)
In-Reply-To: <1329833098-19900-7-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org

On Tue, Feb 21, 2012 at 08:04, Tero Kristo <t-kristo@ti.com> wrote:
> This contains startup and shutdown times for the oscillator. By defau=
lt
> use ULONG_MAX. Oscillator setup is used for calculating and setting u=
p
> latencies for sleep modes that disable oscillator.
>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
> =A0arch/arm/mach-omap2/pm.c | =A0 27 +++++++++++++++++++++++++++
> =A0arch/arm/mach-omap2/pm.h | =A0 =A08 ++++++++
> =A02 files changed, 35 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
> index 1881fe9..2402e8e 100644
> --- a/arch/arm/mach-omap2/pm.c
> +++ b/arch/arm/mach-omap2/pm.c
> @@ -28,6 +28,33 @@
>
> =A0static struct omap_device_pm_latency *pm_lats;
>
> +/**
> + * struct omap2_oscillator - Describe the board main oscillator late=
ncies
> + * @startup_time: oscillator startup latency
> + * @shutdown_time: oscillator shutdown latency
> + */
> +struct omap2_oscillator {
> + =A0 =A0 =A0 u32 startup_time;
> + =A0 =A0 =A0 u32 shutdown_time;
> +};
> +
> +static struct omap2_oscillator oscillator =3D {
> + =A0 =A0 =A0 .startup_time =3D ULONG_MAX,
> + =A0 =A0 =A0 .shutdown_time =3D ULONG_MAX,
> +};
> +
> +void omap_pm_setup_oscillator(u32 tstart, u32 tshut)
> +{
> + =A0 =A0 =A0 oscillator.startup_time =3D tstart;
> + =A0 =A0 =A0 oscillator.shutdown_time =3D tshut;
> +}
> +
> +void omap_pm_get_oscillator(u32 *tstart, u32 *tshut)
> +{

Maybe a nitpick - variable check needed?

Regards,
Nishanth Menon


> + =A0 =A0 =A0 *tstart =3D oscillator.startup_time;
> + =A0 =A0 =A0 *tshut =3D oscillator.shutdown_time;
> +}
> +
> =A0static int _init_omap_device(char *name)
> =A0{
> =A0 =A0 =A0 =A0struct omap_hwmod *oh;
> diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
> index ec8f874..797d2da 100644
> --- a/arch/arm/mach-omap2/pm.h
> +++ b/arch/arm/mach-omap2/pm.h
> @@ -141,4 +141,12 @@ static inline int omap4_twl_init(void)
> =A0}
> =A0#endif
>
> +#ifdef CONFIG_PM
> +extern void omap_pm_setup_oscillator(u32 tstart, u32 tshut);
> +extern void omap_pm_get_oscillator(u32 *tstart, u32 *tshut);
> +#else
> +static inline void omap_pm_setup_oscillator(u32 tstart, u32 tshut) {=
 }
> +static inline void omap_pm_get_oscillator(u32 *tstart, u32 *tshut) {=
 }
> +#endif
> +
> =A0#endif
> --
> 1.7.4.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
