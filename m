From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 17/33] Removing dead SX1_OLD_FLASH
Date: Mon, 5 Jul 2010 11:33:48 +0300
Message-ID: <20100705083346.GI15951@atomide.com>
References: <cover.1277911345.git.siccegge@cs.fau.de>
 <5b21086199b139a61888c16e92d3efe6b205dae2.1277911346.git.siccegge@cs.fau.de>
 <201006302024.47025.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:62597 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751651Ab0GEIec (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Jul 2010 04:34:32 -0400
Content-Disposition: inline
In-Reply-To: <201006302024.47025.marek.vasut@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Marek Vasut <marek.vasut@gmail.com>
Cc: Christoph Egger <siccegge@cs.fau.de>, Russell King <linux@arm.linux.org.uk>, Kalle Valo <kalle.valo@iki.fi>, Ladislav Michl <ladis@linux-mips.org>, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, vamos@i4.informatik.uni-erlangen.de

* Marek Vasut <marek.vasut@gmail.com> [100630 21:21]:
> Dne St 30. =C4=8Dervna 2010 17:59:25 Christoph Egger napsal(a):
> > SX1_OLD_FLASH doesn't exist in Kconfig, therefore removing all
> > references for it from the source code.
>=20
> There were two models of the phone made, you can toggle between old a=
nd new=20
> version. Maybe better documentation won't hurt.

Sounds like this should be done dynamically based on omap_rev,
or some cmdline option from the bootloader? Not applying this
one.

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
