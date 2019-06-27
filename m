From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.1 04/95] ARM: dts: dra71x: Disable usb4_tm target module
Date: Wed, 26 Jun 2019 20:28:49 -0400
Message-ID: <20190627003021.19867-4-sashal@kernel.org>
References: <20190627003021.19867-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190627003021.19867-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Keerthy <j-keerthy@ti.com>, Tony Lindgren <tony@atomide.com>, Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Keerthy <j-keerthy@ti.com>

[ Upstream commit 34b1b8061de3215208db9accfe60cc3f5b40178f ]

usb4_tm is unsed on dra71 and accessing the module
with ti,sysc is causing a boot crash hence disable its target
module.

Fixes: 549fce068a3112 ("ARM: dts: dra7: Add l4 interconnect hierarchy and ti-sysc data")
Signed-off-by: Keerthy <j-keerthy@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/dra71x.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/dra71x.dtsi b/arch/arm/boot/dts/dra71x.dtsi
index aad7394902a6..695a08ed0360 100644
--- a/arch/arm/boot/dts/dra71x.dtsi
+++ b/arch/arm/boot/dts/dra71x.dtsi
@@ -11,3 +11,7 @@
 &rtctarget {
 	status = "disabled";
 };
+
+&usb4_tm {
+	status = "disabled";
+};
-- 
2.20.1
