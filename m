From: Thomas Weber <weber@corscience.de>
Subject: [PATCH] ARM: OMAP2+: Remove empty io.h
Date: Tue,  8 Nov 2011 13:39:42 +0100
Message-ID: <1320755982-27005-1-git-send-email-weber@corscience.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:53207 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751509Ab1KHMjy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Nov 2011 07:39:54 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, Thomas Weber <weber@corscience.de>

The file arch/arm/mach-omap2/io.h is empty, so we can remove it.

Signed-off-by: Thomas Weber <weber@corscience.de>
---
 0 files changed, 0 insertions(+), 0 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/io.h

diff --git a/arch/arm/mach-omap2/io.h b/arch/arm/mach-omap2/io.h
deleted file mode 100644
index e69de29..0000000
-- 
1.7.7.2

