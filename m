From: Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH] dt: gta04: fix polarity of clocks for mcbsp4
Date: Fri, 28 Apr 2017 12:27:35 +0200
Message-ID: <1493375255-21094-1-git-send-email-andreas@kemnade.info>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: bcousson@baylibre.com, tony@atomide.com, robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "H. Nikolaus Schaller" <hns@goldelico.com>, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>
Cc: Andreas Kemnade <andreas@kemnade.info>
List-Id: linux-omap@vger.kernel.org

The clock polarity setting of the mcbsp connected to
the modem was wrong so almost only noise
was received.
With this patch it is also the same as it was on
earlier non-dt kernels where it was working properly

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index 16b237d3..c0d9d4b 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -68,7 +68,8 @@
 		simple-audio-card,bitclock-master = <&telephony_link_master>;
 		simple-audio-card,frame-master = <&telephony_link_master>;
 		simple-audio-card,format = "i2s";
-
+		simple-audio-card,bitclock-inversion;
+		simple-audio-card,frame-inversion;
 		simple-audio-card,cpu {
 			sound-dai = <&mcbsp4>;
 		};
-- 
2.1.4
