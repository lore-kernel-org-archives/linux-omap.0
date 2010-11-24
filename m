From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH 01/13] OMAP: Introduce a user list for each voltage
 domain instance in the voltage driver.
Date: Wed, 24 Nov 2010 10:45:44 +0100
Message-ID: <20101124104544.13da3cd2@surf>
References: <1282130412-12027-1-git-send-email-thara@ti.com>
	<1282130412-12027-2-git-send-email-thara@ti.com>
	<87eiddgjr7.fsf@deeprootsystems.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB03291AD889@dbde02.ent.ti.com>
	<87r5ha3hlk.fsf@deeprootsystems.com>
	<20100903173046.GA32226@rakim.wolfsonmicro.main>
	<87pqwu1zcw.fsf@deeprootsystems.com>
	<20100903182052.GB32226@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:43319 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752582Ab0KXJpy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Nov 2010 04:45:54 -0500
In-Reply-To: <20100903182052.GB32226@rakim.wolfsonmicro.main>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "Gopinath, Thara" <thara@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Liam Girdwood <lrg@slimlogic.co.uk>

Hello Mark,

On Fri, 3 Sep 2010 19:20:52 +0100
Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> Essentially all that needs doing is that when regulator_set_voltage() is
> called instead of merging with the machine constraints and applying the
> setting immediately we store the constraints that are specified in the
> consumer then iterate over all enabled consumers applying all the
> constraints that they've set in addition to those from the machine.
> This results in a configuration which is the lowest possible voltage
> which satisfies all the constraints that have been supplied and for
> supplies with only one consumer it gives the same behaviour as we have
> currently.

I went ahead and implemented this (without looking at previous existing
code since I couldn't find it). What about the following patch ?

I've tested it with a dummy platform driver and a dummy regulator
driver, making sure that the correct voltage gets set at the regulator
level. My testing had a device requesting a voltage [830000, 833000]
and another device [822000, 831000]. Without the patch, as the
regulator_set_voltage() gets called for the second device last, the
voltage is set at 822000 which is not acceptable for the first device.
With the patch, the 830000 voltage is kept, since it satisfies both
consumers. If the second device had [822000,828000] has its voltage
requirements, then regulator_set_voltage() would fail with -EINVAL since
it is not possible to find a voltage level that satisfies both
consumers.

If you're ok with it, I'll submit it the proper way.

Thanks,

Thomas


>From fa0edfc1a4428aead4502fcba248084c1194da53 Mon Sep 17 00:00:00 2001
From: Thomas Petazzoni <t-petazzoni@ti.com>
Date: Wed, 24 Nov 2010 10:34:35 +0100
Subject: [PATCH] regulator: Take into account the requirements of all consumers

Extend the regulator_set_voltage() function to take into account the
voltage requirements of all consumers of the regulator being changed,
in order to set the voltage to the minimum voltage acceptable to all
consumers. The existing behaviour was that the latest
regulator_set_voltage() call would win over previous
regulator_set_voltage() calls even if setting the voltage to a
non-acceptable level from other consumers.

Signed-off-by: Thomas Petazzoni <t-petazzoni@ti.com>
---
 drivers/regulator/core.c |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index f1d10c9..12a1cae 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -132,6 +132,28 @@ static int regulator_check_voltage(struct regulator_dev *rdev,
 	return 0;
 }
 
+/* Make sure we select a voltage that suits the needs of all
+ * regulator consumers
+ */
+static int regulator_check_consumers(struct regulator_dev *rdev,
+				     int *min_uV, int *max_uV)
+{
+	struct regulator *regulator;
+
+	list_for_each_entry(regulator, &rdev->consumer_list, list)
+	{
+		if (*max_uV > regulator->max_uV)
+			*max_uV = regulator->max_uV;
+		if (*min_uV < regulator->min_uV)
+			*min_uV = regulator->min_uV;
+	}
+
+	if (*min_uV > *max_uV)
+		return -EINVAL;
+
+	return 0;
+}
+
 /* current constraint check */
 static int regulator_check_current_limit(struct regulator_dev *rdev,
 					int *min_uA, int *max_uA)
@@ -1636,6 +1658,11 @@ int regulator_set_voltage(struct regulator *regulator, int min_uV, int max_uV)
 		goto out;
 	regulator->min_uV = min_uV;
 	regulator->max_uV = max_uV;
+
+	ret = regulator_check_consumers(rdev, &min_uV, &max_uV);
+	if (ret < 0)
+		goto out;
+
 	ret = rdev->desc->ops->set_voltage(rdev, min_uV, max_uV);
 
 out:
-- 
1.7.0.4



-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
