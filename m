From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 05/10] ARM: DTS: dra72-evm: Enable AFIFO use for McASP3
Date: Mon, 7 Mar 2016 17:17:32 +0200
Message-ID: <1457363857-20797-6-git-send-email-peter.ujfalusi@ti.com>
References: <1457363857-20797-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1457363857-20797-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, paul@pwsan.com, robh+dt@kernel.org
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Since we switched to use eDMA we can now safely enable the FIFO in McASP.
This will reduce the chance of McASP level under/overflow.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/dra72-evm.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/dra72-evm.dts b/arch/arm/boot/dts/dra72-evm.dts
index 6affe2d137da..bdfc9476f036 100644
--- a/arch/arm/boot/dts/dra72-evm.dts
+++ b/arch/arm/boot/dts/dra72-evm.dts
@@ -834,6 +834,8 @@
 	serial-dir = <  /* 0: INACTIVE, 1: TX, 2: RX */
 		1 2 0 0
 	>;
+	tx-num-evt = <32>;
+	rx-num-evt = <32>;
 };
 
 &mailbox5 {
-- 
2.7.2
