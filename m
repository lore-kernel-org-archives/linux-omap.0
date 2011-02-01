From: Dave Martin <dave.martin@linaro.org>
Subject: Re: [PATCH v2] OMAP: fix fncpy API call
Date: Tue, 1 Feb 2011 16:36:06 +0000
Message-ID: <AANLkTinU5Msop=Lg7iuSfNZXa+7NQCwcrN2hB1a1T9Ds@mail.gmail.com>
References: <1295977686-22765-1-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:45145 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751291Ab1BAQgI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Feb 2011 11:36:08 -0500
Received: by eye27 with SMTP id 27so3239080eye.19
        for <linux-omap@vger.kernel.org>; Tue, 01 Feb 2011 08:36:07 -0800 (PST)
In-Reply-To: <1295977686-22765-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jean.pihet@newoldbits.com
Cc: linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>

On Tue, Jan 25, 2011 at 5:48 PM,  <jean.pihet@newoldbits.com> wrote:
> From: Jean Pihet <j-pihet@ti.com>
>
> Fix a potential problem with function types when calling the
> fncpy API to copy the PM code functions to SRAM.
>
> Signed-off-by: Jean Pihet <j-pihet@ti.com>
> ---
> =A0arch/arm/plat-omap/include/plat/sram.h | =A0 =A04 ++--
> =A01 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/plat-omap/include/plat/sram.h b/arch/arm/plat-o=
map/include/plat/sram.h
> index d673f2c..f500fc3 100644
> --- a/arch/arm/plat-omap/include/plat/sram.h
> +++ b/arch/arm/plat-omap/include/plat/sram.h
> @@ -18,10 +18,10 @@ extern void *omap_sram_push_address(unsigned long=
 size);
>
> =A0/* Macro to push a function to the internal SRAM, using the fncpy =
API */
> =A0#define omap_sram_push(funcp, size) ({ =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 \
> - =A0 =A0 =A0 typeof(&funcp) _res =3D NULL; =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> + =A0 =A0 =A0 typeof(&(funcp)) _res =3D NULL; =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> =A0 =A0 =A0 =A0void *_sram_address =3D omap_sram_push_address(size); =
=A0 =A0 \
> =A0 =A0 =A0 =A0if (_sram_address) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 _res =3D fncpy(_sram_address, &funcp, s=
ize); =A0 =A0 =A0\
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 _res =3D fncpy(_sram_address, &(funcp),=
 size); =A0 =A0\
> =A0 =A0 =A0 =A0_res; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> =A0})

I believe this is sound, though I'm not yet in a position to test it fu=
lly.

When I have the OMAP kernel building with Thumb-2 again I will follow u=
p.

Cheers
---Dave


Reviewed-by: Dave Martin <dave.martin@linaro.org>

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
