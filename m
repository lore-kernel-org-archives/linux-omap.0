From: Anton Vorontsov <anton-9xeibp6oKSgdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/3] power_supply: add power_supply_get_by_phandle
Date: Mon, 23 Dec 2013 18:20:36 -0800
Message-ID: <20131224022035.GA25939@lizard>
References: <1385311771-447-1-git-send-email-sre@debian.org>
 <1385311771-447-2-git-send-email-sre@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1385311771-447-2-git-send-email-sre-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Cc: Sebastian Reichel <sre-GFxCN5SEZAc@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, freemangordon-uiMcrn6V0Vs@public.gmane.org, aaro.koskinen-X3B1VOXEql0@public.gmane.org, pavel-+ZI9xUNit7I@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Sun, Nov 24, 2013 at 05:49:29PM +0100, Sebastian Reichel wrote:
> Add method to get power supply by device tree phandle.
> 
> Signed-off-by: Sebastian Reichel <sre-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
> ---
>  drivers/power/power_supply_core.c | 24 ++++++++++++++++++++++++
>  include/linux/power_supply.h      |  2 ++
>  2 files changed, 26 insertions(+)
> 
> diff --git a/drivers/power/power_supply_core.c b/drivers/power/power_supply_core.c
> index 08bce22..99e4b41 100644
> --- a/drivers/power/power_supply_core.c
> +++ b/drivers/power/power_supply_core.c
> @@ -340,6 +340,30 @@ struct power_supply *power_supply_get_by_name(const char *name)
...
> +
> +	dev = class_find_device(power_supply_class, NULL, power_supply_np,
> +						power_supply_match_device_node);
> +
> +	of_node_put(power_supply_np);
> +
> +	return dev ? dev_get_drvdata(dev) : NULL;
> +}
> +EXPORT_SYMBOL_GPL(power_supply_get_by_phandle);

The code had no !CONFIG_OF protection so I had to make the following
changes to this patch:

diff --git a/drivers/power/power_supply_core.c b/drivers/power/power_supply_core.c
index 23cd055..2660664 100644
--- a/drivers/power/power_supply_core.c
+++ b/drivers/power/power_supply_core.c
@@ -341,6 +341,7 @@ struct power_supply *power_supply_get_by_name(const char *name)
 }
 EXPORT_SYMBOL_GPL(power_supply_get_by_name);
 
+#ifdef CONFIG_OF
 static int power_supply_match_device_node(struct device *dev, const void *data)
 {
 	return dev->parent && dev->parent->of_node == data;
@@ -364,6 +365,7 @@ struct power_supply *power_supply_get_by_phandle(struct device_node *np,
 	return dev ? dev_get_drvdata(dev) : NULL;
 }
 EXPORT_SYMBOL_GPL(power_supply_get_by_phandle);
+#endif /* CONFIG_OF */
 
 int power_supply_powers(struct power_supply *psy, struct device *dev)
 {
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 8d06537..c9dc4e0 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -244,8 +244,14 @@ extern struct atomic_notifier_head power_supply_notifier;
 extern int power_supply_reg_notifier(struct notifier_block *nb);
 extern void power_supply_unreg_notifier(struct notifier_block *nb);
 extern struct power_supply *power_supply_get_by_name(const char *name);
+#ifdef CONFIG_OF
 extern struct power_supply *power_supply_get_by_phandle(struct device_node *np,
 							const char *property);
+#else /* !CONFIG_OF */
+static inline struct power_supply *
+power_supply_get_by_phandle(struct device_node *np, const char *property)
+{ return NULL; }
+#endif /* CONFIG_OF */
 extern void power_supply_changed(struct power_supply *psy);
 extern int power_supply_am_i_supplied(struct power_supply *psy);
 extern int power_supply_set_battery_charged(struct power_supply *psy);
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
