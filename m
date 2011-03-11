From: Kevin Hilman <khilman@ti.com>
Subject: [GIT PULL] another set of OMAP PM updates for 2.6.39
Date: Fri, 11 Mar 2011 09:37:37 -0800
Message-ID: <87r5ada78e.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:60653 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751284Ab1CKRhm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Mar 2011 12:37:42 -0500
Received: by mail-gx0-f174.google.com with SMTP id 21so230994gxk.19
        for <linux-omap@vger.kernel.org>; Fri, 11 Mar 2011 09:37:41 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Tony,

Please pull this additional set of OMAP PM updates for 2.6.39.

These changes had dependencies on Paul's integration branch so were
awaiting the merge of that before they could merge.

Kevin

The following changes since commit a08572ae529b1e8de12393eeced661feae8fd44c:

  Merge remote branch 'remotes/origin/voltage_split_2.6.39' into tmp-integration-2.6.39-20110310-024 (2011-03-10 22:43:32 -0700)

are available in the git repository at:

  ssh://master.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git for_2.6.39/pm-integration

Jean Pihet (1):
      perf: add OMAP support for the new power events

Shweta Gulati (3):
      OMAP4: Enable 800 MHz and 1 GHz MPU-OPP
      OMAP4: Update Voltage Rail Values for MPU, IVA and CORE
      OMAP4: Add IVA OPP enteries.

Vishwanath BS (1):
      OMAP3+: OPP: Replace voltage values with Macros

 arch/arm/mach-omap2/clock.c        |   11 +++++++-
 arch/arm/mach-omap2/opp3xxx_data.c |   46 ++++++++++++++++++------------------
 arch/arm/mach-omap2/opp4xxx_data.c |   38 +++++++++++++++++------------
 arch/arm/mach-omap2/pm34xx.c       |    7 +++++
 arch/arm/mach-omap2/powerdomain.c  |   26 ++++++++++++++++++--
 5 files changed, 84 insertions(+), 44 deletions(-)
