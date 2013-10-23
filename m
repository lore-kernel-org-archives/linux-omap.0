From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCH v10 10/10] mtd: nand: omap: remove selection of BCH
 ecc-scheme via KConfig
Date: Wed, 23 Oct 2013 10:44:51 -0300
Message-ID: <20131023134450.GE2458@localhost>
References: <1382172254-12448-1-git-send-email-pekon@ti.com>
 <1382172254-12448-11-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:46197 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751275Ab3JWNoc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Oct 2013 09:44:32 -0400
Content-Disposition: inline
In-Reply-To: <1382172254-12448-11-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pekon Gupta <pekon@ti.com>
Cc: mark.rutland@arm.com, olof@lixom.net, computersforpeace@gmail.com, dedekind1@gmail.com, devicetree@vger.kernel.org, Pawel.Moll@arm.com, arnd@arndb.de, swarren@wwwdotorg.org, tony@atomide.com, jp.francois@cynove.com, ijc+devicetree@hellion.org.uk, avinashphilipk@gmail.com, balbi@ti.com, robherring2@gmail.com, bcousson@baylibre.com, linux-mtd@lists.infradead.org, ivan.djelic@parrot.com, linux-omap@vger.kernel.org, dwmw2@infradead.org

Gupta,

I already have a question :-)

On Sat, Oct 19, 2013 at 02:14:14PM +0530, Pekon Gupta wrote:
> With OMAP NAND driver updates, selection of ecc-scheme:
> *DT enabled kernel*
>  	depends on ti,nand-ecc-opt and ti,elm-id DT bindings.
> *Non DT enabled kernel*
> 	depends on elm_dev and ecc-scheme passed along with platform-data
> 	from board file.
>=20
> So, selection of ecc-scheme (BCH8 or BCH4) from KConfig can be remove=
d
>=20
> Signed-off-by: Pekon Gupta <pekon@ti.com>
> ---
>  drivers/mtd/nand/Kconfig | 40 ++++++--------------------------------=
--
>  1 file changed, 6 insertions(+), 34 deletions(-)
>=20
> diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
> index d885298..93ae6a6 100644
> --- a/drivers/mtd/nand/Kconfig
> +++ b/drivers/mtd/nand/Kconfig
> @@ -96,43 +96,15 @@ config MTD_NAND_OMAP2
> =20
>  config MTD_NAND_OMAP_BCH
>  	depends on MTD_NAND && MTD_NAND_OMAP2 && ARCH_OMAP3

I'm wondering how are you testing this in your SOC_AM33XX board (which
is not ARCH_OMAP3). You probably have ARCH_OMAP3 always selected?

IMO, no need to depend on any ARCH_xxx, just make it depend on the driv=
er
option itself, which already depends on ARCH_OMAP2PLUS (which is the bi=
gger
SoC family).

Care to send a one-patch fix for that, so this *independent* bug can be
taken by Brian? Please add my Reported-by when you do so.

--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
