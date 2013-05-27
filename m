From: Andrii Tseglytskyi <andrii.tseglytskyi@ti.com>
Subject: [PATCH v1 0/3] PM / AVS: SmartReflex: use omap_sr * for class interfaces
Date: Mon, 27 May 2013 14:09:21 +0300
Message-ID: <1369652964-14484-1-git-send-email-andrii.tseglytskyi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57983 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757668Ab3E0LJ1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 27 May 2013 07:09:27 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>, J Keerthy <j-keerthy@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org

SmartReflex driver interface is natively divided to two parts:

- external SmartReflex interface
- interface between SmartReflex driver and SmartReflex Class

Functions which belong to AVS class interface can use
struct omap_sr* instead of struct voltatedomain*, to provide a
direct connection between SR driver and SR class. This allows
us to optimize and not do additional lookups where none is
required.

Patches are based on:
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
tag: v3.10-rc2

Verified on OMAP4430. Boot - OK. SmartReflex registers debug dump - OK

Available on GitHub:
https://github.com/andriit/linux-omap-k3.8/commits/avs_sr_driver_std_class_interfaces_v01

Andrii Tseglytskyi (3):
  PM / AVS: SmartReflex: use omap_sr * for errgen interfaces
  PM / AVS: SmartReflex: use omap_sr * for minmax interfaces
  PM / AVS: SmartReflex: use omap_sr * for enable/disable interface

 arch/arm/mach-omap2/smartreflex-class3.c |    8 ++--
 drivers/power/avs/smartreflex.c          |   63 +++++++++++++++---------------
 include/linux/power/smartreflex.h        |   10 ++---
 3 files changed, 40 insertions(+), 41 deletions(-)

-- 
1.7.9.5

