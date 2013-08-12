From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 1/1] =?utf-8?Q?MAINTAINERS?=
	=?utf-8?Q?=3A_update_Beno=C3=AEt?= Cousson email address
Date: Mon, 12 Aug 2013 00:55:56 -0700
Message-ID: <20130812075556.GH7656@atomide.com>
References: <1376234465-15476-1-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:11571 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752731Ab3HLH4E (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Aug 2013 03:56:04 -0400
Content-Disposition: inline
In-Reply-To: <1376234465-15476-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Jiri Kosina <jkosina@suse.cz>, =?utf-8?Q?Beno=C3=AEt?= Cousson <benoit.cousson@linaro.org>, Pavel Machek <pavel@ucw.cz>, Belisko Marek <marek.belisko@gmail.com>, linux-omap@vger.kernel.org

* Javier Martinez Canillas <javier.martinez@collabora.co.uk> [130811 08=
:28]:
> Using the email address listed on MAINTAINERS I keep
> getting SMTP 550 Invalid recipient errors.
>=20
> Update with what seems to be current Beno=C3=AEt's email
> address to make get_maintainer.pl to stop lying.
>=20
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co=
=2Euk>

Is the linaro.org address still valid? We should probably
wait for Benoit to confirm this to avoid more confusion.

Regards,

Tony

> ---
>=20
> Patch on top of Linus's commit c095ba72 ("Linux 3.11-rc4").
>=20
> Changes since v1:
>  - I mostly send DT patches to Beno=C3=AEt but now I noticed that
>    he also maintains other subsystems. Update the patch to
>    change all his MAINTAINERS entries.
>=20
>  MAINTAINERS |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index defc053..3466423 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5879,7 +5879,7 @@ F:	drivers/i2c/busses/i2c-omap.c
>  F:	include/linux/i2c-omap.h
> =20
>  OMAP DEVICE TREE SUPPORT
> -M:	Beno=C3=AEt Cousson <b-cousson@ti.com>
> +M:	Beno=C3=AEt Cousson <benoit.cousson@linaro.org>
>  M:	Tony Lindgren <tony@atomide.com>
>  L:	linux-omap@vger.kernel.org
>  L:	devicetree@vger.kernel.org
> @@ -5959,14 +5959,14 @@ S:	Maintained
>  F:	drivers/char/hw_random/omap-rng.c
> =20
>  OMAP HWMOD SUPPORT
> -M:	Beno=C3=AEt Cousson <b-cousson@ti.com>
> +M:	Beno=C3=AEt Cousson <benoit.cousson@linaro.org>
>  M:	Paul Walmsley <paul@pwsan.com>
>  L:	linux-omap@vger.kernel.org
>  S:	Maintained
>  F:	arch/arm/mach-omap2/omap_hwmod.*
> =20
>  OMAP HWMOD DATA FOR OMAP4-BASED DEVICES
> -M:	Beno=C3=AEt Cousson <b-cousson@ti.com>
> +M:	Beno=C3=AEt Cousson <benoit.cousson@linaro.org>
>  L:	linux-omap@vger.kernel.org
>  S:	Maintained
>  F:	arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> --=20
> 1.7.7.6
>=20
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
