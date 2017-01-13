From: Ravi Babu <ravibabu-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 1/2] ARM: dts: dra7-evm: increase QSPI SPL partition size
Date: Fri, 13 Jan 2017 18:10:33 +0530
Message-ID: <1484311234-21978-2-git-send-email-ravibabu@ti.com>
References: <1484311234-21978-1-git-send-email-ravibabu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1484311234-21978-1-git-send-email-ravibabu-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, nsekhar-uAqBSO/uNfhBDgjK7y7TUQ@public.gmane.org, Ravi Babu <ravibabu-l0cyMroinI0@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The SPL size for DRA74x platform has increased and
is now more than 64KB. Increase QSPI SPL partition
size to 256KB for DRA74x EVM.

QSPI partition numbering changes because of this.

Signed-off-by: Ravi Babu <ravibabu-l0cyMroinI0@public.gmane.org>
Signed-off-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/dra7-evm.dts | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index 132f2be..2784241 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -681,41 +681,29 @@
 		 */
 		partition@0 {
 			label = "QSPI.SPL";
-			reg = <0x00000000 0x000010000>;
+			reg = <0x00000000 0x000040000>;
 		};
 		partition@1 {
-			label = "QSPI.SPL.backup1";
-			reg = <0x00010000 0x00010000>;
-		};
-		partition@2 {
-			label = "QSPI.SPL.backup2";
-			reg = <0x00020000 0x00010000>;
-		};
-		partition@3 {
-			label = "QSPI.SPL.backup3";
-			reg = <0x00030000 0x00010000>;
-		};
-		partition@4 {
 			label = "QSPI.u-boot";
 			reg = <0x00040000 0x00100000>;
 		};
-		partition@5 {
+		partition@2 {
 			label = "QSPI.u-boot-spl-os";
 			reg = <0x00140000 0x00080000>;
 		};
-		partition@6 {
+		partition@3 {
 			label = "QSPI.u-boot-env";
 			reg = <0x001c0000 0x00010000>;
 		};
-		partition@7 {
+		partition@4 {
 			label = "QSPI.u-boot-env.backup1";
 			reg = <0x001d0000 0x0010000>;
 		};
-		partition@8 {
+		partition@5 {
 			label = "QSPI.kernel";
 			reg = <0x001e0000 0x0800000>;
 		};
-		partition@9 {
+		partition@6 {
 			label = "QSPI.file-system";
 			reg = <0x009e0000 0x01620000>;
 		};
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
