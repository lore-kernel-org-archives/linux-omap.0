From: Koen Kooi <koen@dominion.thruhere.net>
Subject: [PATCH v6 1/2] dt-bindings: Add vendor prefix for Sancloud
Date: Tue, 17 Jul 2018 08:51:48 +0200
Message-ID: <1531810311-29915-2-git-send-email-koen@dominion.thruhere.net>
References: <1531810311-29915-1-git-send-email-koen@dominion.thruhere.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1531810311-29915-1-git-send-email-koen@dominion.thruhere.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Koen Kooi <koen@dominion.thruhere.net>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Shawn Guo <shawnguo@kernel.org>, =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>, David Lechner <david@lechnology.com>, SZ Lin <sz.lin@moxa.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Add vendor prefix for Sancloud Ltd.

Signed-off-by: Koen Kooi <koen@dominion.thruhere.net>
Acked-by: Rob Herring <robh@kernel.org>
---

v6: No changes
v5: No changes
v4: Add Acked-by
v3: No changes
v2: No changes
v1: Initial submission

 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 7cad066..c7aaa1f 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -314,6 +314,7 @@ rohm	ROHM Semiconductor Co., Ltd
 roofull	Shenzhen Roofull Technology Co, Ltd
 samsung	Samsung Semiconductor
 samtec	Samtec/Softing company
+sancloud	Sancloud Ltd
 sandisk	Sandisk Corporation
 sbs	Smart Battery System
 schindler	Schindler
-- 
2.0.1
