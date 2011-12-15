From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 0/2] OMAP4: McBSP: Fix clock reparenting
Date: Thu, 15 Dec 2011 11:37:37 +0200
Message-ID: <1323941859-7946-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:58472 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751990Ab1LOJiA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Dec 2011 04:38:00 -0500
Received: by lahc1 with SMTP id c1so1189509lah.22
        for <linux-omap@vger.kernel.org>; Thu, 15 Dec 2011 01:37:57 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello,

OMAP4 has different clock names compared to OMAP2/3.
Restructure the clock reparenting code for omap2plus in order to be able to
suport OMAP4 clock source selection without breaking upper layer API.

Regards,
Peter
---
Peter Ujfalusi (2):
  OMAP2+: mcbsp: Restructure clk reparenting code
  OMAP4: mcbsp: Clock reparenting support

 arch/arm/mach-omap2/mcbsp.c |   66 +++++++++++++++++++++++++++++++-----------
 1 files changed, 48 insertions(+), 18 deletions(-)

-- 
1.7.8

