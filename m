From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] fix compilation error in cm_common.c
Date: Tue, 20 Nov 2012 10:52:55 +0100
Message-ID: <50AB52F7.9000301@ti.com>
References: <1353403553-13525-1-git-send-email-const@MakeLinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56933 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751798Ab2KTJxG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Nov 2012 04:53:06 -0500
In-Reply-To: <1353403553-13525-1-git-send-email-const@MakeLinux.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Constantine Shulyupin <const@MakeLinux.com>
Cc: paul@pwsan.com, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org

On 11/20/2012 10:25 AM, Constantine Shulyupin wrote:
> From: Constantine Shulyupin <const@MakeLinux.com>
>=20
> Added required linux/errno.h
>=20
> Signed-off-by: Constantine Shulyupin <const@MakeLinux.com>

This supposed to be already fixed:
https://patchwork.kernel.org/patch/1728521/

> ---
>  arch/arm/mach-omap2/cm_common.c |    1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/arm/mach-omap2/cm_common.c b/arch/arm/mach-omap2/cm=
_common.c
> index 3246cef..3fafc27 100644
> --- a/arch/arm/mach-omap2/cm_common.c
> +++ b/arch/arm/mach-omap2/cm_common.c
> @@ -13,6 +13,7 @@
> =20
>  #include <linux/kernel.h>
>  #include <linux/init.h>
> +#include <linux/errno.h>
> =20
>  #include "cm2xxx.h"
>  #include "cm3xxx.h"
>=20


--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
