From: Ladislav Michl <ladis@linux-mips.org>
Subject: Re: [PATCH 3/3] clocksource: timer-dm: Make unexported functions
 static
Date: Mon, 22 Jan 2018 11:39:37 +0100
Message-ID: <20180122103936.GB19401@lenoch>
References: <20180117214629.GA11952@lenoch>
 <20180117214826.GD11952@lenoch>
 <755fca20-7544-1655-47c7-83b1a2669adc@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <755fca20-7544-1655-47c7-83b1a2669adc@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Claudiu Beznea <Claudiu.Beznea@microchip.com>
Cc: linux-omap@vger.kernel.org, linux-pwm@vger.kernel.org, Keerthy <j-keerthy@ti.com>, daniel.lezcano@linaro.org, thierry.reding@gmail.com, tony@atomide.com, aaro.koskinen@iki.fi, narmstrong@baylibre.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, sebastian.reichel@collabora.co.uk, robh+dt@kernel.org, t-kristo@ti.com, grygorii.strashko@ti.com
List-Id: linux-omap@vger.kernel.org

On Mon, Jan 22, 2018 at 11:26:44AM +0200, Claudiu Beznea wrote:
> On 17.01.2018 23:48, Ladislav Michl wrote:
> > As dmtimer no longer exports functions, make those previously
> > exported static.
> > 
> > Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
> > ---
> >  Note: only those functions assigned to timer ops are made static
> >        as some others will be needed later for event capture.
> > 
> >  drivers/clocksource/timer-dm.c |  218 ++++++++++++++++++++---------------------
> >  include/clocksource/dmtimer.h  |   24 ----
> >  2 files changed, 109 insertions(+), 133 deletions(-)
> > 
> > diff --git a/drivers/clocksource/timer-dm.c b/drivers/clocksource/timer-dm.c
> > index 324ec93d3dd2..8de9e543d129 100644
> > --- a/drivers/clocksource/timer-dm.c
> > +++ b/drivers/clocksource/timer-dm.c
> > @@ -163,6 +163,92 @@ static int omap_dm_timer_of_set_source(struct omap_dm_timer *timer)
> >  	return ret;
> >  }
> >  
> > +static int omap_dm_timer_set_source(struct omap_dm_timer *timer, int source)
> > +{
> > +	int ret;
> > +	char *parent_name = NULL;
> Could be declared as const: const char *parent_name = NULL;
> 
> > +	struct clk *parent;
> > +	struct dmtimer_platform_data *pdata;
> > +
> > +	if (unlikely(!timer))
> > +		return -EINVAL;
> > +
> > +	pdata = timer->pdev->dev.platform_data;
> > +
> > +	if (source < 0 || source >= 3)
> > +		return -EINVAL;
> > +
> > +	/*
> > +	 * FIXME: Used for OMAP1 devices only because they do not currently
> > +	 * use the clock framework to set the parent clock. To be removed
> > +	 * once OMAP1 migrated to using clock framework for dmtimers
> > +	 */
> > +	if (pdata && pdata->set_timer_src)
> > +		return pdata->set_timer_src(timer->pdev, source);
> > +
> > +	if (IS_ERR(timer->fclk))
> > +		return -EINVAL;
> Souldn't this check be done at the beginning of the function?

Well, this patch only moves existing functions around, just to make it
compile after declarations are removed from header file.

Fixes should be sent separately as this is not the only problem with
clocksource code :)

Anyway, thank you for review, this one could be addressed by a following
patch:

diff --git a/drivers/clocksource/timer-dm.c b/drivers/clocksource/timer-dm.c
index dbf2b1f6a941..02b3436db70e 100644
--- a/drivers/clocksource/timer-dm.c
+++ b/drivers/clocksource/timer-dm.c
@@ -166,17 +166,30 @@ static int omap_dm_timer_of_set_source(struct omap_dm_timer *timer)
 static int omap_dm_timer_set_source(struct omap_dm_timer *timer, int source)
 {
 	int ret;
-	char *parent_name = NULL;
+	const char *parent_name;
 	struct clk *parent;
 	struct dmtimer_platform_data *pdata;
 
-	if (unlikely(!timer))
+	if (unlikely(!timer) || IS_ERR(timer->fclk))
 		return -EINVAL;
 
-	pdata = timer->pdev->dev.platform_data;
+	switch (source) {
+	case OMAP_TIMER_SRC_SYS_CLK:
+		parent_name = "timer_sys_ck";
+		break;
 
-	if (source < 0 || source >= 3)
+	case OMAP_TIMER_SRC_32_KHZ:
+		parent_name = "timer_32k_ck";
+		break;
+
+	case OMAP_TIMER_SRC_EXT_CLK:
+		parent_name = "timer_ext_ck";
+		break;
+	default:
 		return -EINVAL;
+	}
+
+	pdata = timer->pdev->dev.platform_data;
 
 	/*
 	 * FIXME: Used for OMAP1 devices only because they do not currently
@@ -186,29 +199,12 @@ static int omap_dm_timer_set_source(struct omap_dm_timer *timer, int source)
 	if (pdata && pdata->set_timer_src)
 		return pdata->set_timer_src(timer->pdev, source);
 
-	if (IS_ERR(timer->fclk))
-		return -EINVAL;
-
 #if defined(CONFIG_COMMON_CLK)
 	/* Check if the clock has configurable parents */
 	if (clk_hw_get_num_parents(__clk_get_hw(timer->fclk)) < 2)
 		return 0;
 #endif
 
-	switch (source) {
-	case OMAP_TIMER_SRC_SYS_CLK:
-		parent_name = "timer_sys_ck";
-		break;
-
-	case OMAP_TIMER_SRC_32_KHZ:
-		parent_name = "timer_32k_ck";
-		break;
-
-	case OMAP_TIMER_SRC_EXT_CLK:
-		parent_name = "timer_ext_ck";
-		break;
-	}
-
 	parent = clk_get(&timer->pdev->dev, parent_name);
 	if (IS_ERR(parent)) {
 		pr_err("%s: %s not found\n", __func__, parent_name);
