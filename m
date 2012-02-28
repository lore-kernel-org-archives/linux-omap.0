From: Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 3/4] regulator: twl-regulator: Add fixed LDO for V1V8,
	V2V1 supply
Date: Tue, 28 Feb 2012 15:09:12 +0530
Message-ID: <1330421953-29517-4-git-send-email-rnayak@ti.com>
References: <1330421953-29517-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <1330421953-29517-1-git-send-email-rnayak-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Cc: linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, Misael Lopez Cruz <misael.lopez-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lrg-l0cyMroinI0@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>

V1V8 supply most common use is to provide VIO for the system.
V2V1 supply is used on SDP4430/PandaBoards to provide 2.1V to
twl6040, and also as an input to VCXIO_IN, VDAC_IN of twl6030.

Also update the bindings documentation with the new compatible
property for these additional LDOs.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Signed-off-by: Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>
Cc: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Misael Lopez Cruz <misael.lopez-l0cyMroinI0@public.gmane.org>
Cc: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
---
 .../bindings/regulator/twl-regulator.txt           |    2 ++
 drivers/regulator/twl-regulator.c                  |    4 ++++
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/twl-regulator.txt b/Documentation/devicetree/bindings/regulator/twl-regulator.txt
index ba9d2cc..0c3395d 100644
--- a/Documentation/devicetree/bindings/regulator/twl-regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/twl-regulator.txt
@@ -13,6 +13,8 @@ For twl6030 regulators/LDOs
   - "ti,twl6030-vcxio" for VCXIO LDO
   - "ti,twl6030-vdac" for VDAC LDO
   - "ti,twl6030-vusb" for VUSB LDO
+  - "ti,twl6030-v1v8" for V1V8 LDO
+  - "ti,twl6030-v2v1" for V2V1 LDO
   - "ti,twl6030-clk32kg" for CLK32KG RESOURCE
   - "ti,twl6030-vdd1" for VDD1 SMPS
   - "ti,twl6030-vdd2" for VDD2 SMPS
diff --git a/drivers/regulator/twl-regulator.c b/drivers/regulator/twl-regulator.c
index 2a13211..9cdfc38 100644
--- a/drivers/regulator/twl-regulator.c
+++ b/drivers/regulator/twl-regulator.c
@@ -1094,6 +1094,8 @@ TWL6030_FIXED_LDO(VANA, 0x50, 2100, 0);
 TWL6030_FIXED_LDO(VCXIO, 0x60, 1800, 0);
 TWL6030_FIXED_LDO(VDAC, 0x64, 1800, 0);
 TWL6030_FIXED_LDO(VUSB, 0x70, 3300, 0);
+TWL6030_FIXED_LDO(V1V8, 0x16, 1800, 0);
+TWL6030_FIXED_LDO(V2V1, 0x1c, 2100, 0);
 TWL6030_FIXED_RESOURCE(CLK32KG, 0x8C, 0);
 TWL6025_ADJUSTABLE_SMPS(SMPS3, 0x34);
 TWL6025_ADJUSTABLE_SMPS(SMPS4, 0x10);
@@ -1173,6 +1175,8 @@ static const struct of_device_id twl_of_match[] __devinitconst = {
 	TWLFIXED_OF_MATCH("ti,twl6030-vcxio", VCXIO),
 	TWLFIXED_OF_MATCH("ti,twl6030-vdac", VDAC),
 	TWLFIXED_OF_MATCH("ti,twl6030-vusb", VUSB),
+	TWLFIXED_OF_MATCH("ti,twl6030-v1v8", V1V8),
+	TWLFIXED_OF_MATCH("ti,twl6030-v2v1", V2V1),
 	TWLRES_OF_MATCH("ti,twl6030-clk32kg", CLK32KG),
 	TWLSMPS_OF_MATCH("ti,twl6025-smps3", SMPS3),
 	TWLSMPS_OF_MATCH("ti,twl6025-smps4", SMPS4),
-- 
1.7.1
