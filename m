From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH] regulator: Provide dummy supply support
Date: Wed, 2 Nov 2011 11:03:56 +0100
Message-ID: <20111102100355.GJ23421@pengutronix.de>
References: <1319833618-25190-1-git-send-email-s.hauer@pengutronix.de>
 <20111028215931.GA30366@opensource.wolfsonmicro.com>
 <20111028224757.GG23421@pengutronix.de>
 <201111011350.17425.vapier@gentoo.org>
 <20111101182720.GH10029@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58042 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755200Ab1KBKEL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Nov 2011 06:04:11 -0400
Content-Disposition: inline
In-Reply-To: <20111101182720.GH10029@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Mike Frysinger <vapier@gentoo.org>, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>, Linus Walleij <linus.walleij@linaro.org>, Paul Mundt <lethal@linux-sh.org>, Tony Lindgren <tony@atomide.com>, linux-sh@vger.kernel.org, linux-omap@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org

On Tue, Nov 01, 2011 at 06:27:21PM +0000, Mark Brown wrote:
> On Tue, Nov 01, 2011 at 01:50:14PM -0400, Mike Frysinger wrote:
> > On Friday 28 October 2011 18:47:57 Sascha Hauer wrote:
> 
> > > > We already have a dummy regulator driver and a fixed voltage regulator
> > > > driver, we shouldn't be adding a third implementation of the same thing.
> > > > Just use the fixed voltage regulator for this.
> 
> > > I explained in my mail why I think that the current implementation of
> > > the dummy regulator is not suitable for things apart from debugging.
> 
> > your complaints seem to be specific to how the dummy regulator gets hooked in 
> > and not in the specific regulator implementation.  so it seems like the right 
> > thing would be to split the kconfig knobs:
> 
> Quite.  Sascha, your mail doesn't refer to the implementation of the
> regulator itself at all.  Nothing in your changelog even mentions that
> you're introducing a new regulator driver.
> 
> I think there's a big abstraction understanding failure here, reading
> your changelog I'm not sure you understand the existing mechainsms that
> are in place.  You say:
> 
> | This patch allows a board to register dummy supplies for devices
> | which need a regulator but which is not software controllable
> | on this board.
> 
> but this is exactly the use case the fixed voltage regulator is there
> for.
> 
> >  config REGULATOR_DUMMY
> > -	bool "Provide a dummy regulator if regulator lookups fail"
> > +	bool "Provide a dummy regulator"
> > +config REGULATOR_DUMMY_FALLBACK
> > +	bool "Fallback to dummy regulator if lookup fails"
> > +	depends on REGULATOR_DUMMY
> 
> As I think I said earlier I'd use the fixed regulator for this, all
> Sascha's actually doing here is adding a wrapper to simplify
> registration of that.

There's one difference between the fixed and the dummy regulator though:
The fixed regulator has a voltage. The same dummy regulator instance can
be used for all devices which do not have a software controllable
regulator. I think the same can be done with the fixed regulator aswell,
but the bogus voltage showing up in the sysfs entry might be confusing
to users.
That's the reason I implemented a (second) dummy regulator driver.
Indeed it's not nice to have two of them.

Another approach to this topic would be to allow a board to explicitely
bind to the existing dummy regulator, like the following (error path
should of course be implemented before applying this)

Sascha

8<------------------------------------

[PATCH] regulator: allow boards to bind to the dummy regulator

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/regulator/core.c          |   19 +++++++++++++++++++
 include/linux/regulator/machine.h |    8 ++++++++
 2 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index d8e6a42..a7a38ba 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1046,6 +1046,25 @@ static void unset_regulator_supplies(struct regulator_dev *rdev)
 	}
 }
 
+int regulator_add_dummy_supply(struct regulator_consumer_supply *supply,
+		int num_supplies)
+{
+	int i, ret;
+
+	for (i = 0; i < num_supplies; i++) {
+		ret = set_consumer_device_supply(dummy_regulator_rdev, NULL,
+				supply[i].dev_name, supply[i].supply);
+		if (ret)
+			goto err_out;
+	}
+
+	return 0;
+err_out:
+	/* FIXME: unset device supply */
+	return ret;
+}
+EXPORT_SYMBOL_GPL(regulator_add_dummy_supply);
+
 #define REG_STR_SIZE	64
 
 static struct regulator *create_regulator(struct regulator_dev *rdev,
diff --git a/include/linux/regulator/machine.h b/include/linux/regulator/machine.h
index ce3127a..89089cd 100644
--- a/include/linux/regulator/machine.h
+++ b/include/linux/regulator/machine.h
@@ -192,6 +192,8 @@ int regulator_suspend_finish(void);
 #ifdef CONFIG_REGULATOR
 void regulator_has_full_constraints(void);
 void regulator_use_dummy_regulator(void);
+int regulator_add_dummy_supply(struct regulator_consumer_supply *supply,
+		int num_supplies);
 #else
 static inline void regulator_has_full_constraints(void)
 {
@@ -200,6 +202,12 @@ static inline void regulator_has_full_constraints(void)
 static inline void regulator_use_dummy_regulator(void)
 {
 }
+
+static inline int regulator_add_dummy_supply(struct regulator_consumer_supply *supply,
+		int num_supplies)
+{
+	return 0;
+}
 #endif
 
 #endif
-- 
1.7.7

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
