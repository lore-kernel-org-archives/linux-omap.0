From: Kevin Hilman <khilman@ti.com>
Subject: [GIT PULL] OMAP PM fixes for v3.0-rc
Date: Mon, 06 Jun 2011 16:29:43 -0700
Message-ID: <87oc2atu6w.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:54249 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752048Ab1FFX3q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Jun 2011 19:29:46 -0400
Received: by mail-pz0-f43.google.com with SMTP id 1so2649106pzk.2
        for <linux-omap@vger.kernel.org>; Mon, 06 Jun 2011 16:29:45 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Tony,

Please pull the following fixes for v3.0-rc.  Looks like I just missed
your pull request, so you can add this to the next one.

Note that I split the section mismatch patch from Russell into two.  One
to go through you for OMAP core and the other (GPIO) to go through that
driver tree.

Kevin


The following changes since commit 59c5f46fbe01a00eedf54a23789634438bb80603:

  Linux 3.0-rc2 (2011-06-06 18:06:33 +0900)

are available in the git repository at:
  ssh://master.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git for_3.0/pm-fixes

Kevin Hilman (1):
      OMAP: PM: omap_device: fix device power domain callbacks

Russell King (1):
      OMAP: PM debug: fix section mismatch warnings

 arch/arm/mach-omap2/pm-debug.c   |    4 ++--
 arch/arm/plat-omap/omap_device.c |   19 +++++++++++++++++--
 2 files changed, 19 insertions(+), 4 deletions(-)
