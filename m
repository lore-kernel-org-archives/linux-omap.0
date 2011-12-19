From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] Borderline fixes for v3.2-rc6
Date: Mon, 19 Dec 2011 11:42:49 -0800
Message-ID: <20111219194249.GO6464@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:53026 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752145Ab1LSTmy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Dec 2011 14:42:54 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi Arnd & Olof,

Here are two fixes that could potentially go into v3.2 -rc cycle.

One fixes a harmless but annoying warning that happens on omap 34xx
processors during boot. The other one fixes booting on pretty rare
secure mode development board, but that's fixed in "features that
never worked earlier either" style.

We can surely wait on these fixes, but if you have something going
upstream anyways, then these might be worth considering too.

I'll post a following pull request for fixes-non-critical-part2
that is based on this one, so no need to pull in this one in case
you're not sending any more fixes for the -rc cycle:

git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap fixes-hwmod

Regards,

Tony


The following changes since commit e5fe29c7198a1f6616286dfc8602a69da165cb3f:
  Felipe Contreras (1):
        ARM: OMAP: rx51: fix USB

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap fixes-hwmod

Aaro Koskinen (1):
      ARM: OMAP: hwmod data: fix the panic on Nokia RM-680 during boot

Felipe Contreras (1):
      ARM: OMAP: hwmod data: fix iva and mailbox hwmods for OMAP 3

Tony Lindgren (1):
      Merge branch 'hwmod_data_fixes_3.2rc' of git://git.pwsan.com/linux-2.6 into fixes-hwmod

 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   18 +++++++++++++-----
 1 files changed, 13 insertions(+), 5 deletions(-)
