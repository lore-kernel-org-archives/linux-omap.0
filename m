From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [GIT PULL] ARM: OMAP: PM: few more fixes for v3.7-rc
Date: Mon, 05 Nov 2012 16:56:39 -0800
Message-ID: <87objbczw8.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:38273 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752566Ab2KFA4j (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Nov 2012 19:56:39 -0500
Received: by mail-da0-f46.google.com with SMTP id n41so2924913dak.19
        for <linux-omap@vger.kernel.org>; Mon, 05 Nov 2012 16:56:39 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

Hi Tony,

Here's a couple more trivial fixes for v3.7-rc.

Thanks,

Kevin


The following changes since commit 6f0c0580b70c89094b3422ba81118c7b959c7556:

  Linux 3.7-rc2 (2012-10-20 12:11:32 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git tags/for_3.7-rc5-fixes-pm

for you to fetch changes up to 73c503cb981394872db41dd5cde385cb5373b4b9:

  ARM: OMAP4: PM: fix regulator name for VDD_MPU (2012-11-05 16:30:29 -0800)

----------------------------------------------------------------
Minor OMAP PM fixes for v3.7-rc

----------------------------------------------------------------
Kevin Hilman (2):
      ARM: OMAP2+: PM: add missing newline to VC warning message
      ARM: OMAP4: PM: fix regulator name for VDD_MPU

 arch/arm/mach-omap2/twl-common.c | 2 +-
 arch/arm/mach-omap2/vc.c         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
