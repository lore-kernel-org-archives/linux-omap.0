From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/8] ARM: OMAP2+: Remove bogus warnings for machines without
 twl PMIC
Date: Wed,  9 Oct 2019 17:12:19 -0700
Message-ID: <20191010001224.41826-4-tony@atomide.com>
References: <20191010001224.41826-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20191010001224.41826-1-tony@atomide.com>
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
Cc: Merlijn Wajer <merlijn@wizzup.org>, Pavel Machek <pavel@ucw.cz>, linux-arm-kernel@lists.infradead.org, Sebastian Reichel <sre@kernel.org>
List-Id: linux-omap@vger.kernel.org

In general we want to see a quiet dmesg output with no errors or warnings
unless something is really wrong and needs attention. We currently see
these bogus warnings on boot:

twl: not initialized
twl6030_uv_to_vsel:OUT OF RANGE! non mapped vsel for 1375000 Vs max 1316660
twl6030_uv_to_vsel:OUT OF RANGE! non mapped vsel for 1375000 Vs max 1316660
twl6030_uv_to_vsel:OUT OF RANGE! non mapped vsel for 1375000 Vs max 1316660
twl6030_uv_to_vsel:OUT OF RANGE! non mapped vsel for 1375000 Vs max 1316660
...

Let's avoid these by checking if a device tree node for cpcap PMIC exists.

Cc: Merlijn Wajer <merlijn@wizzup.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Sebastian Reichel <sre@kernel.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/omap_twl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap_twl.c b/arch/arm/mach-omap2/omap_twl.c
--- a/arch/arm/mach-omap2/omap_twl.c
+++ b/arch/arm/mach-omap2/omap_twl.c
@@ -219,7 +219,8 @@ int __init omap4_twl_init(void)
 {
 	struct voltagedomain *voltdm;
 
-	if (!cpu_is_omap44xx())
+	if (!cpu_is_omap44xx() ||
+	    of_find_compatible_node(NULL, NULL, "motorola,cpcap"))
 		return -ENODEV;
 
 	voltdm = voltdm_lookup("mpu");
-- 
2.23.0
