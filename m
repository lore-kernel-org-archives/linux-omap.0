From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 1/3] ARM: OMAP: DRA7: wakeupgen: Skip SAR save for wakeupgen
Date: Fri, 1 Apr 2016 17:53:05 -0500
Message-ID: <1459551187-5992-2-git-send-email-nm@ti.com>
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

DRA7 has no SAR region for automated save and restore of wakeupgen,
which does not make real since the SoC really does not do legacy OFF
mode anymore. Further wakeupgen should never loose context in CSWR
retention mode for MPU domain on DRA7 since that is the deepest state
we will enter.

So, just skip, instead of oopsing as follows while attemptint to enter
suspend on BeagleBoard-X15.
[   55.589771] Unable to handle kernel paging request at virtual address 00002684
[   55.589771] pgd = ec69c000
[...]
[   55.589771] [<c0123cc8>] (irq_notifier) from [<c015ad70>] (notifier_call_chain+0x4c/0x8c)
[   55.589771] [<c015ad70>] (notifier_call_chain) from [<c021469c>] (cpu_cluster_pm_enter+0x2c/0x78)
[   55.589771] [<c021469c>] (cpu_cluster_pm_enter) from [<c0514508>] (syscore_suspend+0xb8/0x31c)
[   55.589771] [<c0514508>] (syscore_suspend) from [<c0197d24>] (suspend_devices_and_enter+0x308/0x9e4)
[   55.589771] [<c0197d24>] (suspend_devices_and_enter) from [<c0198a40>] (pm_suspend+0x640/0x75c)
[   55.589771] [<c0198a40>] (pm_suspend) from [<c0196bcc>] (state_store+0x64/0xb8)
[   55.589771] [<c0196bcc>] (state_store) from [<c0307914>] (kernfs_fop_write+0xc0/0x1bc)
[   55.589771] [<c0307914>] (kernfs_fop_write) from [<c028ac80>] (__vfs_write+0x1c/0xd8)
[   55.589771] [<c028ac80>] (__vfs_write) from [<c028bb70>] (vfs_write+0x90/0x16c)
[   55.589771] [<c028bb70>] (vfs_write) from [<c028c890>] (SyS_write+0x44/0x9c)
[   55.589771] [<c028c890>] (SyS_write) from [<c0107840>] (ret_fast_syscall+0x0/0x1c)
[...]

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/omap-wakeupgen.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/mach-omap2/omap-wakeupgen.c b/arch/arm/mach-omap2/omap-wakeupgen.c
index f397bd6bd6e3..2c04f2741476 100644
--- a/arch/arm/mach-omap2/omap-wakeupgen.c
+++ b/arch/arm/mach-omap2/omap-wakeupgen.c
@@ -274,6 +274,10 @@ static inline void omap5_irq_save_context(void)
  */
 static void irq_save_context(void)
 {
+	/* DRA7 has no SAR to save */
+	if (soc_is_dra7xx())
+		return;
+
 	if (!sar_base)
 		sar_base = omap4_get_sar_ram_base();
 
@@ -290,6 +294,9 @@ static void irq_sar_clear(void)
 {
 	u32 val;
 	u32 offset = SAR_BACKUP_STATUS_OFFSET;
+	/* DRA7 has no SAR to save */
+	if (soc_is_dra7xx())
+		return;
 
 	if (soc_is_omap54xx())
 		offset = OMAP5_SAR_BACKUP_STATUS_OFFSET;
-- 
2.8.0
