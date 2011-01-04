From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH] omap: boards w/ wl12xx should select REGULATOR_FIXED_VOLTAGE
Date: Tue, 4 Jan 2011 20:04:41 +0200
Message-ID: <AANLkTinc1xopSYvaJmN_hHaQq1TP=i_HNy5vX_LhdQOh@mail.gmail.com>
References: <1290593090-6288-1-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f194.google.com ([209.85.210.194]:48697 "EHLO
	mail-iy0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750954Ab1ADSFD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Jan 2011 13:05:03 -0500
Received: by iyf40 with SMTP id 40so6758724iyf.1
        for <linux-omap@vger.kernel.org>; Tue, 04 Jan 2011 10:05:02 -0800 (PST)
In-Reply-To: <1290593090-6288-1-git-send-email-ohad@wizery.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, Nov 24, 2010 at 12:04 PM, Ohad Ben-Cohen <ohad@wizery.com> wrot=
e:
> Power to the wl12xx wlan device is controlled by a fixed regulator.
>
> Boards that have the wl12xx should select REGULATOR_FIXED_VOLTAGE so
> users will not be baffled.
>
> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
> ---

Hi Tony,

Gentle reminder,

Thanks,
Ohad.


> =A0arch/arm/mach-omap2/Kconfig | =A0 =A03 +++
> =A01 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfi=
g
> index fc3a181..cc386da 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -190,6 +190,7 @@ config MACH_OMAP3_PANDORA
> =A0 =A0 =A0 =A0depends on ARCH_OMAP3
> =A0 =A0 =A0 =A0default y
> =A0 =A0 =A0 =A0select OMAP_PACKAGE_CBB
> + =A0 =A0 =A0 select REGULATOR_FIXED_VOLTAGE
>
> =A0config MACH_OMAP3_TOUCHBOOK
> =A0 =A0 =A0 =A0bool "OMAP3 Touch Book"
> @@ -235,6 +236,7 @@ config MACH_OMAP_ZOOM2
> =A0 =A0 =A0 =A0select SERIAL_8250
> =A0 =A0 =A0 =A0select SERIAL_CORE_CONSOLE
> =A0 =A0 =A0 =A0select SERIAL_8250_CONSOLE
> + =A0 =A0 =A0 select REGULATOR_FIXED_VOLTAGE
>
> =A0config MACH_OMAP_ZOOM3
> =A0 =A0 =A0 =A0bool "OMAP3630 Zoom3 board"
> @@ -244,6 +246,7 @@ config MACH_OMAP_ZOOM3
> =A0 =A0 =A0 =A0select SERIAL_8250
> =A0 =A0 =A0 =A0select SERIAL_CORE_CONSOLE
> =A0 =A0 =A0 =A0select SERIAL_8250_CONSOLE
> + =A0 =A0 =A0 select REGULATOR_FIXED_VOLTAGE
>
> =A0config MACH_CM_T35
> =A0 =A0 =A0 =A0bool "CompuLab CM-T35 module"
> --
> 1.7.0.4
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
