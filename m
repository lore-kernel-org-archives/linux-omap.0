From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 10/11] omap2/3/4: Dissable CONFIG_PM_VERBOSE in omap3_defconfig
Date: Fri, 30 Apr 2010 13:34:09 -0700
Message-ID: <20100430203409.25812.56272.stgit@baageli.muru.com>
References: <20100430202603.25812.41834.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:61283 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933085Ab0D3UeL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Apr 2010 16:34:11 -0400
In-Reply-To: <20100430202603.25812.41834.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

It's too noisy.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/configs/omap3_defconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/configs/omap3_defconfig b/arch/arm/configs/omap3_defconfig
index a846836..7855edb 100644
--- a/arch/arm/configs/omap3_defconfig
+++ b/arch/arm/configs/omap3_defconfig
@@ -444,7 +444,7 @@ CONFIG_BINFMT_MISC=y
 #
 CONFIG_PM=y
 CONFIG_PM_DEBUG=y
-CONFIG_PM_VERBOSE=y
+# CONFIG_PM_VERBOSE is not set
 CONFIG_CAN_PM_TRACE=y
 CONFIG_PM_SLEEP=y
 CONFIG_SUSPEND=y

