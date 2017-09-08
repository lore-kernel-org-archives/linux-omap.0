From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH] omap2: hsmmc: fix logic to call either omap_hsmmc_init or omap_hsmmc_late_init but not both
Date: Fri,  8 Sep 2017 21:15:51 +0200
Message-ID: <e70ee5587d158f0e9725d413b0a514886a3174dc.1504898151.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: hns@goldelico.com, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org
List-Id: linux-omap@vger.kernel.org

With 4.13 kernel I get this boot message:

[    1.051727] ------------[ cut here ]------------
[    1.051818] WARNING: CPU: 0 PID: 1 at fs/sysfs/dir.c:31 sysfs_warn_dup+0x54/0x74
[    1.051849] sysfs: cannot create duplicate filename '/devices/platform/omap_hsmmc.2'
[    1.051879] Modules linked in:
[    1.051971] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.13.0-letux+ #1360
[    1.052001] Hardware name: Generic OMAP3 (Flattened Device Tree)
[    1.052062] [<c010f690>] (unwind_backtrace) from [<c010bba8>] (show_stack+0x10/0x14)
[    1.052124] [<c010bba8>] (show_stack) from [<c075dc88>] (dump_stack+0x98/0xd0)
[    1.052185] [<c075dc88>] (dump_stack) from [<c012f398>] (__warn+0xd0/0x100)
[    1.052215] [<c012f398>] (__warn) from [<c012f3fc>] (warn_slowpath_fmt+0x34/0x44)
[    1.052276] [<c012f3fc>] (warn_slowpath_fmt) from [<c02ebcb4>] (sysfs_warn_dup+0x54/0x74)
[    1.052337] [<c02ebcb4>] (sysfs_warn_dup) from [<c02ebd90>] (sysfs_create_dir_ns+0x74/0x84)
[    1.052398] [<c02ebd90>] (sysfs_create_dir_ns) from [<c0761b8c>] (kobject_add_internal+0xd0/0x294)
[    1.052429] [<c0761b8c>] (kobject_add_internal) from [<c0761f00>] (kobject_add+0x6c/0x8c)
[    1.052490] [<c0761f00>] (kobject_add) from [<c04e831c>] (device_add+0xe4/0x510)
[    1.052551] [<c04e831c>] (device_add) from [<c04ec6e4>] (platform_device_add+0x130/0x1c0)
[    1.052612] [<c04ec6e4>] (platform_device_add) from [<c01281c0>] (omap_hsmmc_late_init+0x3c/0x60)
[    1.052673] [<c01281c0>] (omap_hsmmc_late_init) from [<c0b0fa44>] (omap3_pandora_legacy_init+0x24/0xb4)
[    1.052734] [<c0b0fa44>] (omap3_pandora_legacy_init) from [<c0128178>] (pdata_quirks_check+0x30/0x3c)
[    1.052795] [<c0128178>] (pdata_quirks_check) from [<c0b0f950>] (omap_generic_init+0xc/0x18)
[    1.052856] [<c0b0f950>] (omap_generic_init) from [<c0b03480>] (customize_machine+0x1c/0x28)
[    1.052917] [<c0b03480>] (customize_machine) from [<c0101938>] (do_one_initcall+0xa8/0x150)
[    1.052947] [<c0101938>] (do_one_initcall) from [<c0b00d70>] (kernel_init_freeable+0x110/0x1d4)
[    1.053009] [<c0b00d70>] (kernel_init_freeable) from [<c076f198>] (kernel_init+0x8/0x10c)
[    1.053070] [<c076f198>] (kernel_init) from [<c01070f0>] (ret_from_fork+0x14/0x24)
[    1.055023] ---[ end trace 44e490b09ac4ab88 ]---

This can be traced down to the calls of

	omap_hsmmc_init(pandora_mmc3);
	omap_hsmmc_late_init(pandora_mmc3);

in omap3_pandora_legacy_init().

It turns out that both funcions disagree how to decide if the other one was alredy called.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/mach-omap2/hsmmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index 5b614388d72f..6d28aa20a7d3 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -58,10 +58,10 @@ void omap_hsmmc_late_init(struct omap2_hsmmc_info *c)
 	struct platform_device *pdev;
 	int res;
 
-	if (omap_hsmmc_done != 1)
+	if (omap_hsmmc_done)
 		return;
 
-	omap_hsmmc_done++;
+	omap_hsmmc_done = 1;
 
 	for (; c->mmc; c++) {
 		pdev = c->pdev;
-- 
2.12.2
