From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 4/4] arm: omap2: no need to check return value of debugfs_create functions
Date: Tue, 22 Jan 2019 15:41:14 +0100
Message-ID: <20190122144114.9816-5-gregkh@linuxfoundation.org>
References: <20190122144114.9816-1-gregkh@linuxfoundation.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190122144114.9816-1-gregkh@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>, Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>, Will Deacon <will.deacon@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Cc: Kevin Hilman <khilman@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/mach-omap2/pm-debug.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index 5a8839203958..1f9334a3d611 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -193,9 +193,8 @@ static int __init pwrdms_setup(struct powerdomain *pwrdm, void *dir)
 		return 0;
 
 	d = debugfs_create_dir(pwrdm->name, (struct dentry *)dir);
-	if (d)
-		(void) debugfs_create_file("suspend", S_IRUGO|S_IWUSR, d,
-			(void *)pwrdm, &pwrdm_suspend_fops);
+	debugfs_create_file("suspend", S_IRUGO|S_IWUSR, d, pwrdm,
+			    &pwrdm_suspend_fops);
 
 	return 0;
 }
@@ -233,16 +232,14 @@ static int __init pm_dbg_init(void)
 		return 0;
 
 	d = debugfs_create_dir("pm_debug", NULL);
-	if (!d)
-		return -EINVAL;
 
-	(void) debugfs_create_file("count", 0444, d, NULL, &pm_dbg_counters_fops);
-	(void) debugfs_create_file("time", 0444, d, NULL, &pm_dbg_timers_fops);
+	debugfs_create_file("count", 0444, d, NULL, &pm_dbg_counters_fops);
+	debugfs_create_file("time", 0444, d, NULL, &pm_dbg_timers_fops);
 
 	pwrdm_for_each(pwrdms_setup, (void *)d);
 
-	(void) debugfs_create_file("enable_off_mode", S_IRUGO | S_IWUSR, d,
-				   &enable_off_mode, &pm_dbg_option_fops);
+	debugfs_create_file("enable_off_mode", S_IRUGO | S_IWUSR, d,
+			    &enable_off_mode, &pm_dbg_option_fops);
 	pm_dbg_init_done = 1;
 
 	return 0;
-- 
2.20.1
