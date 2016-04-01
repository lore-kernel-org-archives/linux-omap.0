From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 3/3] ARM: OMAP: Catch callers of revision information prior to
 it being populated
Date: Fri, 1 Apr 2016 17:53:07 -0500
Message-ID: <1459551187-5992-4-git-send-email-nm@ti.com>
References: <1459551187-5992-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1459551187-5992-1-git-send-email-nm@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

omap_rev is used to detect various SoC types, however any misuse of
the usage by invoking it earlier than it being populated will result
in invalid results. Lets flag them as early as possible to prevent
unintended side effects taking place. We get 0 if it is uninitialized
and -1 when detection is done using device tree (as the case was for
DRA7 as the case was prior to commit 06c2d368fc36 ("ARM: OMAP: DRA7:
Make use of omap_revision information for soc_is* calls")

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap1/id.c | 1 +
 arch/arm/mach-omap2/id.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/mach-omap1/id.c b/arch/arm/mach-omap1/id.c
index 52de382fc804..bfabc065d331 100644
--- a/arch/arm/mach-omap1/id.c
+++ b/arch/arm/mach-omap1/id.c
@@ -65,6 +65,7 @@ static struct omap_id omap_ids[] __initdata = {
 
 unsigned int omap_rev(void)
 {
+	WARN_ON_ONCE(!omap_revision || omap_revision == -1);
 	return omap_revision;
 }
 EXPORT_SYMBOL(omap_rev);
diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index d85c24918c17..75fb6c006e86 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -46,6 +46,7 @@ u32 omap_features;
 
 unsigned int omap_rev(void)
 {
+	WARN_ON_ONCE(!omap_revision || omap_revision == -1);
 	return omap_revision;
 }
 EXPORT_SYMBOL(omap_rev);
-- 
2.8.0
