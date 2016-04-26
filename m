From: Franklin S Cooper Jr <fcooper@ti.com>
Subject: [PATCH v7 4/9] pwm: pwm-tiecap: Update dt binding document to use
 proper unit address
Date: Tue, 26 Apr 2016 17:36:44 -0500
Message-ID: <1461710209-6563-5-git-send-email-fcooper@ti.com>
References: <1461710209-6563-1-git-send-email-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1461710209-6563-1-git-send-email-fcooper@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: thierry.reding@gmail.com, robh+dt@kernel.org, tony@atomide.com, paul@pwsan.com, t-kristo@ti.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, vigneshr@ti.com, nsekhar@ti.com
Cc: Franklin S Cooper Jr <fcooper@ti.com>
List-Id: linux-omap@vger.kernel.org

Replace unit address from 0 to the proper physical address.

Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
---
 Documentation/devicetree/bindings/pwm/pwm-tiecap.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-tiecap.txt b/Documentation/devicetree/bindings/pwm/pwm-tiecap.txt
index 788da6c..1b7eec5 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-tiecap.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-tiecap.txt
@@ -16,21 +16,21 @@ Optional properties:
 
 Example:
 
-ecap0: ecap@0 { /* ECAP on am33xx */
+ecap0: ecap@48300100 { /* ECAP on am33xx */
 	compatible = "ti,am33xx-ecap";
 	#pwm-cells = <3>;
 	reg = <0x48300100 0x80>;
 	ti,hwmods = "ecap0";
 };
 
-ecap0: ecap@0 { /* ECAP on am4372 */
+ecap0: ecap@48300100 { /* ECAP on am4372 */
 	compatible = "ti,am4372-ecap", "ti,am33xx-ecap";
 	#pwm-cells = <3>;
 	reg = <0x48300100 0x80>;
 	ti,hwmods = "ecap0";
 };
 
-ecap0: ecap@0 { /* ECAP on da850 */
+ecap0: ecap@1f06000 { /* ECAP on da850 */
 	compatible = "ti,da850-ecap", "ti,am33xx-ecap";
 	#pwm-cells = <3>;
 	reg = <0x306000 0x80>;
-- 
2.7.0
