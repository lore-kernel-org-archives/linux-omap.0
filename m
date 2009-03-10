From: David Brownell <david-b@pacbell.net>
Subject: Re: Problems while designing TPS65023 regulator driver
Date: Mon, 9 Mar 2009 16:45:26 -0800
Message-ID: <200903091745.28071.david-b@pacbell.net>
References: <20090226140450.GB8595@sirena.org.uk> <200903081354.36044.david-b@pacbell.net> <20090308224145.GD18035@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from n18.bullet.mail.mud.yahoo.com ([68.142.206.145]:34730 "HELO
	n18.bullet.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753760AbZCJApc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Mar 2009 20:45:32 -0400
In-Reply-To: <20090308224145.GD18035@sirena.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Sunday 08 March 2009, Mark Brown wrote:
> On Sun, Mar 08, 2009 at 12:54:35PM -0800, David Brownell wrote:
> 
> > but the bootloader turned the regulator on, then drivers
> > can't disable the regulator (on penalty of a stackdump!)
> > unless they issue a spurious/pointless/undesirable enable()
> > beforehand ...
> 
> We can't easily have both reference counting and unbalanced disables,
> sadly.

The patch I sent had an "easy" solution though:  on return
from initialization (according to the board constraints),
refcount is zero if disable() was called, one if enable()
was called instead.

(There's a glitch associated with using multiple refcounts
though; see below.)


> >  - Regulators not marked as "boot_on" or "always_on" won't
> >    be active (and usecount will be 0) on return from setup.
> 
> This breaks the idea that we don't do anything unless explictly told to
> do so.

I'm not sure where you're drawing this "explicitly" line, but
clearly it's not where I would draw it!  The board init code
explicitly said "here's a regulator, with these settings for
the boot_on and always_on flags".  If neither was set, they
are obviously clear ... so the regulator shouldn't be enabled.


> I did actually still consider adding code to power off the 
> regulator but thought that there may also be situations where the state
> really is unknown (eg, it depends on what the system booted from) and
> it'd be useful to be able to punt to the consumers to figure it out.

The core problem with that thought is that if you try doing that,
then consumers have exactly zero ways to fix the issue.  It's the
scenario I listed above:  regulator is enabled, but refcount is
zero.  So they're not allowed to disable.

That's in addition to the fact that "unknown" states are
extremely error prone.  The state after initialization should
fully known, without having to play such guessing games.


> I'm a bit ambivalent on this one, though - avoiding a sprawl of options
> is certainly neater.  An enum for the initial power state has an appeal
> here.

A boolean "boot_on" enum value seems sufficient.  Two clearly
defined values.  Adding a second "always_on" flag makes for
some confusion, since it only defines a third state, not a
pair of states (it's not orthogonal).

 
> > -	/* are we enabled at boot time by firmware / bootloader */
> > -	if (rdev->constraints->boot_on)
> > -		rdev->use_count = 1;
> > -
> 
> That's not there with the current regulator tree (this was the bug with
> not being able to disable boot_on regulators, there's no way to drop
> that use count later on).

Other than regulator_disable()?  I don't follow.   There was a
real mess of convoluted logic later on, true.  And I see it was
somewhat simplified by 38db9f31d6dc6147b87692b3b5a8a32de1a6cbe6.

Are you referring to the fact that the refcounting is oddly split
between the consumer handle ("struct regulator") and the real
regulator ("struct regulator_dev")?  If so, the fix is easy:
always have the consumer ops delegate to the real regulator.
And have that real regulator's usecount set to one when it's
enabled at boot time, so regulator_disable() will work then.


> Much of the rest of your patch will fail to apply due to similar
> changes; the logic that's there now is roughly the same as what you have
> here except we don't bother to check is_enabled() any more (no harm
> adding that back, it'd be useful if enable() can't be called for an
> already enabled regulator) and we don't disable the regulator.

.... and, the most important bit in terms of being able to
use the regulator calls in some of these cases, disabling
regulators that aren't supposed to be enabled.

Updated version below.  It preserves the existing refcount
bug (noted above), and has only been build-tested.

- Dave


======= CUT HERE
From: David Brownell <dbrownell@users.sourceforge.net>

Make the regulator setup code more consistent:  unless a
regulator is marked as "boot_on" or "always_on", it will
always be configured as inactive on return from setup.

Note that there's still a mess with respect to refcounting,
which is shared unequally between consumer and provider handles
("struct regulator" and "struct regulator_dev" respectively).
Only the "inactive after setup" case works cleanly.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 drivers/regulator/core.c |   29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -801,15 +801,28 @@ static int set_machine_constraints(struc
 	}
 
 	/* If the constraints say the regulator should be on at this point
-	 * and we have control then make sure it is enabled.
+	 * and we have control then make sure it is enabled.  Else, it's
+	 * supposed to be disabled ... be sure of that, instead.
 	 */
-	if ((constraints->always_on || constraints->boot_on) && ops->enable) {
-		ret = ops->enable(rdev);
-		if (ret < 0) {
-			printk(KERN_ERR "%s: failed to enable %s\n",
-			       __func__, name);
-			rdev->constraints = NULL;
-			goto out;
+	if (constraints->always_on || constraints->boot_on) {
+		if (ops->enable) {
+			ret = ops->enable(rdev);
+			if (ret < 0) {
+				pr_err("%s: failed to enable %s\n",
+				       __func__, name);
+				rdev->constraints = NULL;
+				goto out;
+			}
+		}
+	} else {
+		if (ops->disable) {
+			ret = ops->disable(rdev);
+			if (ret < 0) {
+				pr_err("%s: failed disabling %s\n",
+				       __func__, name);
+				rdev->constraints = NULL;
+				goto out;
+			}
 		}
 	}
 

