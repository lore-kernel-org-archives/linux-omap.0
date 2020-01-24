From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 1/3] randconfig build fix for omap soc changes for v5.6
Date: Fri, 24 Jan 2020 12:11:22 -0800
Message-ID: <pull-1579896427-50330@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:52186 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403928AbgAXUL2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Fri, 24 Jan 2020 15:11:28 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: soc@kernel.org
Cc: arm@kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>

From: "Tony Lindgren" <tony@atomide.com>

The following changes since commit 8ab871f8bdfcca627802b6992e556fba5722a268:

  ARM: OMAP2+: sleep43xx: Call secure suspend/resume handlers (2020-01-13 10:06:46 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v5.6/soc-build-fix-signed

for you to fetch changes up to c37baa06f8a970e4a533d41f7d33e5e57de5ad25:

  ARM: OMAP2+: Fix undefined reference to omap_secure_init (2020-01-23 07:48:26 -0800)

----------------------------------------------------------------
Randconfig build fix for recent SoC changes for v5.6

We can get build failures if let's say if only am335x SoC is selected.
Let's fix this by always building secure-common.

----------------------------------------------------------------
Andrew F. Davis (1):
      ARM: OMAP2+: Fix undefined reference to omap_secure_init

 arch/arm/mach-omap2/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)
