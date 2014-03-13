From: Joel Fernandes <joelf@ti.com>
Subject: [RFC 2/5] ARM: dts: am33xx: Set parent clock for timer through DT
Date: Thu, 13 Mar 2014 15:35:16 -0500
Message-ID: <1394742919-32163-3-git-send-email-joelf@ti.com>
References: <1394742919-32163-1-git-send-email-joelf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1394742919-32163-1-git-send-email-joelf@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, Rob Herring <robh@kernel.org>, Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>, Suman Anna <s-anna@ti.com>, Felipe Balbi <balbi@ti.com>
Cc: Joel Fernandes <joelf@ti.com>, Linux OMAP List <linux-omap@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Joel Fernandes <joelf@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 4e6c959..51b7008 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -352,6 +352,7 @@
 			interrupts = <67>;
 			ti,hwmods = "timer1";
 			ti,timer-alwon;
+			ti,default-parent = <&sys_clkin_ck>;
 		};
 
 		timer2: timer@48040000 {
@@ -360,6 +361,7 @@
 			reg = <0x48040000 0x400>;
 			interrupts = <68>;
 			ti,hwmods = "timer2";
+			ti,default-parent = <&sys_clkin_ck>;
 		};
 
 		timer3: timer@48042000 {
-- 
1.7.9.5
