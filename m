From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH 0/2] omap3evm: enable keypad
Date: Tue,  3 Nov 2009 18:58:56 +0530
Message-ID: <1257254936-22438-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49379 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751437AbZKCN24 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Nov 2009 08:28:56 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id nA3DSw5A011237
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 3 Nov 2009 07:29:01 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>

This patch set enables the keypad in the default
configuration. It also adds it as wake-up source
from suspend.

It has been created and tested against latest
"for-next" branch.

Sanjeev Premi (2):
  omap3evm: Enable keypad in defconfig
  omap3evm: Add keypad as wakeup source

 arch/arm/configs/omap3_evm_defconfig |   12 +++++++++---
 arch/arm/mach-omap2/board-omap3evm.c |   12 ++++++++++++
 2 files changed, 21 insertions(+), 3 deletions(-)

