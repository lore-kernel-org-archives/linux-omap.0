From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 0/3] ARM: OMAP2+: devices: Silence hwmod lookup failures (dmic/mcpdm)
Date: Tue, 11 Jun 2013 10:31:57 +0200
Message-ID: <1370939520-16132-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57438 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752288Ab3FKIcb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Jun 2013 04:32:31 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org

Hi,

Small patches to silence the hwmod lookup failures in case when we boot the
kernel on boards where the IPs are not present (OMAP2/3 vs McPDM, DMIC,
HDMI audio).

Regards,
Peter
---
Peter Ujfalusi (3):
  ARM: OMAP2+: devices: Do not print error when McPDM hwmod lookup fails
  ARM: OMAP2+: devices: Do not print error when DMIC hwmod lookup fails
  ARM: OMAP2+: devices: Do not print error when dss_hdmi hwmod lookup
    fails

 arch/arm/mach-omap2/devices.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

-- 
1.8.2.1

