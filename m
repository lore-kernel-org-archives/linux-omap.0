From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [PATCH 3.4-rc4] ARM: OMAP1: Amstrad Delta: Fix wrong IRQ base in FIQ handler
Date: Mon, 07 May 2012 23:16:25 +0200
Message-ID: <1470735.vzc89Ry7Ka@acer>
References: <1335806769-23711-1-git-send-email-jkrzyszt@tis.icnet.pl> <20120504165948.GC5613@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120504165948.GC5613@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Dnia pi=C4=85tek, 4 maja 2012 09:59:49 Tony Lindgren pisze:
> * Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [120430 10:30]:
> > Commit 384ebe1c2849160d040df3e68634ec506f13d9ff, "gpio/omap: Add DT
> > support to GPIO driver", introduced dynamic IRQ numbering of OMAP=20
GPIO
> > interrupts, breaking all IH_GPIO_BASE based IRQ number calculations=
=2E
> > This issue was corrected in the OMAP GPIO driver and the related=20
header
> > file with commit 25db711df3258d125dc1209800317e5c0ef3c870,=20
"gpio/omap:
> > Fix IRQ handling for SPARSE_IRQ".
> >=20
> > However, the Amstrad Delta FIQ handler, which replaces the gpio-oma=
p
> > driver in serving GPIO interrupts on this board, still uses that
> > outdated method. Fix it.
>=20
> Thanks applying into fixes.

Hi Tony,
Thanks for taking this patch, but I ca't see it applied into your fixes=
=20
branch (the last one sitting there is "Linux 3.4-rc4" by Linus). Am I=20
missing something?

Regards,
Janusz
