From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv9 0/5] arm: omap: smps regulator support
Date: Thu, 16 Feb 2012 12:27:48 +0200
Message-ID: <1329388073-17879-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48953 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751875Ab2BPK2q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Feb 2012 05:28:46 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com
Cc: linux-arm-kernel@lists.infradead.org

Hi,

Following changes compared to previous version:

- updated to work with mainline
- added acked-by Samuel Ortiz to patch 4 MFD part (no changes done to that
  part of code since previous version)
- changed min_uV parameter name from patch 4/5 to target_uV

Tested with omap3 beagle: changed + measured voltages manually for
vdd1 and vdd2.

-Tero

