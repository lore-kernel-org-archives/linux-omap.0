From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] Remove inline from clock framework function definitions
 to build the kernel with GCC 4.7
Date: Thu, 15 Nov 2012 18:45:03 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1211151842450.18192@utopia.booyaka.com>
References: <50A52134.2010502@gmail.com> <50A53368.6090306@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="843723315-720177955-1353005103=:18192"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <50A53368.6090306@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>, i.mazanov@gmail.com
Cc: Mike Turquette <mturquette@ti.com>, linux-omap@vger.kernel.org, tony@atomide.com, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--843723315-720177955-1353005103=:18192
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 15 Nov 2012, Jon Hunter wrote:

>=20
> On 11/15/2012 11:07 AM, Igor Mazanov wrote:
> >  Remove inline from clock framework function definitions to
> >  build the kernel with GCC 4.7
>=20
> Adding Mike to the party ...
>=20
> May be good to add some details about the exact problem seen.
>=20
> I am seeing the same problem today with GCC 4.7 and Tony's master
> branch. For a bit of background it seems that for 4.7 not having
> the body of the inlined function available in the header is
> causing this error. Another example here [1].
>=20
> The actual compiler error seen for OMAP is ...
>=20
> In file included from arch/arm/mach-omap2/clockdomain.c:25:0:
> arch/arm/mach-omap2/clockdomain.c: In function =E2=80=98clkdm_clk_disable=
=E2=80=99:
> include/linux/clk-provider.h:338:12: error: inlining failed in call to al=
ways_inline =E2=80=98__clk_get_enable_count=E2=80=99: function body not ava=
ilable
> arch/arm/mach-omap2/clockdomain.c:1001:28: error: called from here
> make[1]: *** [arch/arm/mach-omap2/clockdomain.o] Error 1
> make: *** [arch/arm/mach-omap2] Error 2

Yep this one is for Mike to fix in the main CCF code; it's not an=20
OMAP-specific issue.  sparse warns about this too, so it's not just a gcc=
=20
4.7 problem.

> Do we also need to remove the inline from the functions declared in
> drivers/clk/clk.c too?

It's usually best to just let the compiler decide whether to inline=20
functions.  For example, Documentation/CodingStyle Chapter 15.


- Paul
--843723315-720177955-1353005103=:18192--
