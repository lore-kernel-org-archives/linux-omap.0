From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [GIT PULL] OMAP: PM: cleanups for v3.8
Date: Tue, 06 Nov 2012 15:49:14 -0800
Message-ID: <87zk2u1edh.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:48273 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753335Ab2KFXtQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Nov 2012 18:49:16 -0500
Received: by mail-pa0-f46.google.com with SMTP id hz1so700259pad.19
        for <linux-omap@vger.kernel.org>; Tue, 06 Nov 2012 15:49:16 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

Tony,

Here is some PM related cleanup targetted for v3.8.

Kevin


The following changes since commit 6f0c0580b70c89094b3422ba81118c7b959c7556:

  Linux 3.7-rc2 (2012-10-20 12:11:32 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git tags/for_3.8-cleanup-pm

for you to fetch changes up to 9bb053787d5ca12ec388bb5f871c79ffb83762ab:

  ARM: OMAP2+: PM: VP: minor pr_warn updates (2012-10-25 14:32:34 -0700)

----------------------------------------------------------------
Minor pr_warn() cleanup for OMAP2+ Voltage Processor (VP)

----------------------------------------------------------------
Nishanth Menon (1):
      ARM: OMAP2+: PM: VP: minor pr_warn updates

 arch/arm/mach-omap2/vp.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)
