From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH/RFT 0/1] MPU DVFS using SMPS regulator driver
Date: Thu, 16 Feb 2012 11:20:42 -0800
Message-ID: <1329420043-32656-1-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:34710 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755162Ab2BPTUO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Feb 2012 14:20:14 -0500
Received: by mail-pw0-f53.google.com with SMTP id rq13so3470976pbb.12
        for <linux-omap@vger.kernel.org>; Thu, 16 Feb 2012 11:20:06 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tero Kristo <t-kristo@ti.com>

This patch modifies the OMAP CPUfreq driver to use the regulator framework
to scale voltage when scaling frequency.  It uses the new SMPS regulator
driver from Tero.

This patch applies on top of the recently posted SMPS regulator series
from Tero:

   Subject: [PATCHv9 0/5] arm: omap: smps regulator support
   Date:	Thu, 16 Feb 2012 12:27:48 +0200

I'd especially appreciate testing from those of you who are setup to
measure voltage at the voltage rails and can confirm that voltage is
actually being scaled.

Kevin Hilman (1):
  OMAP2+: cpufreq: scale voltage along with frequency

 arch/arm/mach-omap2/voltage.c  |    2 ++
 drivers/cpufreq/omap-cpufreq.c |   29 ++++++++++++++++++++++++++++-
 2 files changed, 30 insertions(+), 1 deletions(-)

-- 
1.7.9

