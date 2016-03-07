From: Franklin S Cooper Jr <fcooper@ti.com>
Subject: [PATCH 4/5] pwm: pwm-tipwmss: Update documentation to use empty range property
Date: Mon,  7 Mar 2016 13:51:57 -0600
Message-ID: <1457380318-15452-5-git-send-email-fcooper@ti.com>
References: <1457380318-15452-1-git-send-email-fcooper@ti.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
In-Reply-To: <1457380318-15452-1-git-send-email-fcooper@ti.com>
Sender: linux-pwm-owner@vger.kernel.org
To: thierry.reding@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, bcousson@baylibre.com, tony@atomide.com, linux@arm.linux.org.uk, t-kristo@ti.com, mturquette@baylibre.com, sboyd@codeaurora.org, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Cc: Franklin S Cooper Jr <fcooper@ti.com>
List-Id: linux-omap@vger.kernel.org

Since the PWMSS and its subdevices (eCAP and ePWM) use the same address
space then the range property should be empty. Update the documentation
to show the correct usage.

Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
---
 Documentation/devicetree/bindings/pwm/pwm-tipwmss.txt | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-tipwmss.txt b/Documentation/devicetree/bindings/pwm/pwm-tipwmss.txt
index f7eae77..672fa71 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-tipwmss.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-tipwmss.txt
@@ -7,11 +7,9 @@ Required properties:
 		  Should set to 1.
 - size-cells: specify number of u32 entries needed to specify child nodes size
 		in reg property. Should set to 1.
-- ranges: describes the address mapping of a memory-mapped bus. Should set to
-	   physical address map of child's base address, physical address within
-	   parent's address  space and length of the address map. For am33xx,
-	   3 set of child register maps present, ECAP register space, EQEP
-	   register space, EHRPWM register space.
+- ranges: describes the address mapping of a memory-mapped bus. Its value
+	  should be empty since no address translation is needed between the
+	  parent and the child.
 
 Also child nodes should also populated under PWMSS DT node.
 
@@ -23,9 +21,7 @@ pwmss0: pwmss@48300000 {
 	#address-cells = <1>;
 	#size-cells = <1>;
 	status = "disabled";
-	ranges = <0x48300100 0x48300100 0x80   /* ECAP */
-		  0x48300180 0x48300180 0x80   /* EQEP */
-		  0x48300200 0x48300200 0x80>; /* EHRPWM */
+	ranges;
 
 	/* child nodes go here */
 };
-- 
2.7.0
