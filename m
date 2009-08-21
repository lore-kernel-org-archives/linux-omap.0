From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [DSPBRIGDE PATCH 3/6] dsp: bridge: rename Kbuild to Makefile
Date: Fri, 21 Aug 2009 13:23:36 +0300
Message-ID: <1250850219-25545-4-git-send-email-felipe.balbi@nokia.com>
References: <1250850219-25545-1-git-send-email-felipe.balbi@nokia.com>
 <1250850219-25545-2-git-send-email-felipe.balbi@nokia.com>
 <1250850219-25545-3-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:37469 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755287AbZHUKZ5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Aug 2009 06:25:57 -0400
In-Reply-To: <1250850219-25545-3-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: Ameya Palande <ameya.palande@nokia.com>, x0095840@ti.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <felipe.balbi@nokia.com>

we all use Makefile, let's keep the name.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/dsp/bridge/{Kbuild => Makefile} |    0
 1 files changed, 0 insertions(+), 0 deletions(-)
 rename drivers/dsp/bridge/{Kbuild => Makefile} (100%)

diff --git a/drivers/dsp/bridge/Kbuild b/drivers/dsp/bridge/Makefile
similarity index 100%
rename from drivers/dsp/bridge/Kbuild
rename to drivers/dsp/bridge/Makefile
-- 
1.6.3.3.385.g60647

