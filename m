From: David Brownell <david-b@pacbell.net>
Subject: Re: Overo broken after recent mainline merge
Date: Sat, 14 Mar 2009 12:08:30 -0700
Message-ID: <200903141208.30413.david-b@pacbell.net>
References: <5e088bd90903140624u5b5098f4vd9b1afa937325779@mail.gmail.com> <20090314161252.GX19229@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp121.sbc.mail.sp1.yahoo.com ([69.147.64.94]:31065 "HELO
	smtp121.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751971AbZCNTId (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 14 Mar 2009 15:08:33 -0400
In-Reply-To: <20090314161252.GX19229@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Steve Sakoman <sakoman@gmail.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

On Saturday 14 March 2009, Tony Lindgren wrote:
> 
> > I've collected Dave's recent recent regulator patches and will try
> > again with those applied.
> 
> Thanks, let me know what we're missing in l-o tree.. I probably
> won't have a chance to look at it until Monday.

I suggest this as the current solution ... though the "right"
long term fix is still an open question.

The basic problem is that still-unfixed goofage in the regulator
framework:  it seriously mis-handles regulators that bootloaders
leave enabled.  This can be teased apart into at least two bugs,
possibly as many as four.  The fix for one of them is queued in
the regulator-next tree.

One workable solution is to use the twl4030-power driver to
initialize power resources including VMMC1 (I'll send a sample
patch) but that requires lots of per-board updates.  That will
remove the need for regulator-core fixes.

- Dave


====== CUT HERE
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
 drivers/regulator/core.c |   47 +++++++++++++++++++++++++++++----------------
 1 file changed, 31 insertions(+), 16 deletions(-)

--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -711,6 +711,7 @@ static int set_machine_constraints(struc
 	int ret = 0;
 	const char *name;
 	struct regulator_ops *ops = rdev->desc->ops;
+	int enable = 0;
 
 	if (constraints->name)
 		name = constraints->name;
@@ -799,10 +800,6 @@ static int set_machine_constraints(struc
 			}
 	}
 
-	/* are we enabled at boot time by firmware / bootloader */
-	if (rdev->constraints->boot_on)
-		rdev->use_count = 1;
-
 	/* do we need to setup our suspend state */
 	if (constraints->initial_state) {
 		ret = suspend_prepare(rdev, constraints->initial_state);
@@ -814,21 +811,39 @@ static int set_machine_constraints(struc
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
+	if (enable) {
+		if (ops->enable) {
+			ret = ops->enable(rdev);
+			if (ret < 0)
+				pr_warning("%s: %s disable --> %d\n",
+					       __func__, name, ret);
+		}
+		if (ret >= 0)
+			rdev->use_count = 1;
+	} else {
+		if (ops->disable) {
+			ret = ops->disable(rdev);
+			if (ret < 0)
+				pr_warning("%s: %s disable --> %d\n",
+					       __func__, name, ret);
 		}
 	}
 
-	print_constraints(rdev);
+	if (ret < 0)
+		rdev->constraints = NULL;
+	else
+		print_constraints(rdev);
 out:
 	return ret;
 }


