From: David Brownell <david-b@pacbell.net>
Subject: Re: Problems while designing TPS65023 regulator driver
Date: Sun, 8 Mar 2009 12:54:35 -0800
Message-ID: <200903081354.36044.david-b@pacbell.net>
References: <20090226140450.GB8595@sirena.org.uk> <200903061607.16825.david-b@pacbell.net> <20090307162233.GA12858@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp119.sbc.mail.sp1.yahoo.com ([69.147.64.92]:21631 "HELO
	smtp119.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753479AbZCHUyj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 8 Mar 2009 16:54:39 -0400
In-Reply-To: <20090307162233.GA12858@sirena.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Saturday 07 March 2009, Mark Brown wrote:
> What's happening here is that the kernel is making sure that the
> information it was given about the state of the regulator is actually
> true in case it was important ...

If that's a goal, then I suggest merging the appended patch,
which addresses a similar case:  both boot_on and always_on
are clear, so the regulator should not be enabled.

This *can* be important, as e.g. if those flags are clear
but the bootloader turned the regulator on, then drivers
can't disable the regulator (on penalty of a stackdump!)
unless they issue a spurious/pointless/undesirable enable()
beforehand ...

- Dave

========== CUT HERE
From: David Brownell <dbrownell@users.sourceforge.net>

Make the regulator setup code simpler and more consistent:

 - The only difference between "boot_on" and "always_on" is
   that an "always_on" regulator won't be disabled.  Both will
   be active (and usecount will be 1) on return from setup.

 - Regulators not marked as "boot_on" or "always_on" won't
   be active (and usecount will be 0) on return from setup.

The exception to that simple policy is when there's a non-Linux
interface to the regulator ... e.g. if either a DSP or the CPU
running Linux can enable the regulator, and the DSP needs it to
be on, then it will be on.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 drivers/regulator/core.c |   62 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 47 insertions(+), 15 deletions(-)

--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -711,6 +711,8 @@ static int set_machine_constraints(struc
 	int ret = 0;
 	const char *name;
 	struct regulator_ops *ops = rdev->desc->ops;
+	int enable = 0;
+	int is_enabled = -ENOSYS;
 
 	if (constraints->name)
 		name = constraints->name;
@@ -799,10 +801,6 @@ static int set_machine_constraints(struc
 			}
 	}
 
-	/* are we enabled at boot time by firmware / bootloader */
-	if (rdev->constraints->boot_on)
-		rdev->use_count = 1;
-
 	/* do we need to setup our suspend state */
 	if (constraints->initial_state) {
 		ret = suspend_prepare(rdev, constraints->initial_state);
@@ -814,17 +812,51 @@ static int set_machine_constraints(struc
 		}
 	}
 
-	/* if always_on is set then turn the regulator on if it's not
-	 * already on. */
-	if (constraints->always_on && ops->enable &&
-	    ((ops->is_enabled && !ops->is_enabled(rdev)) ||
-	     (!ops->is_enabled && !constraints->boot_on))) {
-		ret = ops->enable(rdev);
-		if (ret < 0) {
-			printk(KERN_ERR "%s: failed to enable %s\n",
-			       __func__, name);
-			rdev->constraints = NULL;
-			goto out;
+	/* Should this be enabled when we return from here?  The difference
+	 * between "boot_on" and "always_on" is that "always_on" regulators
+	 * won't ever be disabled.
+	 */
+	if (constraints->boot_on || constraints->always_on)
+		enable = 1;
+
+	/* Make sure the regulator isn't wrongly enabled or disabled.
+	 * Bootloaders are often sloppy about leaving things on; and
+	 * sometimes Linux wants to use a different model.
+	 */
+	if (ops->is_enabled)
+		is_enabled = ops->is_enabled(rdev);
+	if (enable) {
+		if (ops->enable) {
+			/* forcibly enable if it's off or we can't tell */
+			if (is_enabled <= 0) {
+				ret = ops->enable(rdev);
+				pr_warning("%s: %s '%s' --> %d\n",
+					       __func__, "enable", name, ret);
+				if (ret < 0) {
+					rdev->constraints = NULL;
+					goto out;
+				}
+			}
+		} else if (is_enabled < 0) {
+			pr_warning("%s: hoping regulator '%s' is %sd...\n",
+				       __func__, name, "enable");
+		}
+		rdev->use_count = 1;
+	} else {
+		if (ops->disable) {
+			/* forcibly disable if it's on or we can't tell */
+			if (is_enabled != 0) {
+				ret = ops->disable(rdev);
+				pr_warning("%s: %s '%s' --> %d\n",
+					       __func__, "disable", name, ret);
+				if (ret < 0) {
+					rdev->constraints = NULL;
+					goto out;
+				}
+			}
+		} else if (is_enabled < 0) {
+			pr_warning("%s: hoping regulator '%s' is %sd...\n",
+				       __func__, name, "disable");
 		}
 	}
 

