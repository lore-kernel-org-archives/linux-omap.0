From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP4: hwmod data: correct the idlemodes for
 spinlock
Date: Thu, 26 Dec 2013 04:49:26 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1312260447320.15949@utopia.booyaka.com>
References: <1387838928-57745-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="843723315-886352108-1388033366=:15949"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:41837 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752532Ab3LZEt1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Dec 2013 23:49:27 -0500
In-Reply-To: <1387838928-57745-1-git-send-email-s-anna@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Suman Anna <s-anna@ti.com>, bcousson@baylibre.com
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--843723315-886352108-1388033366=:15949
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

(cc Beno=EEt)

On Mon, 23 Dec 2013, Suman Anna wrote:

> The spinlock module's SYSCONFIG register does not support
> smart wakeup, so remove this flag from the idle modes in
> the spinlock hwmod definition.
>=20
> Signed-off-by: Suman Anna <s-anna@ti.com>

Beno=EEt Cousson is the primary maintainer of this file that you're=20
changing:

$ scripts/get_maintainer.pl -f arch/arm/mach-omap2/omap_hwmod_44xx_data.c
"Beno=EEt Cousson" <bcousson@baylibre.com> (maintainer:OMAP HWMOD DATA F...=
)
Tony Lindgren <tony@atomide.com> (maintainer:OMAP SUPPORT)
Russell King <linux@arm.linux.org.uk> (maintainer:ARM PORT)
linux-omap@vger.kernel.org (open list:OMAP HWMOD DATA F...)
linux-arm-kernel@lists.infradead.org (moderated list:ARM SUB-ARCHITECT...)
linux-kernel@vger.kernel.org (open list)
$

Please make sure that he's part of the address list when patches are sent=
=20
that apply against this file. =20


- Paul
--843723315-886352108-1388033366=:15949--
