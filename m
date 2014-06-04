From: Nishanth Menon <nm@ti.com>
Subject: Re: mainline boot: 37 passed 4 failed
 (mainline/v3.15-rc8-4569-g3de0ef8) (palmas regression uEVM)
Date: Wed, 4 Jun 2014 14:34:31 -0500
Message-ID: <20140604193431.GB4858@kahuna>
References: <538e6a20.0168440a.7895.422b@mx.google.com>
 <CAOesGMg4ESoPVvCc4is7wpA8PVOOSDzh5=VZZ67NnJjD3jUzmw@mail.gmail.com>
 <20140604090111.GE2520@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58227 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750780AbaFDTfF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 4 Jun 2014 15:35:05 -0400
Content-Disposition: inline
In-Reply-To: <20140604090111.GE2520@sirena.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Olof Johansson <olof@lixom.net>, Kevin Hilman <khilman@linaro.org>, kernel-build-reports@lists.linaro.org, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, j-keerthy@ti.com

Minor change in subject, +Keerthy.

On 10:01-20140604, Mark Brown wrote:
> On Tue, Jun 03, 2014 at 06:26:14PM -0700, Olof Johansson wrote:
> > On Tue, Jun 3, 2014 at 5:36 PM, Olof's autobooter <build@lixom.net> wrote:
> 
> > > [    2.816920] smps9: failed to get the current voltage
> 
> > This seems to be from palmas registration failing, which in turns
> > causes vmmc regulator lookup to fail. See the errors about palmas-pmic
> > above.
> 
> Always CC maintainers on things.  This is a bug in the driver, it needs
> to support retrieving voltages at all times (and would probably run into
> trouble anyway).
Full thread: http://marc.info/?t=140184538000004&r=1&w=2

Yeah, this does seems to be a regression. The following is based on
next-20140604.

Seems to help my OMAP5uevm.
If this makes sense, I will repost it as a formal patch.

8<----------------
>From 3feaa7f5c749b1673aef3fd26f43b965dd627dc9 Mon Sep 17 00:00:00 2001
From: Nishanth Menon <nm@ti.com>
Date: Wed, 4 Jun 2014 14:09:09 -0500
Subject: [PATCH] regulator: palmas: Fix SMPS list for 0V

get_voltage_sel reads from SMPS register - if the read selector value
is 0, the SMPS is actually disabled - So, this is in addition to the
ctrl_register that may also be used to enable/disable the SMPS.

The original logic(prior to commit dbabd624d4eec50b6) used to be:
static int palmas_map_voltage_smps(struct regulator_dev *rdev,
               int min_uV, int max_uV)
<snip>
       if (min_uV == 0)
               return 0;

To handle this scenario, with the transition to regulator_list
implementation, we seem to have missed the data necessary to mark as
one of the valid entries as "0" 'disabled regulator' which results in
0 volts - So, stick with pre-existing logic.

Without this added to the list, palmas regulator driver,
on probe, attempts to setup constraints and in the case of
OMAP5uEVM, SMPS9 (which is mapped for 2v1 audio supply) fails in
regulator_list_voltage_linear_range mapping of '0', and as a fall back
of constraints not being applied, the entire regulator list is not
enumerated due to assumption that something system wide has gone bad
on with the PMIC.

Fixes: dbabd624d4eec50b6 ("regulator: palmas: Reemove open coded functions with helper functions")
Reported-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 drivers/regulator/palmas-regulator.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/regulator/palmas-regulator.c b/drivers/regulator/palmas-regulator.c
index 864ed02..b982f0f 100644
--- a/drivers/regulator/palmas-regulator.c
+++ b/drivers/regulator/palmas-regulator.c
@@ -37,12 +37,14 @@ struct regs_info {
 };
 
 static const struct regulator_linear_range smps_low_ranges[] = {
+	REGULATOR_LINEAR_RANGE(0, 0x0, 0x0, 0),
 	REGULATOR_LINEAR_RANGE(500000, 0x1, 0x6, 0),
 	REGULATOR_LINEAR_RANGE(510000, 0x7, 0x79, 10000),
 	REGULATOR_LINEAR_RANGE(1650000, 0x7A, 0x7f, 0),
 };
 
 static const struct regulator_linear_range smps_high_ranges[] = {
+	REGULATOR_LINEAR_RANGE(0, 0x0, 0x0, 0),
 	REGULATOR_LINEAR_RANGE(1000000, 0x1, 0x6, 0),
 	REGULATOR_LINEAR_RANGE(1020000, 0x7, 0x79, 20000),
 	REGULATOR_LINEAR_RANGE(3300000, 0x7A, 0x7f, 0),
-- 
1.7.9.5


-- 
Regards,
Nishanth Menon
