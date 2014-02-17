From: Mugunthan V N <mugunthanvnm@ti.com>
Subject: [PATCH 1/1] ARM: OMAP: Kill warning in CPUIDLE code with !CONFIG_SMP
Date: Mon, 17 Feb 2014 13:22:55 +0530
Message-ID: <1392623575-4884-1-git-send-email-mugunthanvnm@ti.com>
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
To: tony@atomide.com
Cc: nm@ti.com, Mugunthan V N <mugunthanvnm@ti.com>, linux@arm.linux.org.uk, linux-kernel@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: Santosh Shilimkar <santosh.shilimkar@ti.com>

for non SMP build, NR_CPUS is 1 and hence the code complains with below
warnings.

arch/arm/mach-omap2/cpuidle44xx.c:207:8: warning: array subscript is above array bounds [-Warray-bounds]
arch/arm/mach-omap2/cpuidle44xx.c:212:11: warning: array subscript is above array bounds [-Warray-bounds]

Kill it by making array size fixed.

Acked-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>
---
This patch is created on top of git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git master

---
 arch/arm/mach-omap2/cpuidle44xx.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/cpuidle44xx.c
index 4c158c8..01fc710 100644
--- a/arch/arm/mach-omap2/cpuidle44xx.c
+++ b/arch/arm/mach-omap2/cpuidle44xx.c
@@ -23,6 +23,8 @@
 #include "prm.h"
 #include "clockdomain.h"
 
+#define MAX_CPUS	2
+
 /* Machine specific information */
 struct idle_statedata {
 	u32 cpu_state;
@@ -48,11 +50,11 @@ static struct idle_statedata omap4_idle_data[] = {
 	},
 };
 
-static struct powerdomain *mpu_pd, *cpu_pd[NR_CPUS];
-static struct clockdomain *cpu_clkdm[NR_CPUS];
+static struct powerdomain *mpu_pd, *cpu_pd[MAX_CPUS];
+static struct clockdomain *cpu_clkdm[MAX_CPUS];
 
 static atomic_t abort_barrier;
-static bool cpu_done[NR_CPUS];
+static bool cpu_done[MAX_CPUS];
 static struct idle_statedata *state_ptr = &omap4_idle_data[0];
 
 /* Private functions */
-- 
1.9.0.rc3.21.g475c52b
