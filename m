From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCH] ARM: configs: Select USB PHY for AM335x SoC
Date: Thu, 26 Dec 2013 09:08:34 -0300
Message-ID: <20131226120833.GA24645@localhost>
References: <1386861269-28949-1-git-send-email-ezequiel.garcia@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:56643 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752714Ab3LZMI1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Dec 2013 07:08:27 -0500
Content-Disposition: inline
In-Reply-To: <1386861269-28949-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>

=46elipe,

On Thu, Dec 12, 2013 at 12:14:29PM -0300, Ezequiel Garcia wrote:
> Enable this option as it's required to use USB on AM335x SoC.
>=20
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  arch/arm/configs/omap2plus_defconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/=
omap2plus_defconfig
> index 12c848e..e427b95 100644
> --- a/arch/arm/configs/omap2plus_defconfig
> +++ b/arch/arm/configs/omap2plus_defconfig
> @@ -223,6 +223,7 @@ CONFIG_USB_TEST=3Dy
>  CONFIG_NOP_USB_XCEIV=3Dy
>  CONFIG_OMAP_USB2=3Dy
>  CONFIG_OMAP_USB3=3Dy
> +CONFIG_AM335X_PHY_USB=3Dy
>  CONFIG_USB_GADGET=3Dy
>  CONFIG_USB_GADGET_DEBUG=3Dy
>  CONFIG_USB_GADGET_DEBUG_FILES=3Dy
> --=20
> 1.8.1.5
>=20

Maybe you can take this through your tree?
--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
