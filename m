From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.29-rc8 regulator-next] regulator: init fixes (v4)
Date: Sat, 14 Mar 2009 17:25:35 -0700
Message-ID: <200903141725.35541.david-b@pacbell.net>
References: <200903111743.34708.david-b@pacbell.net> <200903111932.16317.david-b@pacbell.net> <20090312120119.GB24376@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from n27.bullet.mail.mud.yahoo.com ([68.142.206.222]:44312 "HELO
	n27.bullet.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751723AbZCOAZk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 14 Mar 2009 20:25:40 -0400
In-Reply-To: <20090312120119.GB24376@sirena.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@sirena.org.uk>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: lkml <linux-kernel@vger.kernel.org>, OMAP <linux-omap@vger.kernel.org>

From: David Brownell <dbrownell@users.sourceforge.net>

Make the regulator setup code cope more consistently with
regulators left enabled by the bootloader ... making it act
as if the "boot_on" flag were being set by the boot loader
(as needed) instead of by Linux board init code (always).

This eliminates the other half of the bug whereby regulators
that were enabled during the boot sequence would be enabled
with enable count of zero ... preventing regulator_disable()
from working when called from drivers.  (The first half was
fixed by the "regulator: refcount fixes" patch, and related
specifically to the "boot_on" flag.)

One open issue involves systems that need to force a regulator
off at boot time -- the converse of today's "boot_on" flag. 
There can be arbitrarily long delays between system startup
and when a driver can be loaded to turn off the regulator,
during which power is being wasted.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 drivers/regulator/core.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -815,6 +815,14 @@ static int set_machine_constraints(struc
 			goto out;
 		}
 		rdev->use_count = 1;
+	} else if (ops->is_enabled) {
+		/* ... if the bootloader left it on, drivers need a
+		 * nonzero enable count else it can't be disabled.
+		 */
+		ret = ops->is_enabled(rdev);
+		if (ret > 0)
+			rdev->use_count = 1;
+		ret = 0;
 	}
 
 	print_constraints(rdev);

