Received: from server.couthit.com (server.couthit.com [162.240.164.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C5840627B;
	Thu, 23 Jul 2026 10:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.240.164.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784802180; cv=none; b=CODzDDSz7DuO6NrSLmiS6ryWQw4zaDjRAL4aCLcHBfy7MN0BQASlRayXzGAXXyQQhxM8VfAfG6e+YErqfirYtxmkluGUp8yvkXoFJacH9NVUkissPurc9sRdi7CsTBoxwlpg+H0xNhVpXTioai+9O+uAWjDR9dV9sbdA0uzfXAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784802180; c=relaxed/simple;
	bh=SgpYVi4pd5xuw/dyP61w++5dlkpsayvZj7AnTycvcno=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iucyF0C+VKHzXUzio5fNl0F4OV5gmS2QamBtJMbPwGZQLZ/aS8zwK6lpeFZT0u7HOsFiL8xskkYG8AudhtFcMRtWNk9FTsMDbJL5J7pt1riq/D/GzQRamPTWhn17OJ3IxFxv6ZJHtm68t2BHIIyaNpCVSzy4eyEoX9Clk51uw/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=HhrlAtzi; arc=none smtp.client-ip=162.240.164.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=couthit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b="HhrlAtzi"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject
	:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=mW4ejC3E/yQSD3rKvCaGGwAL8BFUOuhE+OUcGDIvMhs=; b=HhrlAtziqGoSMa+InSNHpW0NkZ
	rceP7QKUXZ5FoIc7FDZ64fn9WyCaP2gbfWRhuELozm3F5fEL/lSVTHs5iGzoAcbUajwoaTOz+Bcbw
	kzGNOoqA9AIGHrTjgt6AY/NwgVjNMnR2EYHp/0id9aEEuMLPCWFFNzPB9Qsh7LVeUNpkm4I/qDolO
	hI1rB28UPCZfcRZhK07P5AMFvMVwor6DDWNyNSH1fckZdzQQ711HXxSrl5sxyRP4SKyqB0yzDgVZ3
	7yss3NYz8YKgdaY1JstKarPGxM4NwIIezO1SS6HM4XAJYIjsn66/WMWGjWEexd+1xg20amSu1noQs
	o5yS/akA==;
Received: from [115.246.246.98] (port=1539 helo=cypher.couthit.local)
	by server.couthit.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.4)
	(envelope-from <parvathi@couthit.com>)
	id 1wmqZi-0000000BPnw-3WLd;
	Thu, 23 Jul 2026 06:22:47 -0400
From: Parvathi Pudi <parvathi@couthit.com>
To: nm@ti.com,
	vigneshr@ti.com,
	afd@ti.com,
	aaro.koskinen@iki.fi,
	andreas@kemnade.info,
	khilman@baylibre.com,
	rogerq@kernel.org,
	tony@atomide.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	richardcochran@gmail.com
Cc: linux-omap@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	danishanwar@ti.com,
	pratheesh@ti.com,
	j-rameshbabu@ti.com,
	praneeth@ti.com,
	srk@ti.com,
	rogerq@ti.com,
	krishna@couthit.com,
	mohan@couthit.com,
	pmohan@couthit.com,
	basharath@couthit.com,
	parvathi@couthit.com,
	Murali Karicheri <m-karicheri2@ti.com>
Subject: [PATCH] arm: dts: ti: Add device tree nodes for PRU-ICSS1 instance on AM571x
Date: Thu, 23 Jul 2026 15:47:23 +0530
Message-ID: <20260723102041.372148-1-parvathi@couthit.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server.couthit.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - couthit.com
X-Get-Message-Sender-Via: server.couthit.com: authenticated_id: parvathi@couthit.com
X-Authenticated-Sender: server.couthit.com: parvathi@couthit.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

From: Roger Quadros <rogerq@ti.com>

The TI Sitara AM571x device has two PRU-ICSS subsystems: PRU-ICSS1 and
PRU-ICSS2. DUAL-MAC Ethernet support is already available on PRU-ICSS2.
This patch adds device tree support to enable DUAL-MAC mode on PRU-ICSS1
for the AM571x IDK board.

Each PRU-ICSS contains two PRU cores and several peripherals, including
the Interrupt Controller, IEP, MII_RT, MDIO, and eCAP. This patch also adds
the IEP and eCAP child nodes for PRU-ICSS1, making its layout consistent
with PRU-ICSS2.

am57-pruss.dtsi: Adds the IEP and eCAP child nodes for PRU-ICSS1.

am571x-idk.dts: Adds the PRU-ICSS1 DUAL-MAC Ethernet node, enables the
PRU-ICSS1 MDIO bus, adds the two external PHYs, and configures the required
pin multiplexing and interrupts.

Signed-off-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Andrew F. Davis <afd@ti.com>
Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
Signed-off-by: Parvathi Pudi <parvathi@couthit.com>
---
 arch/arm/boot/dts/ti/omap/am57-pruss.dtsi | 11 ++++
 arch/arm/boot/dts/ti/omap/am571x-idk.dts  | 65 ++++++++++++++++++++++-
 2 files changed, 75 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ti/omap/am57-pruss.dtsi b/arch/arm/boot/dts/ti/omap/am57-pruss.dtsi
index f73316625608..1579f284cb6e 100644
--- a/arch/arm/boot/dts/ti/omap/am57-pruss.dtsi
+++ b/arch/arm/boot/dts/ti/omap/am57-pruss.dtsi
@@ -61,6 +61,17 @@ pruss1_iepclk_mux: iepclk-mux@30 {
 				};
 			};
 
+			pruss1_iep: iep@2e000 {
+				compatible = "ti,am5728-icss-iep";
+				reg = <0x2e000 0x31c>;
+				clocks = <&pruss1_iepclk_mux>;
+			};
+
+			pruss1_ecap: ecap@30000 {
+				compatible = "ti,pruss-ecap";
+				reg = <0x30000 0x60>;
+			};
+
 			pruss1_mii_rt: mii-rt@32000 {
 				compatible = "ti,pruss-mii", "syscon";
 				reg = <0x32000 0x58>;
diff --git a/arch/arm/boot/dts/ti/omap/am571x-idk.dts b/arch/arm/boot/dts/ti/omap/am571x-idk.dts
index 02653b440585..e74c154b1940 100644
--- a/arch/arm/boot/dts/ti/omap/am571x-idk.dts
+++ b/arch/arm/boot/dts/ti/omap/am571x-idk.dts
@@ -165,6 +165,53 @@ blue3-led {
 			default-state = "off";
 		};
 	};
+
+	/* Dual mac ethernet application node on icss1 */
+	pruss1-eth {
+		compatible = "ti,am57-prueth";
+		ti,prus = <&pru1_0>, <&pru1_1>;
+		ti,pruss-gp-mux-sel = <0>,	/* GP, default */
+				<4>;	/* MII2, for PRUSS1_MII1 */
+		sram = <&ocmcram1>;
+		ti,mii-rt = <&pruss1_mii_rt>;
+		ti,iep = <&pruss1_iep>;
+		ti,ecap = <&pruss1_ecap>;
+		interrupts = <20 2 2>, <21 3 3>;
+		interrupt-names = "rx_hp", "rx_lp";
+		interrupt-parent = <&pruss1_intc>;
+
+		ethernet-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			pruss1_emac0: ethernet-port@0 {
+				reg = <0>;
+				phy-handle = <&pruss1_eth0_phy>;
+				phy-mode = "mii";
+				interrupts = <20 2 2>, <26 6 6>, <23 6 6>;
+				interrupt-names = "rx", "emac_ptp_tx",
+						"hsr_ptp_tx";
+				/* Filled in by bootloader */
+				local-mac-address = [00 00 00 00 00 00];
+			};
+
+			pruss1_emac1: ethernet-port@1 {
+				reg = <1>;
+				phy-handle = <&pruss1_eth1_phy>;
+				phy-mode = "mii";
+				interrupts = <21 3 3>, <27 9 7>, <24 9 7>;
+				interrupt-names = "rx", "emac_ptp_tx",
+						"hsr_ptp_tx";
+				/* Filled in by bootloader */
+				local-mac-address = [00 00 00 00 00 00];
+			};
+		};
+	};
+};
+
+&pruss1_iep {
+	interrupt-parent = <&pruss1_intc>;
+	interrupts = <7 7 8>;
+	interrupt-names = "iep_cap_cmp";
 };
 
 &extcon_usb2 {
@@ -210,7 +257,23 @@ &mmc2 {
 };
 
 &pruss1_mdio {
-	status = "disabled";
+	status = "okay";
+	reset-gpios = <&gpio5 8 GPIO_ACTIVE_LOW>;
+	reset-delay-us = <2>;   /* PHY datasheet states 1uS min */
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	pruss1_eth0_phy: ethernet-phy@0 {
+		reg = <0>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <28 IRQ_TYPE_LEVEL_LOW>;
+	};
+
+	pruss1_eth1_phy: ethernet-phy@1 {
+		reg = <1>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <29 IRQ_TYPE_LEVEL_LOW>;
+	};
 };
 
 &pruss2_mdio {
-- 
2.43.0

