From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap multiplatform warning fixes for v3.9 merge window
Date: Sat, 9 Feb 2013 20:19:49 -0800
Message-ID: <20130210041949.GG4801@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:63561 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1761058Ab3BJETy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 9 Feb 2013 23:19:54 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

The following changes since commit ad1bb1b4e01c5ecbe32133ce6921d0e76cb7=
6dcf:

  ARM: OMAP2+: Remove now obsolete uncompress.h and debug-macro.S (2013=
-01-11 11:24:20 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/=
omap-for-v3.9/multiplatform-fixes-signed-v2

for you to fetch changes up to 09cee18dbced86b27c6c7d4501126cf2a287d089=
:

  ARM: OMAP2+: Make sure files with omap initcalls include soc.h (2013-=
02-09 19:20:57 -0800)

----------------------------------------------------------------
=46ew trivial compile warning fixes if omap initcalls are
used but soc.h is not included.

----------------------------------------------------------------
Andr=C3=A9 Hentschel (1):
      ARM: OMAP2+: Include soc.h to drm.c to fix compiling

Tony Lindgren (2):
      ARM: OMAP2+: Fix warning for hwspinlock omap_postcore_initcall
      ARM: OMAP2+: Make sure files with omap initcalls include soc.h

 arch/arm/mach-omap2/drm.c                | 1 +
 arch/arm/mach-omap2/hwspinlock.c         | 1 +
 arch/arm/mach-omap2/omap-iommu.c         | 1 +
 arch/arm/mach-omap2/smartreflex-class3.c | 1 +
 4 files changed, 4 insertions(+)
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
