From: Richard Cochran <richardcochran@gmail.com>
Subject: [PATCH RFC net-next 0/1] Simplify the CPSW DT
Date: Sat,  3 Nov 2012 18:45:03 +0100
Message-ID: <cover.1351964329.git.richardcochran@gmail.com>
References: <509240CF.6060909@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:37201 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753770Ab2KCRpR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 3 Nov 2012 13:45:17 -0400
In-Reply-To: <509240CF.6060909@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: netdev@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, David Miller <davem@davemloft.net>, Cyril Chemparathy <cyril@ti.com>, Mugunthan V N <mugunthanvnm@ti.com>, Vaibhav Hiremath <hvaibhav@ti.com>, Benoit Cousson <b-cousson@ti.com>, paul@pwsan.com

This patch is a follow up to show how to remove all the various
register offsets from the DT for the CPSW driver. This applies on top
of the bug fix I posted earlier for IO mapping leak.

Since I am currently awaiting a replacement for my defective
BeagleBone, this patch is compile tested only.

Thanks,
Richard


Richard Cochran (1):
  cpsw: simplify the setup of the register pointers

 Documentation/devicetree/bindings/net/cpsw.txt |   34 ----
 drivers/net/ethernet/ti/cpsw.c                 |  209 +++++++++--------------
 include/linux/platform_data/cpsw.h             |   19 --
 3 files changed, 82 insertions(+), 180 deletions(-)

-- 
1.7.2.5

