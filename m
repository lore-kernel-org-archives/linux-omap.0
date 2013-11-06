From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCH 0/3] omap2: Assorted GPMC cleanups
Date: Wed, 6 Nov 2013 16:16:23 -0300
Message-ID: <20131106191622.GA3162@localhost>
References: <1382921508-5104-1-git-send-email-ezequiel.garcia@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:47622 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751768Ab3KFTQZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Nov 2013 14:16:25 -0500
Content-Disposition: inline
In-Reply-To: <1382921508-5104-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Javier Martinez Canillas <martinez.javier@gmail.com>, Enric Balletbo Serra <eballetbo@gmail.com>, Pekon Gupta <pekon@ti.com>, Tony Lindgren <tony@atomide.com>, linux-mtd@lists.infradead.org, Jon Hunter <jgchunter@gmail.com>

On Sun, Oct 27, 2013 at 09:51:45PM -0300, Ezequiel Garcia wrote:
> (I'm CCing the MTD list, because GPMC is the memory controller
> used for NOR, NAND and OneNAND devices).
>=20
> Hi all,
>=20
> Just a small patchset containing two small cleanups and a minor fix
> for the GPMC memory controller. The first two are cleanups and can
> be considered as preparation work for the fix.
>=20
> The fix is patch 3/3: "Move legacy GPMC width setting". It makes
> explicit use of the DT property "gpmc,device-width" and removes the
> subsequent (and redundant) setting of the GPMC width, based in the
> NAND bus widht.
>=20
> Tested in AM335x (using DT) so I'd appreciate if someone can test usi=
ng
> a board-file, on a device with NAND flash.
>=20
> Jon: If you happen to read this, I'd like if you could take a look at
> patch 1/3, since you were the last to touch that part of the code.
>=20
> Thanks!
>=20
> Ezequiel Garcia (3):
>   omap2: gpmc: Move initialization outside the gpmc_t condition
>   omap2: gpmc: Introduce gpmc_set_legacy()
>   omap2: gpmc: Move legacy GPMC width setting
>=20
>  arch/arm/mach-omap2/gpmc-nand.c | 50 +++++++++++++++++++++++--------=
----------
>  1 file changed, 28 insertions(+), 22 deletions(-)
>=20

Any comments about this?

Pekon? Maybe you can comment or otherwise ack the patches?

Thanks!
--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
