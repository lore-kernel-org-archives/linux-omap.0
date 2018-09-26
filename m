From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/4] Update am437x and am335x dts to probe with ti-sysc
Date: Wed, 26 Sep 2018 09:23:03 -0700
Message-ID: <20180926162303.GU5662@atomide.com>
References: <20180925000545.22931-1-tony@atomide.com>
 <e9afe736-c2f0-6182-afd0-08279e09a35e@ti.com>
 <20180925144021.GN5662@atomide.com>
 <20180925175537.GQ5662@atomide.com>
 <d98aa7c1-5131-34c5-51e5-c7ef57cbc31e@ti.com>
 <20180926155911.GT5662@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20180926155911.GT5662@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Keerthy <j-keerthy@ti.com>
Cc: devicetree@vger.kernel.org, Dave Gerlach <d-gerlach@ti.com>, Tero Kristo <t-kristo@ti.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [180926 16:04]:
> * Keerthy <j-keerthy@ti.com> [180926 04:12]:
> > So the below patch is solving the problem only for the first iteration
> > but i see the problem recurring from second iteration of suspend.
> > 
> > I tried the above cycle multiple times on am437x-gp-evm. I believe
> > we are one step closer still not completely fixed.
> 
> OK thanks, that's interesting, I'll take a look. Good to hear
> that is the reason for pixcir issues though :)

Heh ooops the previous i2c-omap patch I posted does unpaired
runtime_pm calls.. The put must be left out omap_i2c_resume().

Below is a better patch, seems to work for me multiple times
now.

Regards,

Tony

8< ---------------------------
diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -208,6 +208,8 @@ struct omap_i2c_dev {
 						 * if set, should be trsh+1
 						 */
 	u32			rev;
+	unsigned int		is_suspended:1;
+	unsigned int		needs_resume:1;
 	unsigned		b_hw:1;		/* bad h/w fixes */
 	unsigned		bb_valid:1;	/* true when BB-bit reflects
 						 * the I2C bus state
@@ -1498,8 +1500,7 @@ static int omap_i2c_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
-static int omap_i2c_runtime_suspend(struct device *dev)
+static int __maybe_unused omap_i2c_runtime_suspend(struct device *dev)
 {
 	struct omap_i2c_dev *omap = dev_get_drvdata(dev);
 
@@ -1521,11 +1522,12 @@ static int omap_i2c_runtime_suspend(struct device *dev)
 	}
 
 	pinctrl_pm_select_sleep_state(dev);
+	omap->is_suspended = true;
 
 	return 0;
 }
 
-static int omap_i2c_runtime_resume(struct device *dev)
+static int __maybe_unused omap_i2c_runtime_resume(struct device *dev)
 {
 	struct omap_i2c_dev *omap = dev_get_drvdata(dev);
 
@@ -1535,6 +1537,51 @@ static int omap_i2c_runtime_resume(struct device *dev)
 		return 0;
 
 	__omap_i2c_init(omap);
+	omap->is_suspended = false;
+
+	return 0;
+}
+
+static int __maybe_unused omap_i2c_suspend(struct device *dev)
+{
+	struct omap_i2c_dev *ddata = dev_get_drvdata(dev);
+	int error;
+
+	/* Is device still enabled because of autosuspend? */
+	if (ddata->is_suspended)
+		return 0;
+
+	/* Paired with call in omap_i2c_resume() */
+	error = pm_runtime_put_sync_suspend(dev);
+	if (error < 0) {
+		dev_err(dev, "%s failed: %i\n", __func__, error);
+
+		return error;
+	}
+
+	ddata->needs_resume = true;
+
+	return 0;
+}
+
+static int __maybe_unused omap_i2c_resume(struct device *dev)
+{
+	struct omap_i2c_dev *ddata = dev_get_drvdata(dev);
+	int error;
+
+	if (!ddata->needs_resume)
+		return 0;
+
+	/* Paired with call in omap_i2c_suspend() */
+	error = pm_runtime_get_sync(dev);
+	if (error < 0) {
+		dev_err(dev, "%s failed: %i\n", __func__, error);
+		pm_runtime_put_noidle(dev);
+
+		return error;
+	}
+
+	ddata->needs_resume = false;
 
 	return 0;
 }
@@ -1542,18 +1589,15 @@ static int omap_i2c_runtime_resume(struct device *dev)
 static const struct dev_pm_ops omap_i2c_pm_ops = {
 	SET_RUNTIME_PM_OPS(omap_i2c_runtime_suspend,
 			   omap_i2c_runtime_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(omap_i2c_suspend, omap_i2c_resume)
 };
-#define OMAP_I2C_PM_OPS (&omap_i2c_pm_ops)
-#else
-#define OMAP_I2C_PM_OPS NULL
-#endif /* CONFIG_PM */
 
 static struct platform_driver omap_i2c_driver = {
 	.probe		= omap_i2c_probe,
 	.remove		= omap_i2c_remove,
 	.driver		= {
 		.name	= "omap_i2c",
-		.pm	= OMAP_I2C_PM_OPS,
+		.pm	= &omap_i2c_pm_ops,
 		.of_match_table = of_match_ptr(omap_i2c_of_match),
 	},
 };
-- 
2.19.0
