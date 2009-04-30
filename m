From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: Overo broken with current top of tree
Date: Thu, 30 Apr 2009 11:16:19 +0100
Message-ID: <20090430101619.GE10190@sirena.org.uk>
References: <5e088bd90904290903q1e13afb6g2df13364a7ec0ddf@mail.gmail.com> <6ed0b2680904300231y2afa25a7ge192eb3333d7353b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:55709 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751797AbZD3KQV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Apr 2009 06:16:21 -0400
Content-Disposition: inline
In-Reply-To: <6ed0b2680904300231y2afa25a7ge192eb3333d7353b@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Steve Sakoman <sakoman@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, David Brownell <david-b@pacbell.net>

On Thu, Apr 30, 2009 at 12:31:47PM +0300, Grazvydas Ignotas wrote:
> On Wed, Apr 29, 2009 at 7:03 PM, Steve Sakoman <sakoman@gmail.com> wrote:

> > set_machine_constraints: invalid 'VUSB1V5' voltage constraints

> I get the same on pandora, although it continues booting fine after
> that. Maybe regulator folks will comment about regulator errors.

I suspect this may be due to the buggy defaults that are provided when
no voltage constraints are given for a fixed voltage regulator.  There's
a patch on its way to mainline fixing this:

commit 14d32bb077f7cc6f78bd012e5b1489899dddf749
Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date:   Tue Apr 28 11:09:38 2009 +0100

    regulator: Fix default constraints for fixed voltage regulators
    
    Default voltage constraints were being provided for fixed voltage
    regulator where board constraints were not provided but these constraints
    used INT_MIN as the default minimum voltage which is not a valid value
    since it is less than zero. Use 1uV instead.
    
    Also set the default values we set in the constraints themselves since
    otherwise the max_uV constraint we determine will not be stored in the
    actual constraint strucutre and will therefore not be used.
    
    Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
    Signed-off-by: Liam Girdwood <lrg@slimlogic.co.uk>

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 2f14c16..98c3a74 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -703,10 +703,13 @@ static int set_machine_constraints(struct regulator_dev *rdev,
 		int	cmin = constraints->min_uV;
 		int	cmax = constraints->max_uV;
 
-		/* it's safe to autoconfigure fixed-voltage supplies */
+		/* it's safe to autoconfigure fixed-voltage supplies
+		   and the constraints are used by list_voltage. */
 		if (count == 1 && !cmin) {
-			cmin = INT_MIN;
+			cmin = 1;
 			cmax = INT_MAX;
+			constraints->min_uV = cmin;
+			constraints->max_uV = cmax;
 		}
 
 		/* voltage constraints are optional */
