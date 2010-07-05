From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 18/33] Removing dead OMAP_ARM_96MHZ
Date: Mon, 5 Jul 2010 11:44:50 +0300
Message-ID: <20100705084448.GJ15951@atomide.com>
References: <cover.1277911345.git.siccegge@cs.fau.de>
 <8304abb0dbda307c488b6fe2b3cc8df3c9909eb6.1277911346.git.siccegge@cs.fau.de>
 <201006302025.14881.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201006302025.14881.marek.vasut@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marek Vasut <marek.vasut@gmail.com>
Cc: Christoph Egger <siccegge@cs.fau.de>, Russell King <linux@arm.linux.org.uk>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, vamos@i4.informatik.uni-erlangen.de
List-Id: linux-omap@vger.kernel.org

* Marek Vasut <marek.vasut@gmail.com> [100630 21:21]:
> Dne St 30. =C4=8Dervna 2010 17:59:45 Christoph Egger napsal(a):
> > OMAP_ARM_96MHZ doesn't exist in Kconfig, therefore removing all
> > references for it from the source code.
>=20
> I'd be for adding it to Kconfig rather than removing from here

Looks like Paul has queued a patch to do this.

Tony
