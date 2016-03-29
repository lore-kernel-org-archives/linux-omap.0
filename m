From: Paul Kocialkowski <contact@paulk.fr>
Subject: [PATCH 1/5] devicetree: bindings: Add vendor prefix for Amazon.com, Inc.
Date: Tue, 29 Mar 2016 21:28:23 +0200
Message-ID: <1459279707-17611-3-git-send-email-contact@paulk.fr>
References: <1459279707-17611-1-git-send-email-contact@paulk.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1459279707-17611-1-git-send-email-contact@paulk.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, Paul Kocialkowski <contact@paulk.fr>
List-Id: linux-omap@vger.kernel.org

This adds the amazon vendor prefix for Amazon.com, Inc.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 86740d4..54b647c 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -16,6 +16,7 @@ al	Annapurna Labs
 allwinner	Allwinner Technology Co., Ltd.
 alphascale	AlphaScale Integrated Circuits Systems, Inc.
 altr	Altera Corp.
+amazon	Amazon.com, Inc.
 amcc	Applied Micro Circuits Corporation (APM, formally AMCC)
 amd	Advanced Micro Devices (AMD), Inc.
 amlogic	Amlogic, Inc.
-- 
2.7.4
