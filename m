From: Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: [PATCH 0/4] omap3: Various fixes for IGEP platforms.
Date: Tue,  3 Aug 2010 13:56:10 +0200
Message-ID: <1280836574-32467-1-git-send-email-eballetbo@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:39296 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753016Ab0HCL4W (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Aug 2010 07:56:22 -0400
Received: by wwj40 with SMTP id 40so5028695wwj.1
        for <linux-omap@vger.kernel.org>; Tue, 03 Aug 2010 04:56:21 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello,

Please consider to add these patch which improves the support for IGEP v2 platform and adds support
for the new IGEP OMAP3 module.

$ git diff --stat origin/master
 arch/arm/mach-omap2/Kconfig          |    5 +
 arch/arm/mach-omap2/Makefile         |    2 +
 arch/arm/mach-omap2/board-igep0020.c |  212 ++++++++++++-----
 arch/arm/mach-omap2/board-igep0030.c |  436 ++++++++++++++++++++++++++++++++++
 4 files changed, 594 insertions(+), 61 deletions(-)

Thanks in advance,

Enric
