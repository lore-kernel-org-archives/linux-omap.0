From: Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH RFC RFT 2/3] clk: clk_put WARNs if user has not disabled clk
Date: Wed, 21 Oct 2015 08:50:57 -0700
Message-ID: <20151021155057.20687.14055@quantum>
References: <1438974570-20812-1-git-send-email-mturquette@baylibre.com>
 <1438974570-20812-3-git-send-email-mturquette@baylibre.com>
 <CAMuHMdX8Fq3AfxuZMLe4-CYFzrDiQcwnREQhX5fSGXzYNSkKsA@mail.gmail.com>
 <20151020124000.20687.60752@quantum>
 <CAMuHMdWd9LxrSWO5snriW+fb_d8FtMeXUBjp3M-Oeahh+FzJcw@mail.gmail.com>
 <20151021105932.GP32536@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <20151021105932.GP32536@n2100.arm.linux.org.uk>
Sender: linux-clk-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-clk <linux-clk@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, Lee Jones <lee.jones@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Sascha Hauer <s.hauer@pengutronix.de>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux-sh list <linux-sh@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Quoting Russell King - ARM Linux (2015-10-21 03:59:32)
> On Wed, Oct 21, 2015 at 11:50:07AM +0200, Geert Uytterhoeven wrote:
> > Hi Mike, Russell,
> > 
> > On Tue, Oct 20, 2015 at 2:40 PM, Michael Turquette
> > <mturquette@baylibre.com> wrote:
> > > Why not keep the reference to the struct clk after get'ing it the first
> > > time?
> > 
> > And store it where?
> 
> Not my problem :)
> 
> Users are supposed to hold on to the reference obtained via clk_get()
> while they're making use of the clock: in some implementations, this
> increments the module use count if the clock driver is a module, and
> may have other effects too.
> 
> Dropping that while you're still requiring the clock to be enabled is
> unsafe: if it is provided by a module, then removing and reinserting
> the module may very well change the enabled state of the clock, it
> most certainly will disrupt the enable count.
> 
> It's always been this way, right from the outset, and when I've seen
> people doing this bollocks, I've always pointed out that it's wrong.
> Generally, people will fix it once they become aware of it, so it's
> really that people just don't like reading and conforming to published
> API requirements.
> 
> I think the root cause is that people just don't like reading what
> other people write in terms of documentation, and they prefer to go
> off and do their own thing, provided it works for them.

Right, so in other words this problem must be solved by the caller of
clk_get, as it should be. I have never much looked at the pm clk code in
question, but I gave it a quick look and came up with some example code
that does not compile, in an effort to be as helpful as possible.

Basically I added a flex array to struct pm_clk_notifier_block, so that
now there are two flex arrays which is stupid. But I am too lazy to
replace the nbclk->clks thing with a malloc after walking all of the
clk_id's to figure out the number of clocks. Or we could just add
.num_clk to the struct, fix up all 4 users of it and drop the NULL
sentinel used the .clk_id's... Hmm that would have been better.

Anyways here is the ugly, non-compiling code. I'll take another look at
it in one year if no one else beats me to it.

Regards,
Mike



diff --git a/arch/arm/mach-davinci/pm_domain.c b/arch/arm/mach-davinci/pm_domain.c
index 78eac2c..b46e5ce 100644
--- a/arch/arm/mach-davinci/pm_domain.c
+++ b/arch/arm/mach-davinci/pm_domain.c
@@ -24,6 +24,7 @@ static struct dev_pm_domain davinci_pm_domain = {
 static struct pm_clk_notifier_block platform_bus_notifier = {
 	.pm_domain = &davinci_pm_domain,
 	.con_ids = { "fck", "master", "slave", NULL },
+	.clks = { ERR_PTR(-EAGAIN), ERR_PTR(-EAGAIN), ERR_PTR(-EAGAIN) },
 };
 
 static int __init davinci_pm_runtime_init(void)
diff --git a/arch/arm/mach-keystone/pm_domain.c b/arch/arm/mach-keystone/pm_domain.c
index e283939..d21c18b 100644
--- a/arch/arm/mach-keystone/pm_domain.c
+++ b/arch/arm/mach-keystone/pm_domain.c
@@ -27,6 +27,7 @@ static struct dev_pm_domain keystone_pm_domain = {
 
 static struct pm_clk_notifier_block platform_domain_notifier = {
 	.pm_domain = &keystone_pm_domain,
+	.clks = { ERR_PTR(-EAGAIN) },
 };
 
 static const struct of_device_id of_keystone_table[] = {
diff --git a/arch/arm/mach-omap1/pm_bus.c b/arch/arm/mach-omap1/pm_bus.c
index 667c163..5506453 100644
--- a/arch/arm/mach-omap1/pm_bus.c
+++ b/arch/arm/mach-omap1/pm_bus.c
@@ -31,6 +31,7 @@ static struct dev_pm_domain default_pm_domain = {
 static struct pm_clk_notifier_block platform_bus_notifier = {
 	.pm_domain = &default_pm_domain,
 	.con_ids = { "ick", "fck", NULL, },
+	.clks = { ERR_PTR(-EAGAIN), ERR_PTR(-EAGAIN) },
 };
 
 static int __init omap1_pm_runtime_init(void)
diff --git a/drivers/base/power/clock_ops.c b/drivers/base/power/clock_ops.c
index 652b5a3..26f0dcf 100644
--- a/drivers/base/power/clock_ops.c
+++ b/drivers/base/power/clock_ops.c
@@ -407,40 +407,6 @@ int pm_clk_runtime_resume(struct device *dev)
 #else /* !CONFIG_PM */
 
 /**
- * enable_clock - Enable a device clock.
- * @dev: Device whose clock is to be enabled.
- * @con_id: Connection ID of the clock.
- */
-static void enable_clock(struct device *dev, const char *con_id)
-{
-	struct clk *clk;
-
-	clk = clk_get(dev, con_id);
-	if (!IS_ERR(clk)) {
-		clk_prepare_enable(clk);
-		clk_put(clk);
-		dev_info(dev, "Runtime PM disabled, clock forced on.\n");
-	}
-}
-
-/**
- * disable_clock - Disable a device clock.
- * @dev: Device whose clock is to be disabled.
- * @con_id: Connection ID of the clock.
- */
-static void disable_clock(struct device *dev, const char *con_id)
-{
-	struct clk *clk;
-
-	clk = clk_get(dev, con_id);
-	if (!IS_ERR(clk)) {
-		clk_disable_unprepare(clk);
-		clk_put(clk);
-		dev_info(dev, "Runtime PM disabled, clock forced off.\n");
-	}
-}
-
-/**
  * pm_clk_notify - Notify routine for device addition and removal.
  * @nb: Notifier block object this function is a member of.
  * @action: Operation being carried out by the caller.
@@ -465,18 +431,45 @@ static int pm_clk_notify(struct notifier_block *nb,
 	switch (action) {
 	case BUS_NOTIFY_BIND_DRIVER:
 		if (clknb->con_ids[0]) {
-			for (con_id = clknb->con_ids; *con_id; con_id++)
-				enable_clock(dev, *con_id);
+			int i;
+			for (con_id = clknb->con_ids, i = 0; *con_id;
+						con_id++, i++) {
+				if (clknb->clks[i] == ERR_PTR(-EAGAIN))
+					clks[i] = clk_get(dev, *con_id);
+				if (!IS_ERR(clknb->clks[i])) {
+					clk_prepare_enable(clk);
+					dev_info(dev, "Runtime PM disabled, clock forced on.\n");
+				}
 		} else {
-			enable_clock(dev, NULL);
+			if (clknb->clks[0] == ERR_PTR(-EAGAIN))
+				clks[0] = clk_get(dev, NULL);
+			if (!IS_ERR(clknb->clks[0])) {
+				clk_prepare_enable(clk);
+				dev_info(dev, "Runtime PM disabled, clock forced on.\n");
+			}
 		}
 		break;
 	case BUS_NOTIFY_UNBOUND_DRIVER:
+		/*
+		 * FIXME
+		 * We never call clk_put. This should be done with
+		 * pm_clk_remove_notifier, which doesn't exist but probably
+		 * should
+		 */
 		if (clknb->con_ids[0]) {
-			for (con_id = clknb->con_ids; *con_id; con_id++)
-				disable_clock(dev, *con_id);
+			int i;
+			for (con_id = clknb->con_ids, i = 0; *con_id;
+					con_id++, i++) {
+				if (!IS_ERR(clknb->clks[i])) {
+					clk_disable_unprepare(clknb->clks[i]);
+					dev_info(dev, "Runtime PM disabled, clock forced off.\n");
+				}
+			}
 		} else {
-			disable_clock(dev, NULL);
+			if (!IS_ERR(clknb->clks[0])) {
+				clk_disable_unprepare(clknb->clks[i]);
+				dev_info(dev, "Runtime PM disabled, clock forced off.\n");
+			}
 		}
 		break;
 	}
diff --git a/drivers/sh/pm_runtime.c b/drivers/sh/pm_runtime.c
index 25abd4e..08754a4 100644
--- a/drivers/sh/pm_runtime.c
+++ b/drivers/sh/pm_runtime.c
@@ -30,6 +30,7 @@ static struct dev_pm_domain default_pm_domain = {
 static struct pm_clk_notifier_block platform_bus_notifier = {
 	.pm_domain = &default_pm_domain,
 	.con_ids = { NULL, },
+	.clks = { ERR_PTR(-EAGAIN) },
 };
 
 static int __init sh_pm_runtime_init(void)
diff --git a/include/linux/pm_clock.h b/include/linux/pm_clock.h
index 25266c6..45e58fe 100644
--- a/include/linux/pm_clock.h
+++ b/include/linux/pm_clock.h
@@ -16,6 +16,7 @@ struct pm_clk_notifier_block {
 	struct notifier_block nb;
 	struct dev_pm_domain *pm_domain;
 	char *con_ids[];
+	struct clk *clks[];
 };
 
 struct clk;
