From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 02/15] usb: phy: omap-usb2: use the new generic PHY
 framework
Date: Thu, 18 Jul 2013 14:30:58 +0530
Message-ID: <51E7AECA.1000204@ti.com>
References: <1374129984-765-1-git-send-email-kishon@ti.com>
 <1374129984-765-3-git-send-email-kishon@ti.com>
 <20130718072149.GB16720@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20130718072149.GB16720-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, george.cherian-l0cyMroinI0@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, balajitk-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thursday 18 July 2013 12:51 PM, Greg KH wrote:
> On Thu, Jul 18, 2013 at 12:16:11PM +0530, Kishon Vijay Abraham I wrote:
>> Used the generic PHY framework API to create the PHY. Now the power off and
>> power on are done in omap_usb_power_off and omap_usb_power_on respectively.
>>
>> However using the old USB PHY library cannot be completely removed
>> because OTG is intertwined with PHY and moving to the new framework
>> will break OTG. Once we have a separate OTG state machine, we
>> can get rid of the USB PHY library.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
>> Reviewed-by: Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>> Acked-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
>> ---
>>  drivers/usb/phy/Kconfig         |    1 +
>>  drivers/usb/phy/phy-omap-usb2.c |   45 +++++++++++++++++++++++++++++++++++----
>>  2 files changed, 42 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/usb/phy/Kconfig b/drivers/usb/phy/Kconfig
>> index 3622fff..cc55993 100644
>> --- a/drivers/usb/phy/Kconfig
>> +++ b/drivers/usb/phy/Kconfig
>> @@ -75,6 +75,7 @@ config OMAP_CONTROL_USB
>>  config OMAP_USB2
>>  	tristate "OMAP USB2 PHY Driver"
>>  	depends on ARCH_OMAP2PLUS
>> +	depends on GENERIC_PHY
>>  	select OMAP_CONTROL_USB
>>  	help
>>  	  Enable this to support the transceiver that is part of SOC. This
>> diff --git a/drivers/usb/phy/phy-omap-usb2.c b/drivers/usb/phy/phy-omap-usb2.c
>> index 844ab68..751b30f 100644
>> --- a/drivers/usb/phy/phy-omap-usb2.c
>> +++ b/drivers/usb/phy/phy-omap-usb2.c
>> @@ -28,6 +28,7 @@
>>  #include <linux/pm_runtime.h>
>>  #include <linux/delay.h>
>>  #include <linux/usb/omap_control_usb.h>
>> +#include <linux/phy/phy.h>
>>  
>>  /**
>>   * omap_usb2_set_comparator - links the comparator present in the sytem with
>> @@ -119,10 +120,36 @@ static int omap_usb2_suspend(struct usb_phy *x, int suspend)
>>  	return 0;
>>  }
>>  
>> +static int omap_usb_power_off(struct phy *x)
>> +{
>> +	struct omap_usb *phy = phy_get_drvdata(x);
>> +
>> +	omap_control_usb_phy_power(phy->control_dev, 0);
>> +
>> +	return 0;
>> +}
>> +
>> +static int omap_usb_power_on(struct phy *x)
>> +{
>> +	struct omap_usb *phy = phy_get_drvdata(x);
>> +
>> +	omap_control_usb_phy_power(phy->control_dev, 1);
>> +
>> +	return 0;
>> +}
>> +
>> +static struct phy_ops ops = {
>> +	.power_on	= omap_usb_power_on,
>> +	.power_off	= omap_usb_power_off,
>> +	.owner		= THIS_MODULE,
>> +};
>> +
>>  static int omap_usb2_probe(struct platform_device *pdev)
>>  {
>>  	struct omap_usb			*phy;
>> +	struct phy			*generic_phy;
>>  	struct usb_otg			*otg;
>> +	struct phy_provider		*phy_provider;
>>  
>>  	phy = devm_kzalloc(&pdev->dev, sizeof(*phy), GFP_KERNEL);
>>  	if (!phy) {
>> @@ -144,6 +171,11 @@ static int omap_usb2_probe(struct platform_device *pdev)
>>  	phy->phy.otg		= otg;
>>  	phy->phy.type		= USB_PHY_TYPE_USB2;
>>  
>> +	phy_provider = devm_of_phy_provider_register(phy->dev,
>> +			of_phy_simple_xlate);
>> +	if (IS_ERR(phy_provider))
>> +		return PTR_ERR(phy_provider);
>> +
>>  	phy->control_dev = omap_get_control_dev();
>>  	if (IS_ERR(phy->control_dev)) {
>>  		dev_dbg(&pdev->dev, "Failed to get control device\n");
>> @@ -159,6 +191,15 @@ static int omap_usb2_probe(struct platform_device *pdev)
>>  	otg->start_srp		= omap_usb_start_srp;
>>  	otg->phy		= &phy->phy;
>>  
>> +	platform_set_drvdata(pdev, phy);
>> +	pm_runtime_enable(phy->dev);
>> +
>> +	generic_phy = devm_phy_create(phy->dev, 0, &ops, "omap-usb2");
>> +	if (IS_ERR(generic_phy))
>> +		return PTR_ERR(generic_phy);
> 
> So, if I have two of these controllers in my system, I can't create the
> second phy because the name for it will be identical to the first?
> That's why the phy core should handle the id, and not rely on the
> drivers to set it, as they have no idea how many they have in the
> system.

hmm.. for such cases I'll have something like PLATFORM_DEVID_AUTO.

Thanks
Kishon
