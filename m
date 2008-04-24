From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/5] Powerdomains: add OMAP2/3 powerdomain code and
	common OMAP type bitfield
Date: Wed, 23 Apr 2008 17:04:50 -0700
Message-ID: <20080424000449.GC27546@atomide.com>
References: <20080419012246.6809.79667.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:63757 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750828AbYDXAEy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Apr 2008 20:04:54 -0400
Content-Disposition: inline
In-Reply-To: <20080419012246.6809.79667.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, igor.stoppa@nokia.com, sakari.poussa@nokia.com, jouni.hogander@nokia.com, r-woodruff2@ti.com

* Paul Walmsley <paul@pwsan.com> [080418 18:35]:
>=20
> Hi everyone,
>=20
> This is the second version of the powerdomain patches.  It:
>=20
> . replaces omap_type_t typedef with struct omap_chip_id
>=20
> . fixes 34xx bug in OMAP type detection code
>=20
> . removes all EXPORT_SYMBOLs - these can be added back in if powerdom=
ain
>   code needs to be used from loadable PM modules - the expectation is=
 that
>   it will only be used from PM code
>=20
> . gets rid of all of the forward declarations in the powerdomain
>   dependency definitions - now uses powerdomain names
>=20
> . creates _pwrdm_lookup() to avoid potential race in pwrdm_register()
>=20
> . gets rid of tabs in comments
>=20
> . cleans up some dead structure members in struct powerdomain
>=20
> . adds IVA2 sleepdep for DSS, PER, USBHOST
>=20
> . is refreshed against current git head (e015fc7)
>=20
> This version is tested against 3430SDP ES2.1, and compile-tested with
> the N800 and 2430SDP configs.  Size, diffstat have been updated below=
=2E
>=20
> Thanks to Tony & Jouni for review and comments.  More comments welcom=
e,

Pushing today.

Tony

>=20
>=20
> - Paul
>=20
> -------------------------
>=20
> Hello,
>=20
> this patch series adds a hardware control and monitoring interface fo=
r
> OMAP2/3 powerdomains.  The interface is fully documented in the code.
>=20
> The series also adds a common OMAP chip type detection bitfield for u=
se
> with powerdomain and clockdomain structures; it is planned to expand =
its
> use to the clock framework in the future.
>=20
> Powerdomain code tested on 3430SDP ES2.1; also boot-tested on N800.
>=20
> Many people at Nokia and TI provided commentary and review during the
> development of the powerdomain patches.  Particular help came from (i=
n
> alphabetical order): Jouni H=F6gander, Tony Lindgren, Sakari Poussa,
> Igor Stoppa, and Richard Woodruff.
>=20
> ---
>=20
>    text    data     bss     dec     hex filename
> 3265996  151704  100736 3518436  35afe4 vmlinux.3430sdp.orig
> 3269405  152552  100736 3522693  35c085 vmlinux.3430sdp
>=20
>=20
> Paul Walmsley (5):
>       Subject: add OMAP3 powerdomains
>       Subject: add OMAP2 powerdomains
>       Subject: add OMAP2/3 common powerdomains
>       Subject: add base OMAP2/3 powerdomain code
>       Subject: add OMAP chip type global bitfield; clean up mach-omap=
2/id.c
>=20
>=20
>  arch/arm/mach-omap2/Makefile            |    2
>  arch/arm/mach-omap2/id.c                |  167 ++++--
>  arch/arm/mach-omap2/io.c                |    5
>  arch/arm/mach-omap2/pm.c                |    2
>  arch/arm/mach-omap2/powerdomain.c       |  885 +++++++++++++++++++++=
++++++++++
>  arch/arm/mach-omap2/powerdomains.h      |  187 +++++++
>  arch/arm/mach-omap2/powerdomains24xx.h  |  200 +++++++
>  arch/arm/mach-omap2/powerdomains34xx.h  |  327 +++++++++++
>  arch/arm/mach-omap2/prcm-common.h       |    3
>  arch/arm/mach-omap2/prm-regbits-24xx.h  |   12
>  arch/arm/mach-omap2/prm-regbits-34xx.h  |   11
>  arch/arm/mach-omap2/prm.h               |    3
>  arch/arm/plat-omap/Kconfig              |   12
>  include/asm-arm/arch-omap/cpu.h         |   33 +
>  include/asm-arm/arch-omap/powerdomain.h |  137 +++++
>  15 files changed, 1924 insertions(+), 62 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/powerdomain.c
>  create mode 100644 arch/arm/mach-omap2/powerdomains.h
>  create mode 100644 arch/arm/mach-omap2/powerdomains24xx.h
>  create mode 100644 arch/arm/mach-omap2/powerdomains34xx.h
>  create mode 100644 include/asm-arm/arch-omap/powerdomain.h
>=20
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
