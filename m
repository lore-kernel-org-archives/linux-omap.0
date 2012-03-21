From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH 0/3] OMAP2+: UART: Enable tx wakeup + remove cpu checks
Date: Wed, 21 Mar 2012 15:54:58 +0530
Message-ID: <1332325501-10467-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36635 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757944Ab2CUKZZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Mar 2012 06:25:25 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Felipe Balbi <balbi@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>

From: "Govindraj.R" <govindraj.raja@ti.com>

Based on Linux-OMAP tree uart branch.
(git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git
remotes/origin/uart)

* Removes the cpu checks wherever possible and use version reg
  for populating features and errata's
* enable tx wakeup available in wer reg for applicable
  module revision's

Govindraj.R (3):
  OMAP2+: UART: Remove cpu checks for populating errata flags
  OMAP2+: UART: enable tx wakeup bit for wer reg
  OMAP2+: UART: replace omap34xx/omap4xx cpu checks with not omap24xx

 arch/arm/mach-omap2/serial.c                  |   13 +----
 arch/arm/plat-omap/include/plat/omap-serial.h |    8 +++-
 drivers/tty/serial/omap-serial.c              |   71 ++++++++++++++++++++++++-
 3 files changed, 78 insertions(+), 14 deletions(-)

-- 
1.7.5.4

