From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 1/3] ARM: DTS: omap3: Remove mcbsp2/3_sidetone
	hwmod reference for McBSP2/3
Date: Fri, 18 Mar 2016 12:28:47 +0200
Message-ID: <1458296929-718-2-git-send-email-peter.ujfalusi@ti.com>
References: <1458296929-718-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1458296929-718-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Paul Walmsley <paul@pwsan.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The mcbsp2/3_sidetone hwmod is a dummy hwmod and servers as a placeholder
to attach the register address and irq number to the main mcbsp2/3 hwmod.
The hwmod for the McBSP sidetone module is going to be removed from the
kernel.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/omap3.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index b41d07e8e765..d6b7abce7a55 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -507,7 +507,7 @@
 				     <4>;  /* Sidetone */
 			interrupt-names = "common", "tx", "rx", "sidetone";
 			ti,buffer-size = <1280>;
-			ti,hwmods = "mcbsp2", "mcbsp2_sidetone";
+			ti,hwmods = "mcbsp2";
 			dmas = <&sdma 33>,
 			       <&sdma 34>;
 			dma-names = "tx", "rx";
@@ -525,7 +525,7 @@
 				     <5>;  /* Sidetone */
 			interrupt-names = "common", "tx", "rx", "sidetone";
 			ti,buffer-size = <128>;
-			ti,hwmods = "mcbsp3", "mcbsp3_sidetone";
+			ti,hwmods = "mcbsp3";
 			dmas = <&sdma 17>,
 			       <&sdma 18>;
 			dma-names = "tx", "rx";
-- 
2.7.3
