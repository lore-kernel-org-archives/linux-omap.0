From: jean.pihet@newoldbits.com
Subject: [PATCH 0/6] ARM: OMAP3+: smartreflex: add class support
Date: Tue, 13 Mar 2012 11:26:15 +0100
Message-ID: <1331634381-31436-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:62731 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030335Ab2CMK0r (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Mar 2012 06:26:47 -0400
Received: by wibhq7 with SMTP id hq7so577560wib.1
        for <linux-omap@vger.kernel.org>; Tue, 13 Mar 2012 03:26:46 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>
Cc: Jean Pihet <j-pihet@ti.com>

From: Jean Pihet <j-pihet@ti.com>

Add the class support so that various classes of operation can be
implemented (class 1p5 etc.).

Based on linux-omap's master branch (3.3.0-rc6), commit
85244e0edd240da2004bb2ab7cbcbc67a336f20d


Nishanth Menon (6):
  ARM: OMAP3+: SmartReflex: introduce class init, deinit and priv data
  ARM: OMAP3+: SmartReflex: introduce notifiers flags
  ARM: OMAP3+: SmartReflex: introduce notifier_control
  ARM: OMAP3+: SmartReflex: disable spamming interrupts
  ARM: OMAP3+: SmartReflex: introduce class private data per voltage
    domain
  ARM: OMAP3+: SmartReflex Class3: restrict CPU to run on

 arch/arm/mach-omap2/smartreflex-class3.c |   15 ++-
 arch/arm/mach-omap2/smartreflex.c        |  193 ++++++++++++++++++++++++++++--
 arch/arm/mach-omap2/smartreflex.h        |   30 ++++-
 3 files changed, 222 insertions(+), 16 deletions(-)

-- 
1.7.5.4

