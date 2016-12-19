From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 2/9] ARM: dts: omap3: Add an empty chosen node to top level
 DTSI
Date: Mon, 19 Dec 2016 11:44:34 -0300
Message-ID: <1482158681-4530-3-git-send-email-javier@osg.samsung.com>
References: <1482158681-4530-1-git-send-email-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1482158681-4530-1-git-send-email-javier@osg.samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Javier Martinez Canillas <javier@osg.samsung.com>, Rob Herring <robh+dt@kernel.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Pali Rohar <pali.rohar@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Commit 008a2ebcd677 ("ARM: dts: omap3: Remove skeleton.dtsi usage")
removed the skeleton.dtsi usage since we want to get rid of it.

But this can cause issues when booting a kernel with a boot-loader
that doesn't create a chosen node if this isn't present in the DTB
since the decompressor relies on a pre-existing chosen node to be
available to insert the command line and merge other ATAGS info.

Fixes: 008a2ebcd677 ("ARM: dts: omap3: Remove skeleton.dtsi usage")
Reported-by: Pali Rohar <pali.rohar@gmail.com>
Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 arch/arm/boot/dts/omap3.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index ecf5eb584c75..a3ff4933dbc1 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -17,6 +17,7 @@
 	interrupt-parent = <&intc>;
 	#address-cells = <1>;
 	#size-cells = <1>;
+	chosen { };
 
 	aliases {
 		i2c0 = &i2c1;
-- 
2.7.4
