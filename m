From: Kevin Hilman <khilman@ti.com>
Subject: [GIT PULL] OMAP: AM3xxx: cpu_is dead code removal
Date: Wed, 30 May 2012 16:43:04 -0700
Message-ID: <877gvt44mv.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog132.obsmtp.com ([74.125.149.250]:37402 "EHLO
	na3sys009aog132.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751425Ab2E3XnH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 30 May 2012 19:43:07 -0400
Received: by pbbrp2 with SMTP id rp2so661446pbb.0
        for <linux-omap@vger.kernel.org>; Wed, 30 May 2012 16:43:05 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

Tony,

These couple patches didn't make it for v3.5 because of some cross-tree
dependencies.  All the dependencies are now merged (after Linus merged
arm-soc/next/pm), so here's the remaining patches.

Not sure if you want to get them in for 3.5-rc or queue them in your
cleanup branch for v3.6.  Up to you.

Kevin


The following changes since commit cdd3a354a05b0c33fe33ab11a0fb0838396cad19:

  Merge tag 'pm' of git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc (2012-05-22 09:41:01 -0700)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git for_3.5/cleanup/am3xxx-cpu-is-leftovers

for you to fetch changes up to 96f3994929c05a21d757a83613d2710b780ea2b4:

  ARM: OMAP: SoC detection: remove unused cpu_is macros (2012-05-25 15:48:48 -0700)

----------------------------------------------------------------
Kevin Hilman (2):
      ARM: OMAP3: clock data: cleanup AM3[35]x SoC detection
      ARM: OMAP: SoC detection: remove unused cpu_is macros

 arch/arm/mach-omap2/clock3xxx_data.c  |    2 +-
 arch/arm/plat-omap/include/plat/cpu.h |   33 ---------------------------------
 2 files changed, 1 insertion(+), 34 deletions(-)
