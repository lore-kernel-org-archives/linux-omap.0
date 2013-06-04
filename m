From: Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v6 1/9] drivers: phy: add generic PHY framework
Date: Tue, 04 Jun 2013 12:21:15 +0200
Message-ID: <51ADBF9B.5060403@samsung.com>
References: <1367229812-30574-1-git-send-email-kishon@ti.com>
 <1367229812-30574-2-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <1367229812-30574-2-git-send-email-kishon-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Cc: grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, benoit.cousson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, mchehab-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, cesarb-PWySMVKUnqmsTnJN9+BGXg@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, santosh.shilimkar-l0cyMroinI0@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 04/29/2013 12:03 PM, Kishon Vijay Abraham I wrote:
> The PHY framework provides a set of APIs for the PHY drivers to
> create/destroy a PHY and APIs for the PHY users to obtain a reference to the
> PHY with or without using phandle. For dt-boot, the PHY drivers should
> also register *PHY provider* with the framework.
> 
> PHY drivers should create the PHY by passing id and ops like init, exit,
> power_on and power_off. This framework is also pm runtime enabled.
> 
> The documentation for the generic PHY framework is added in
> Documentation/phy.txt and the documentation for dt binding can be found at
> Documentation/devicetree/bindings/phy/phy-bindings.txt
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
> ---
>  .../devicetree/bindings/phy/phy-bindings.txt       |   66 +++
>  Documentation/phy.txt                              |  123 +++++
>  MAINTAINERS                                        |    7 +
>  drivers/Kconfig                                    |    2 +
>  drivers/Makefile                                   |    2 +
>  drivers/phy/Kconfig                                |   13 +
>  drivers/phy/Makefile                               |    5 +
>  drivers/phy/phy-core.c                             |  539 ++++++++++++++++++++
>  include/linux/phy/phy.h                            |  248 +++++++++
>  9 files changed, 1005 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-bindings.txt
>  create mode 100644 Documentation/phy.txt
>  create mode 100644 drivers/phy/Kconfig
>  create mode 100644 drivers/phy/Makefile
>  create mode 100644 drivers/phy/phy-core.c
>  create mode 100644 include/linux/phy/phy.h
 
> +static inline int phy_init(struct phy *phy)
> +{
> +	pm_runtime_get_sync(&phy->dev);

Hmm, no need to check return value here ? Also it looks a bit unexpected to 
possibly have runtime_resume callback of a PHY device called before ops->init()
call ? It seems a bit unclear what the purpose of init() callback is.

> +	if (phy->ops->init)
> +		return phy->ops->init(phy);
> +
> +	return -EINVAL;
> +}
> +
> +static inline int phy_exit(struct phy *phy)
> +{
> +	int ret = -EINVAL;
> +
> +	if (phy->ops->exit)
> +		ret = phy->ops->exit(phy);
> +
> +	pm_runtime_put_sync(&phy->dev);
> +
> +	return ret;
> +}

Do phy_init/phy_exit need to be mandatory ? What if there is really 
nothing to do in those callbacks ? Perhaps -ENOIOCTLCMD should be 
returned if a callback is not implemented, so PHY users can recognize 
such situation and proceed ?

> +static inline int phy_power_on(struct phy *phy)
> +{
> +	if (phy->ops->power_on)
> +		return phy->ops->power_on(phy);
> +
> +	return -EINVAL;
> +}
> +
> +static inline int phy_power_off(struct phy *phy)
> +{
> +	if (phy->ops->power_off)
> +		return phy->ops->power_off(phy);
> +
> +	return -EINVAL;
> +}
> +
> +static inline int phy_pm_runtime_get(struct phy *phy)
> +{
> +	if (WARN(IS_ERR(phy), "Invalid PHY reference\n"))
> +		return -EINVAL;
> +
> +	return pm_runtime_get(&phy->dev);
> +}
> +
> +static inline int phy_pm_runtime_get_sync(struct phy *phy)
> +{
> +	if (WARN(IS_ERR(phy), "Invalid PHY reference\n"))
> +		return -EINVAL;
> +
> +	return pm_runtime_get_sync(&phy->dev);
> +}
> +
> +static inline int phy_pm_runtime_put(struct phy *phy)
> +{
> +	if (WARN(IS_ERR(phy), "Invalid PHY reference\n"))
> +		return -EINVAL;
> +
> +	return pm_runtime_put(&phy->dev);
> +}
> +
> +static inline int phy_pm_runtime_put_sync(struct phy *phy)
> +{
> +	if (WARN(IS_ERR(phy), "Invalid PHY reference\n"))
> +		return -EINVAL;
> +
> +	return pm_runtime_put_sync(&phy->dev);
> +}
> +
> +static inline void phy_pm_runtime_allow(struct phy *phy)
> +{
> +	if (WARN(IS_ERR(phy), "Invalid PHY reference\n"))
> +		return;
> +
> +	pm_runtime_allow(&phy->dev);
> +}
> +
> +static inline void phy_pm_runtime_forbid(struct phy *phy)
> +{
> +	if (WARN(IS_ERR(phy), "Invalid PHY reference\n"))
> +		return;
> +
> +	pm_runtime_forbid(&phy->dev);
> +}

Do we need to have all these runtime PM wrappers ? I guess you 
intended to avoid referencing phy->dev from the PHY consumers ?


Thanks,
Sylwester
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
