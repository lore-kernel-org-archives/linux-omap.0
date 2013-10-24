From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCH v11 00/10] [PATCH v10 00/10] mtd:nand:omap2: clean-up of
 supported ECC schemes
Date: Thu, 24 Oct 2013 10:52:59 -0300
Message-ID: <20131024135258.GC9958@localhost>
References: <1382619026-4182-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:50751 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754722Ab3JXNxK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Oct 2013 09:53:10 -0400
Content-Disposition: inline
In-Reply-To: <1382619026-4182-1-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pekon Gupta <pekon@ti.com>
Cc: mark.rutland@arm.com, olof@lixom.net, computersforpeace@gmail.com, dedekind1@gmail.com, devicetree@vger.kernel.org, Pawel.Moll@arm.com, arnd@arndb.de, swarren@wwwdotorg.org, tony@atomide.com, jp.francois@cynove.com, ijc+devicetree@hellion.org.uk, avinashphilipk@gmail.com, balbi@ti.com, robherring2@gmail.com, bcousson@baylibre.com, linux-mtd@lists.infradead.org, ivan.djelic@parrot.com, linux-omap@vger.kernel.org, dwmw2@infradead.org

Hi Pekon,

Just as suggestion, I think you should reconsider your 'upstream strate=
gy'.

On Thu, Oct 24, 2013 at 06:20:16PM +0530, Pekon Gupta wrote:
[..]
>=20
> Pekon Gupta (10):
>   ARM: OMAP2+: cleaned-up DT support of various ECC schemes
>   mtd: nand: omap: combine different flavours of 1-bit hamming ecc sc=
hemes
>   mtd: nand: omap: cleanup: replace local references with generic fra=
mework names

IMHO, this patch about the dobule nand_scan_ident():
>   mtd: nand: omap: use DT specified bus-width only for scanning NAND =
device

is a fix unrelated to this series and can be pushed independently.
Maybe you can try to send it as a one-patch fix?

>   mtd:nand:omap2: clean-up BCHx_HW and BCHx_SW ECC configurations in =
device_probe
>   mtd: nand: omap: clean-up ecc layout for BCH ecc schemes
>   mtd: nand: omap: use drivers/mtd/nand/nand_bch.c wrapper for BCH EC=
C instead of lib/bch.c
>   ARM: dts: AM33xx: updated default ECC scheme in nand-ecc-opt

And also this patch:
>   mtd: nand: omap: updated devm_xx for all resource allocation and fr=
ee calls

doesn't seem to belong to this series.

I think tou could send those two independently and ask Brian to merge t=
hem earlier
if appropriate.

But again, this is just a suggestion.
--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
