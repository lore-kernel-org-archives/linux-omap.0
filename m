From: Nicolae Rosia <Nicolae_Rosia@mentor.com>
Subject: [PATCH] ARM: OMAP2+: avoid NULL pointer dereference
Date: Tue, 1 Nov 2016 11:49:25 +0200
Message-ID: <1477993765-9980-1-git-send-email-Nicolae_Rosia@mentor.com>
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
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Nicolae Rosia <Nicolae_Rosia@mentor.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

For OMAP4, volt_data is set in omap44xx_voltagedomains_init.
If the SoC is neither OMAP443X or OMAP446X, we end up with a
NULL in volt_data which causes a kernel oops.
This is the case when booting OMAP4470.

Signed-off-by: Nicolae Rosia <Nicolae_Rosia@mentor.com>
---
 arch/arm/mach-omap2/voltage.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index cba8cad..cd15dbd 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -87,6 +87,12 @@ int voltdm_scale(struct voltagedomain *voltdm,
 		return -ENODATA;
 	}
 
+	if (!voltdm->volt_data) {
+		pr_err("%s: No voltage data defined for vdd_%s\n",
+			__func__, voltdm->name);
+		return -ENODATA;
+	}
+
 	/* Adjust voltage to the exact voltage from the OPP table */
 	for (i = 0; voltdm->volt_data[i].volt_nominal != 0; i++) {
 		if (voltdm->volt_data[i].volt_nominal >= target_volt) {
-- 
2.5.5
