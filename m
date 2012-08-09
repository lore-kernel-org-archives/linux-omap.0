From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH v2 0/2] OMAP cpufreq fixes
Date: Thu, 9 Aug 2012 12:38:20 +0530
Message-ID: <1344496102-24451-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39400 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755422Ab2HIHIf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 9 Aug 2012 03:08:35 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

Changes in v2:
Fixed the handling of freq_table_users in Patch 1/2 as
suggested by Santosh. Patch 2/2 is unchanged.

Hi Kevin,

While testing cpufreq on 3.6-rc1, I noticed strange issues on OMAP4,
like a lockup when booting with 'performace' governer as default,
and crashes when using 'usespace' (which booted up) and switching
to higher OPPs.
It took me a while to realise I was using a 4460 device. The OPPs
registered though seemed to be for 4430 and hence were causing
issues on the 4460 device. 

This series basically avoids registering the 4430 OPPs on other
varients like 4460 and 4470 (and hence causing random issues)
and also fixes a subsequent bug uncovered by doing this in
OMAP cpufreq driver.

regards,
Rajendra 

Rajendra Nayak (2):
  cpufreq: OMAP: Handle missing frequency table on SMP systems
  ARM: OMAP4: Register the OPP table only for 4430 device

 arch/arm/mach-omap2/opp4xxx_data.c |    2 +-
 drivers/cpufreq/omap-cpufreq.c     |    4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

-- 
1.7.9.5

