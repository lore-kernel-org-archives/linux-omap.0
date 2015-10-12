From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH 01/37] ARM: dts: am437x-gp-evm: Remove unneeded regulator
 property
Date: Tue, 13 Oct 2015 00:12:30 +0300
Message-ID: <1444684386-17094-2-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1444684386-17094-1-git-send-email-laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1444684386-17094-1-git-send-email-laurent.pinchart@ideasonboard.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Benoit Cousson <bcousson@baylibre.com>
List-Id: linux-omap@vger.kernel.org

The enable-active-high regulator property only makes sense when an
enable GPIO is specified. Remove it.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 arch/arm/boot/dts/am437x-gp-evm.dts | 1 -
 1 file changed, 1 deletion(-)

Cc: linux-omap@vger.kernel.org
Cc: Benoit Cousson <bcousson@baylibre.com>
Cc: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts b/arch/arm/boot/dts/am437x-gp-evm.dts
index 84aa30c3235a..a3cd413aebf0 100644
--- a/arch/arm/boot/dts/am437x-gp-evm.dts
+++ b/arch/arm/boot/dts/am437x-gp-evm.dts
@@ -29,7 +29,6 @@
 		regulator-name = "vmmcsd_fixed";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
-		enable-active-high;
 	};
 
 	vtt_fixed: fixedregulator-vtt {
-- 
2.4.9
