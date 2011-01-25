From: Dave Martin <dave.martin@linaro.org>
Subject: Re: [PATCH] OMAP: fix fncpy API call
Date: Tue, 25 Jan 2011 17:30:58 +0000
Message-ID: <AANLkTimzNyx9a+440v6PufmJ94EjcyGZ71ndffEHz5i1@mail.gmail.com>
References: <1295976079-21228-1-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:52164 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751571Ab1AYRbG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Jan 2011 12:31:06 -0500
Received: by eye27 with SMTP id 27so19167eye.19
        for <linux-omap@vger.kernel.org>; Tue, 25 Jan 2011 09:31:04 -0800 (PST)
In-Reply-To: <1295976079-21228-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jean.pihet@newoldbits.com
Cc: linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>

On Tue, Jan 25, 2011 at 5:21 PM,  <jean.pihet@newoldbits.com> wrote:
> From: Jean Pihet <j-pihet@ti.com>
>
> Fix a potential problem with function types when calling the
> fncpy API to copy the PM code functions to SRAM.
>
> Tested on OMAP3 in low power modes (RET/OFF)
> using omap2plus_defconfig with !CONFIG_THUMB2_KERNEL.
>
> Signed-off-by: Jean Pihet <j-pihet@ti.com>
> ---
> =A0arch/arm/plat-omap/include/plat/sram.h | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/plat-omap/include/plat/sram.h b/arch/arm/plat-o=
map/include/plat/sram.h
> index d673f2c..6a2166d 100644
> --- a/arch/arm/plat-omap/include/plat/sram.h
> +++ b/arch/arm/plat-omap/include/plat/sram.h
> @@ -21,7 +21,7 @@ extern void *omap_sram_push_address(unsigned long s=
ize);
> =A0 =A0 =A0 =A0typeof(&funcp) _res =3D NULL; =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> =A0 =A0 =A0 =A0void *_sram_address =3D omap_sram_push_address(size); =
=A0 =A0 \
> =A0 =A0 =A0 =A0if (_sram_address) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 _res =3D fncpy(_sram_address, &funcp, s=
ize); =A0 =A0 =A0\
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 _res =3D fncpy(_sram_address, &(funcp),=
 size); =A0 =A0\

If you're doing this, you should also have typeof(&(funcp)) above.

Cheers
---Dave

> =A0 =A0 =A0 =A0_res; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> =A0})
>
> --
> 1.7.1
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
