From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 05] ARM: omap: fix vc.c PMIC error message
Date: Thu, 09 Feb 2012 18:01:45 +0000
Message-ID: <E1RvYJV-0003FG-Gq@rmk-PC.arm.linux.org.uk>
References: <20120208163546.GA15849@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20120208163546.GA15849@n2100.arm.linux.org.uk>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

While testing on my OMAP3430 platform, this error message was emitted:

omap_vc_init_channel: PMIC info requried to configure vc forvdd_core not populated.Hence cannot initialize vc

Trying to find this message was difficult because it was wrapped across
several lines.  It also mis-spells "required", doesn't read very well,
and has spaces lacking.  Let's replace it with a more concise:

omap_vc_init_channel: No PMIC info for vdd_core

While we're here, fix a simple spelling error in a comment.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap2/vc.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
index 031d116..a7da3da 100644
--- a/arch/arm/mach-omap2/vc.c
+++ b/arch/arm/mach-omap2/vc.c
@@ -247,7 +247,7 @@ static void __init omap4_vc_init_channel(struct voltagedomain *voltdm)
  * omap_vc_i2c_init - initialize I2C interface to PMIC
  * @voltdm: voltage domain containing VC data
  *
- * Use PMIC supplied seetings for I2C high-speed mode and
+ * Use PMIC supplied settings for I2C high-speed mode and
  * master code (if set) and program the VC I2C configuration
  * register.
  *
@@ -292,9 +292,7 @@ void __init omap_vc_init_channel(struct voltagedomain *voltdm)
 	u32 val;
 
 	if (!voltdm->pmic || !voltdm->pmic->uv_to_vsel) {
-		pr_err("%s: PMIC info requried to configure vc for"
-			"vdd_%s not populated.Hence cannot initialize vc\n",
-			__func__, voltdm->name);
+		pr_err("%s: No PMIC info for vdd_%s\n", __func__, voltdm->name);
 		return;
 	}
 
-- 
1.7.4.4
