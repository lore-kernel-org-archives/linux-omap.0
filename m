From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [RFC/PATCH] OMAP PM: remove OMAP_PM_NONE config option
Date: Fri, 6 May 2011 11:13:50 +0200
Message-ID: <BANLkTi=YJ8+7Nv=0wbem_CqytRMiKQjgJw@mail.gmail.com>
References: <1304673087-24643-1-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:33378 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755213Ab1EFJNv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 May 2011 05:13:51 -0400
Received: by qyk7 with SMTP id 7so4215761qyk.19
        for <linux-omap@vger.kernel.org>; Fri, 06 May 2011 02:13:50 -0700 (PDT)
In-Reply-To: <1304673087-24643-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com
Cc: Jean Pihet <j-pihet@ti.com>

Please note that this code is based on khilman's for_2.6.40/pm-cleanup =
branch.

Jean

On Fri, May 6, 2011 at 11:11 AM, Jean Pihet <jean.pihet@newoldbits.com>=
 wrote:
> The current code base is not linking with the OMAP_PM_NONE
> option set.
> Since the option OMAP_PM_NOOP provides a no-op/debug layer,
> OMAP_PM_NONE can be removed.
> OMAP_PM_NOOP is enabled by default by Kconfig.
>
> Signed-off-by: Jean Pihet <j-pihet@ti.com>
> ---
> =A0arch/arm/plat-omap/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0=
3 ---
> =A0arch/arm/plat-omap/include/plat/omap-pm.h | =A0 =A08 --------
> =A02 files changed, 0 insertions(+), 11 deletions(-)
>
> diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
> index cd5f993..16e3293 100644
> --- a/arch/arm/plat-omap/Kconfig
> +++ b/arch/arm/plat-omap/Kconfig
> @@ -209,9 +209,6 @@ choice
> =A0 =A0 =A0 =A0depends on ARCH_OMAP
> =A0 =A0 =A0 =A0default OMAP_PM_NOOP
>
> -config OMAP_PM_NONE
> - =A0 =A0 =A0 bool "No PM layer"
> -
> =A0config OMAP_PM_NOOP
> =A0 =A0 =A0 =A0bool "No-op/debug PM layer"
>
> diff --git a/arch/arm/plat-omap/include/plat/omap-pm.h b/arch/arm/pla=
t-omap/include/plat/omap-pm.h
> index c0a7520..0840df8 100644
> --- a/arch/arm/plat-omap/include/plat/omap-pm.h
> +++ b/arch/arm/plat-omap/include/plat/omap-pm.h
> @@ -40,11 +40,7 @@
> =A0* framework starts. =A0The "_if_" is to avoid name collisions with=
 the
> =A0* PM idle-loop code.
> =A0*/
> -#ifdef CONFIG_OMAP_PM_NONE
> -#define omap_pm_if_early_init() 0
> -#else
> =A0int __init omap_pm_if_early_init(void);
> -#endif
>
> =A0/**
> =A0* omap_pm_if_init - OMAP PM init code called after clock fw init
> @@ -52,11 +48,7 @@ int __init omap_pm_if_early_init(void);
> =A0* The main initialization code. =A0OPP tables are passed in here. =
=A0The
> =A0* "_if_" is to avoid name collisions with the PM idle-loop code.
> =A0*/
> -#ifdef CONFIG_OMAP_PM_NONE
> -#define omap_pm_if_init() 0
> -#else
> =A0int __init omap_pm_if_init(void);
> -#endif
>
> =A0/**
> =A0* omap_pm_if_exit - OMAP PM exit code
> --
> 1.7.1
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
