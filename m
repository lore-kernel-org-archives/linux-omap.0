Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a02:c205:3004:2154::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997C6D64;
	Mon, 27 Nov 2023 12:04:43 -0800 (PST)
Received: from p200301077700a9001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:107:7700:a900:1a3d:a2ff:febf:d33a] helo=aktux)
	by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andreas@kemnade.info>)
	id 1r7hqN-006mlB-Mr; Mon, 27 Nov 2023 21:04:35 +0100
Received: from andi by aktux with local (Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1r7hqN-000bGO-1E;
	Mon, 27 Nov 2023 21:04:35 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: bcousson@baylibre.com,
	tony@atomide.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	linux-omap@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH] ARM: dts: omap: logicpd-torpedo: do not disguise GNSS device
Date: Mon, 27 Nov 2023 21:04:30 +0100
Message-Id: <20231127200430.143231-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

https://support.logicpd.com/DesktopModules/Bring2mind/DMX/Download.aspx?portalid=0&EntryId=649
clearly specifies the availability of GPS, so let's not disguise it
and name the node accordingly.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 arch/arm/boot/dts/ti/omap/logicpd-torpedo-37xx-devkit.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ti/omap/logicpd-torpedo-37xx-devkit.dts b/arch/arm/boot/dts/ti/omap/logicpd-torpedo-37xx-devkit.dts
index 533ce7ce387a5..fbff15a0a0fe9 100644
--- a/arch/arm/boot/dts/ti/omap/logicpd-torpedo-37xx-devkit.dts
+++ b/arch/arm/boot/dts/ti/omap/logicpd-torpedo-37xx-devkit.dts
@@ -52,7 +52,7 @@ wlcore: wlcore@2 {
 
 &uart2 {
 	/delete-property/dma-names;
-	bluetooth {
+	bluetooth-gnss {
 		compatible = "ti,wl1283-st";
 		enable-gpios = <&gpio6 2 GPIO_ACTIVE_HIGH>; /* gpio 162 */
 		max-speed = <3000000>;
-- 
2.39.2

