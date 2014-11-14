From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 2/2] omap driver changes for v3.19
Date: Fri, 14 Nov 2014 13:06:46 -0800
Message-ID: <21777.9480423362$1415999260@news.gmane.org>
References: <pull-1415999057-591605>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:34377 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754306AbaKNVH3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Nov 2014 16:07:29 -0500
In-Reply-To: <pull-1415999057-591605>
In-Reply-To: <pull-1415999057-591605>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arm@kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

The following changes since commit cac7f2429872d3733dc3f9915857b1691da2eb2f:

  Linux 3.18-rc2 (2014-10-26 16:48:41 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.19/w1-and-l3-noc

for you to fetch changes up to c4cf0935a2d8fe6d186bf4253ea3c4b4a8a8a710:

  bus: omap_l3_noc: Correct returning IRQ_HANDLED unconditionally in the irq handler (2014-11-12 07:16:27 -0800)

----------------------------------------------------------------
Few omap driver changes to add minimal device tree support
for the omap 1w driver, and to fix resume and interrupt issues
on the l3-noc driver.

----------------------------------------------------------------
Keerthy (2):
      bus: omap_l3_noc: Add resume hook to restore context
      bus: omap_l3_noc: Correct returning IRQ_HANDLED unconditionally in the irq handler

NeilBrown (1):
      w1: omap-hdq: support device probing with device-tree

 Documentation/devicetree/bindings/w1/omap-hdq.txt | 17 ++++++
 drivers/bus/omap_l3_noc.c                         | 63 ++++++++++++++++++++++-
 drivers/w1/masters/omap_hdq.c                     |  7 +++
 3 files changed, 85 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/w1/omap-hdq.txt
