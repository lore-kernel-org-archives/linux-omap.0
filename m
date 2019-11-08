From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 051/103] ARM: dts: omap3-gta04: tvout: enable as display1 alias
Date: Fri,  8 Nov 2019 06:42:16 -0500
Message-ID: <20191108114310.14363-51-sashal@kernel.org>
References: <20191108114310.14363-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191108114310.14363-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: "H. Nikolaus Schaller" <hns@goldelico.com>, Tony Lindgren <tony@atomide.com>, Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: "H. Nikolaus Schaller" <hns@goldelico.com>

[ Upstream commit 8905592b6e50cec905e6c6035bbd36201a3bfac1 ]

The omap dss susbystem takes the display aliases to find
out which displays exist. To enable tv-out we must define
an alias.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index 5f62b2f3c6e93..7e9d6c4cdbfb6 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -28,6 +28,7 @@
 
 	aliases {
 		display0 = &lcd;
+		display1 = &tv0;
 	};
 
 	gpio-keys {
-- 
2.20.1
