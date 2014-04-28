From: Stefan Roese <sr@denx.de>
Subject: [PATCH 4/5] DT: Add vendor prefix for HEAD acoustics
Date: Mon, 28 Apr 2014 14:17:55 +0200
Message-ID: <1398687476-10829-4-git-send-email-sr@denx.de>
References: <1398687476-10829-1-git-send-email-sr@denx.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mo4-p05-ob.smtp.rzone.de ([81.169.146.181]:55799 "EHLO
	mo4-p05-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755553AbaD1MX4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Apr 2014 08:23:56 -0400
In-Reply-To: <1398687476-10829-1-git-send-email-sr@denx.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
Cc: broonie@kernel.org, Thorsten Eisbein <thorsten.eisbein@head-acoustics.de>

Add "ha" for "HEAD acoustics" to the list of DT vendor prefixes.

Signed-off-by: Stefan Roese <sr@denx.de>
Cc: Thorsten Eisbein <thorsten.eisbein@head-acoustics.de>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index abc3080..0cdca38 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -53,6 +53,7 @@ globalscale	Globalscale Technologies, Inc.
 gmt	Global Mixed-mode Technology, Inc.
 google	Google, Inc.
 gumstix	Gumstix, Inc.
+ha	HEAD acoustics
 haoyu	Haoyu Microelectronic Co. Ltd.
 hisilicon	Hisilicon Limited.
 honeywell	Honeywell
-- 
1.9.1

