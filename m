From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.29-rc7 regulator-next] regulator: init fixes
Date: Wed, 11 Mar 2009 18:32:15 -0800
Message-ID: <200903111932.16317.david-b@pacbell.net>
References: <200903111743.34708.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp125.sbc.mail.sp1.yahoo.com ([69.147.65.184]:24581 "HELO
	smtp125.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751389AbZCLCcT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 Mar 2009 22:32:19 -0400
In-Reply-To: <200903111743.34708.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@sirena.org.uk>
Cc: lkml <linux-kernel@vger.kernel.org>, OMAP <linux-omap@vger.kernel.org>

From: David Brownell <dbrownell@users.sourceforge.net>

Make the regulator setup code cope more consistently with
regulators undesirably left enabled by the bootloader.

Building on the previous refcount patch:

 * Unless the "boot_on" or "always_on" machine constraints
   were set, disable() the regulator.  This gives drivers
   a clean start state:  enable state matches usecount,
   regardless of boot_on/always_on flag state.

 * To help make some integration stages easier, add a new
   "devmode" machine constraint where state the bootloader
   left isn't touched, but enable state and usecount may
   not match.  (System boots but some drivers act odd ...
   debuggable.  System dies part way through booting ...
   often painful.)

Consider a bootloader that leaves an MMC/SD regulator active
when it loads Linux from an SD card.  It may take some time
before the MMC/SD driver gets loaded, if ever ... to save
power, that (LDO) regulator should be disabled ASAP.  Then
later when the MMC driver starts up, the Linux MMC stack will
need to start from a "power off" state.  It can't just

	if (regulator_is_enabled(r))
		regulator_disable(r);

unless enable state and usecount are matched ... but without
this patch, they *will* be mismatched whenever the bootloader
happens to have left that regulator active!  Similar issues
can crop up with almost any regulator.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 drivers/regulator/core.c          |   47 +++++++++++++++++++++++++++++-------
 include/linux/regulator/machine.h |    3 +-
 2 files changed, 40 insertions(+), 10 deletions(-)

--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -799,18 +799,47 @@ static int set_machine_constraints(struc
 		}
 	}
 
-	/* If the constraints say the regulator should be on at this point
-	 * and we have control then make sure it is enabled.
+	/* During integration, developers may need time to sort out what
+	 * to do with this regulator; leave the bootloader's setting alone.
+	 * Regulator consumers won't get consistent behavior.
+	 *
+	 * Else the constraints say whether it should be on or off; we
+	 * don't leave it in an unknown state.
 	 */
-	if ((constraints->always_on || constraints->boot_on) && ops->enable) {
-		ret = ops->enable(rdev);
-		if (ret < 0) {
-			printk(KERN_ERR "%s: failed to enable %s\n",
-			       __func__, name);
-			rdev->constraints = NULL;
-			goto out;
+	if (constraints->devmode) {
+		char *label = "unknown";
+
+		if (ops->is_enabled) {
+			ret = ops->is_enabled(rdev);
+			if (ret == 0)
+				label = "disabled";
+			else if (ret > 0)
+				label = "enabled";
+			ret = 0;
+		}
+		pr_warning("%s: devmode regulator '%s' state is '%s'\n",
+			       __func__, name, label);
+	} else if (constraints->always_on || constraints->boot_on) {
+		if (ops->enable) {
+			ret = ops->enable(rdev);
+			if (ret < 0) {
+				pr_err("%s: failed enabling %s\n",
+				       __func__, name);
+				rdev->constraints = NULL;
+				goto out;
+			}
 		}
 		rdev->use_count = 1;
+	} else {
+		if (ops->disable) {
+			ret = ops->disable(rdev);
+			if (ret < 0) {
+				pr_err("%s: failed disabling %s\n",
+				       __func__, name);
+				rdev->constraints = NULL;
+				goto out;
+			}
+		}
 	}
 
 	print_constraints(rdev);
--- a/include/linux/regulator/machine.h
+++ b/include/linux/regulator/machine.h
@@ -117,7 +117,8 @@ struct regulation_constraints {
 	/* mode to set on startup */
 	unsigned int initial_mode;
 
-	/* constriant flags */
+	/* constraint flags */
+	unsigned devmode:1;	/* state after setup is indeterminate */
 	unsigned always_on:1;	/* regulator never off when system is on */
 	unsigned boot_on:1;	/* bootloader/firmware enabled regulator */
 	unsigned apply_uV:1;	/* apply uV constraint iff min == max */
