From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCH 0/3] omap2: Assorted GPMC cleanups
Date: Wed, 8 Jan 2014 20:38:16 -0300
Message-ID: <20140108233815.GC2595@localhost>
References: <1382921508-5104-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20140108191836.GD31323@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:42052 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757355AbaAHXh7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Jan 2014 18:37:59 -0500
Content-Disposition: inline
In-Reply-To: <20140108191836.GD31323@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Javier Martinez Canillas <martinez.javier@gmail.com>, Enric Balletbo Serra <eballetbo@gmail.com>, Pekon Gupta <pekon@ti.com>, linux-mtd@lists.infradead.org, Jon Hunter <jgchunter@gmail.com>

On Wed, Jan 08, 2014 at 11:18:37AM -0800, Tony Lindgren wrote:
> * Ezequiel Garcia <ezequiel.garcia@free-electrons.com> [131027 17:52]=
:
> > (I'm CCing the MTD list, because GPMC is the memory controller
> > used for NOR, NAND and OneNAND devices).
> >=20
> > Hi all,
> >=20
> > Just a small patchset containing two small cleanups and a minor fix
> > for the GPMC memory controller. The first two are cleanups and can
> > be considered as preparation work for the fix.
> >=20
> > The fix is patch 3/3: "Move legacy GPMC width setting". It makes
> > explicit use of the DT property "gpmc,device-width" and removes the
> > subsequent (and redundant) setting of the GPMC width, based in the
> > NAND bus widht.
>=20
> Thanks and sorry for the delay. Applying these all into branch
> omap-for-v3.14/fixes-not-urgent.
>=20

No problem. I'll give this a test/review next week.

Do we still need the board-file (legacy) workaround in this patchset?
I was actually waiting for you to clean-up completely that, before
re-sending the series, without the board-file workaround.
--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
