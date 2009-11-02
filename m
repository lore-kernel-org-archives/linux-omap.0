From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: [PATCH] [OMAP3_PM] Fix zoom2 defconfig build
Date: Mon, 02 Nov 2009 10:26:10 +0200
Message-ID: <1257150370.29885.986.camel@localhost>
References: <1257148563-18604-1-git-send-email-manjugk@ti.com>
Reply-To: dedekind1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:18653 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754072AbZKBI0g (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Nov 2009 03:26:36 -0500
In-Reply-To: <1257148563-18604-1-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: manjugk@ti.com
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com

On Mon, 2009-11-02 at 13:26 +0530, manjugk@ti.com wrote:
> From: Manjunatha GK <manjugk@ti.com>
>=20
>=20
> Signed-off-by: Manjunatha GK <manjugk@ti.com>
> ---
>  arch/arm/configs/omap_zoom2_defconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/arch/arm/configs/omap_zoom2_defconfig b/arch/arm/configs=
/omap_zoom2_defconfig
> index f1739fa..8ca835a 100644
> --- a/arch/arm/configs/omap_zoom2_defconfig
> +++ b/arch/arm/configs/omap_zoom2_defconfig
> @@ -1350,7 +1350,7 @@ CONFIG_ENABLE_MUST_CHECK=3Dy
>  CONFIG_FRAME_WARN=3D1024
>  CONFIG_MAGIC_SYSRQ=3Dy
>  # CONFIG_UNUSED_SYMBOLS is not set
> -# CONFIG_DEBUG_FS is not set
> +CONFIG_DEBUG_FS=3Dy
>  # CONFIG_HEADERS_CHECK is not set
>  CONFIG_DEBUG_KERNEL=3Dy
>  # CONFIG_DEBUG_SHIRQ is not set

It is nicer to provide the build failure log. But if this is a build
failure, this means there is a problem with Kconfig dependency, which
should be fixed properly, not hidden.

--=20
Best Regards,
Artem Bityutskiy (=D0=90=D1=80=D1=82=D1=91=D0=BC =D0=91=D0=B8=D1=82=D1=8E=
=D1=86=D0=BA=D0=B8=D0=B9)

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
