From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 1/14] PM: Fix error code paths executed after failing syscore_suspend()
Date: Sun, 17 Apr 2011 23:05:57 +0200
Message-ID: <201104172305.57989.rjw@sisk.pl>
References: <201103280125.11750.rjw@sisk.pl> <201104172301.54115.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201104172301.54115.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Greg KH <gregkh@suse.de>, Kay Sievers <kay.sievers@suse.de>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.com>, linux-arm-kernel@lists.infradead.org, Ben Dooks <ben-linux@fluff.org>, Mike Frysinger <vapier@gentoo.org>, Ralf Baechle <ralf@linux-mips.org>, Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@lists.ozlabs.org, Jiri Kosina <jkosina@suse.cz>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>
List-Id: linux-omap@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

If syscore_suspend() fails in suspend_enter(), create_image() or
resume_target_kernel(), it is necessary to call sysdev_resume(),
because sysdev_suspend() has been called already and succeeded
and we are going to abort the transition.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 kernel/power/hibernate.c |   10 ++++++++--
 kernel/power/suspend.c   |    5 ++++-
 2 files changed, 12 insertions(+), 3 deletions(-)

Index: linux-2.6/kernel/power/suspend.c
===================================================================
--- linux-2.6.orig/kernel/power/suspend.c
+++ linux-2.6/kernel/power/suspend.c
@@ -164,8 +164,11 @@ static int suspend_enter(suspend_state_t
 	BUG_ON(!irqs_disabled());
 
 	error = sysdev_suspend(PMSG_SUSPEND);
-	if (!error)
+	if (!error) {
 		error = syscore_suspend();
+		if (error)
+			sysdev_resume();
+	}
 	if (!error) {
 		if (!(suspend_test(TEST_CORE) || pm_wakeup_pending())) {
 			error = suspend_ops->enter(state);
Index: linux-2.6/kernel/power/hibernate.c
===================================================================
--- linux-2.6.orig/kernel/power/hibernate.c
+++ linux-2.6/kernel/power/hibernate.c
@@ -273,8 +273,11 @@ static int create_image(int platform_mod
 	local_irq_disable();
 
 	error = sysdev_suspend(PMSG_FREEZE);
-	if (!error)
+	if (!error) {
 		error = syscore_suspend();
+		if (error)
+			sysdev_resume();
+	}
 	if (error) {
 		printk(KERN_ERR "PM: Some system devices failed to power down, "
 			"aborting hibernation\n");
@@ -407,8 +410,11 @@ static int resume_target_kernel(bool pla
 	local_irq_disable();
 
 	error = sysdev_suspend(PMSG_QUIESCE);
-	if (!error)
+	if (!error) {
 		error = syscore_suspend();
+		if (error)
+			sysdev_resume();
+	}
 	if (error)
 		goto Enable_irqs;
 
