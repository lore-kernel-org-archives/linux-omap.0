From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/7] mfd: menelaus: delete omap_has_menelaus
Date: Tue, 20 Jan 2015 13:50:39 +0000
Message-ID: <20150120135039.GL13701@x1>
References: <1419702779-16001-1-git-send-email-aaro.koskinen@iki.fi>
 <1419702779-16001-2-git-send-email-aaro.koskinen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ig0-f169.google.com ([209.85.213.169]:51926 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752294AbbATNuv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Jan 2015 08:50:51 -0500
Received: by mail-ig0-f169.google.com with SMTP id hl2so8685738igb.0
        for <linux-omap@vger.kernel.org>; Tue, 20 Jan 2015 05:50:50 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1419702779-16001-2-git-send-email-aaro.koskinen@iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Tony Lindgren <tony@atomide.com>, Samuel Ortiz <sameo@linux.intel.com>, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Sat, 27 Dec 2014, Aaro Koskinen wrote:

> Delete unused macro.
>=20
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> ---
>  include/linux/mfd/menelaus.h | 6 ------
>  1 file changed, 6 deletions(-)

Applied, thanks.

> diff --git a/include/linux/mfd/menelaus.h b/include/linux/mfd/menelau=
s.h
> index f097e89..a1e12bf3 100644
> --- a/include/linux/mfd/menelaus.h
> +++ b/include/linux/mfd/menelaus.h
> @@ -38,10 +38,4 @@ extern int menelaus_set_vcore_hw(unsigned int roof=
_mV, unsigned int floor_mV);
> =20
>  extern int menelaus_set_regulator_sleep(int enable, u32 val);
> =20
> -#if defined(CONFIG_ARCH_OMAP2) && defined(CONFIG_MENELAUS)
> -#define omap_has_menelaus()	1
> -#else
> -#define omap_has_menelaus()	0
> -#endif
> -
>  #endif

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
