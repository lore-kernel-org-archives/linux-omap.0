From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/3] mfd: menelaus: delete omap_has_menelaus
Date: Mon, 30 Mar 2015 08:14:33 +0100
Message-ID: <20150330071433.GH457@x1>
References: <1427575537-28508-1-git-send-email-aaro.koskinen@iki.fi>
 <1427575537-28508-2-git-send-email-aaro.koskinen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:35960 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751446AbbC3HOi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Mar 2015 03:14:38 -0400
Received: by wgra20 with SMTP id a20so161839290wgr.3
        for <linux-omap@vger.kernel.org>; Mon, 30 Mar 2015 00:14:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1427575537-28508-2-git-send-email-aaro.koskinen@iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Samuel Ortiz <sameo@linux.intel.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>

On Sat, 28 Mar 2015, Aaro Koskinen wrote:

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
