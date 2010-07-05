From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH 17/33] Removing dead SX1_OLD_FLASH
Date: Mon, 5 Jul 2010 12:31:13 +0200
Message-ID: <201007051231.14171.marek.vasut@gmail.com>
References: <cover.1277911345.git.siccegge@cs.fau.de> <201006302024.47025.marek.vasut@gmail.com> <20100705083346.GI15951@atomide.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100705083346.GI15951@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Christoph Egger <siccegge@cs.fau.de>, Russell King <linux@arm.linux.org.uk>, Kalle Valo <kalle.valo@iki.fi>, Ladislav Michl <ladis@linux-mips.org>, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, vamos@i4.informatik.uni-erlangen.de
List-Id: linux-omap@vger.kernel.org

Dne Po 5. =C4=8Dervence 2010 10:33:48 Tony Lindgren napsal(a):
> * Marek Vasut <marek.vasut@gmail.com> [100630 21:21]:
> > Dne St 30. =C4=8Dervna 2010 17:59:25 Christoph Egger napsal(a):
> > > SX1_OLD_FLASH doesn't exist in Kconfig, therefore removing all
> > > references for it from the source code.
> >=20
> > There were two models of the phone made, you can toggle between old=
 and
> > new version. Maybe better documentation won't hurt.
>=20
> Sounds like this should be done dynamically based on omap_rev,
> or some cmdline option from the bootloader? Not applying this
> one.
>=20
> Tony

Yea, the russian guy who ported this is gone I guess though. Just maybe=
 I can=20
get my hands on linux-powered SX1 and try looking into this, but I can'=
t promise=20
it'll be any soon.

Cheers
