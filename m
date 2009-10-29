From: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
Subject: [PATCH 0/3] Update CPU idle parameter passing
Date: Thu, 29 Oct 2009 10:30:17 +0200
Message-ID: <1256805020-7402-1-git-send-email-kalle.jokiniemi@digia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.digia.com ([82.118.214.156]:12128 "EHLO smtp1.digia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753085AbZJ2IaH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 29 Oct 2009 04:30:07 -0400
In-Reply-To: <>
References: <>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org, rnayak@ti.com, jouni.hogander@nokia.com

Hi Kevin,

Made some patches to enable setting RX-51 cpu idle parameters
as we use them. Added "valid" field passing to cpuidle_params
in the process.

Tested on RX-51. Applies on top of linux-omap/pm branch.

Kalle Jokiniemi (3):
      OMAP:PM: Fix non-cpu idle builds using omap3_pm_init_cpuidle
      OMAP3: Add valid field into C-state parameter passing
      OMAP: RX-51: Pass cpu idle parameters

kajokini@ubuntu:~/work/linux-open/linux-omap$ git diff --stat HEAD~3..HEAD
 arch/arm/mach-omap2/board-3430sdp.c |   14 ++++++------
 arch/arm/mach-omap2/board-rx51.c    |   18 +++++++++++++++++
 arch/arm/mach-omap2/cpuidle34xx.c   |   37 +++++++++++++++++++++-------------
 arch/arm/mach-omap2/pm.h            |    8 +++++++
 4 files changed, 56 insertions(+), 21 deletions(-)


