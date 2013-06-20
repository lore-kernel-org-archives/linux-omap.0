From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v4] usb: dwc3: use extcon fwrk to receive
 connect/disconnect
Date: Thu, 20 Jun 2013 14:24:50 +0530
Message-ID: <51C2C35A.5030007@ti.com>
References: <1370276020-17446-6-git-send-email-kishon@ti.com>
 <1371215425-1979-1-git-send-email-kishon@ti.com>
 <51BE8C0D.9060003@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <51BE8C0D.9060003-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
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
To: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, benoit.cousson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Monday 17 June 2013 09:39 AM, Chanwoo Choi wrote:
> On 06/14/2013 10:10 PM, Kishon Vijay Abraham I wrote:
>> Modified dwc3-omap to receive connect and disconnect notification using
>> extcon framework. Also did the necessary cleanups required after
>> adapting to extcon framework.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
>> Acked-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
>> ---
>> This patch depends on
>> git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git commit:f7ae906
>>
>> It should also be applied on top of
>> usb: dwc3: omap: improve error handling of dwc3_omap_probe patch which is
>> merged in Felipe's tree.
>>
>> So I'm not sure on whose tree this patch should go in.
>>
>> Changes from v3:
>> * did #include of of_extcon.h after Chanwoo resent the patch separating
>> extcon-class.c from of_extcon.c
>> Changes from v2:
>> * updated the Documentation with dwc3 dt binding information.
>> * used of_extcon_get_extcon_dev to get extcon device from device tree data.
>> Changes from v1:
>> * regulator enable/disable is now done here instead of palmas-usb as some users
>> of palmas-usb wont need regulator.
>>
>>   Documentation/devicetree/bindings/usb/omap-usb.txt |    5 +
>>   drivers/usb/dwc3/dwc3-omap.c                       |  119 ++++++++++++++++----
>>   include/linux/usb/dwc3-omap.h                      |   30 -----
>>   3 files changed, 105 insertions(+), 49 deletions(-)
>>   delete mode 100644 include/linux/usb/dwc3-omap.h
>>
>> diff --git a/Documentation/devicetree/bindings/usb/omap-usb.txt b/Documentation/devicetree/bindings/usb/omap-usb.txt
>> index d4769f3..f1c15f3 100644
>> --- a/Documentation/devicetree/bindings/usb/omap-usb.txt
>> +++ b/Documentation/devicetree/bindings/usb/omap-usb.txt
>> @@ -53,6 +53,11 @@ OMAP DWC3 GLUE
>>      It should be set to "1" for HW mode and "2" for SW mode.
>>    - ranges: the child address space are mapped 1:1 onto the parent address space
>>
>> +Optional Properties:
>> + - extcon : phandle for the extcon device omap dwc3 uses to detect
>> +   connect/disconnect events.
>> + - vbus-supply : phandle to the regulator device tree node if needed.
>> +
>>   Sub-nodes:
>>   The dwc3 core should be added as subnode to omap dwc3 glue.
>>   - dwc3 :
>> diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap.c
>> index f8f76e6..14c1f1b 100644
>> --- a/drivers/usb/dwc3/dwc3-omap.c
>> +++ b/drivers/usb/dwc3/dwc3-omap.c
>> @@ -43,13 +43,15 @@
>>   #include <linux/spinlock.h>
>>   #include <linux/platform_device.h>
>>   #include <linux/platform_data/dwc3-omap.h>
>> -#include <linux/usb/dwc3-omap.h>
>>   #include <linux/pm_runtime.h>
>>   #include <linux/dma-mapping.h>
>>   #include <linux/ioport.h>
>>   #include <linux/io.h>
>>   #include <linux/of.h>
>>   #include <linux/of_platform.h>
>> +#include <linux/extcon.h>
>> +#include <linux/extcon/of_extcon.h>
>> +#include <linux/regulator/consumer.h>
>>
>>   #include <linux/usb/otg.h>
>>
>> @@ -124,9 +126,21 @@ struct dwc3_omap {
>>   	u32			utmi_otg_status;
>>
>>   	u32			dma_status:1;
>> +
>> +	struct extcon_specific_cable_nb extcon_vbus_dev;
>> +	struct extcon_specific_cable_nb extcon_id_dev;
>> +	struct notifier_block	vbus_nb;
>> +	struct notifier_block	id_nb;
>> +
>> +	struct regulator	*vbus_reg;
>>   };
>>
>> -static struct dwc3_omap		*_omap;
>> +enum omap_dwc3_vbus_id_status {
>> +	OMAP_DWC3_ID_FLOAT,
>> +	OMAP_DWC3_ID_GROUND,
>> +	OMAP_DWC3_VBUS_OFF,
>> +	OMAP_DWC3_VBUS_VALID,
>> +};
>>
>>   static inline u32 dwc3_omap_readl(void __iomem *base, u32 offset)
>>   {
>> @@ -138,18 +152,23 @@ static inline void dwc3_omap_writel(void __iomem *base, u32 offset, u32 value)
>>   	writel(value, base + offset);
>>   }
>>
>> -int dwc3_omap_mailbox(enum omap_dwc3_vbus_id_status status)
>> +static void dwc3_omap_set_mailbox(struct dwc3_omap *omap,
>> +	enum omap_dwc3_vbus_id_status status)
>>   {
>> -	u32			val;
>> -	struct dwc3_omap	*omap = _omap;
>> -
>> -	if (!omap)
>> -		return -EPROBE_DEFER;
>> +	int	ret;
>> +	u32	val;
>>
>>   	switch (status) {
>>   	case OMAP_DWC3_ID_GROUND:
>>   		dev_dbg(omap->dev, "ID GND\n");
>>
>> +		if (omap->vbus_reg) {
>> +			ret = regulator_enable(omap->vbus_reg);
>> +			if (ret) {
>> +				dev_dbg(omap->dev, "regulator enable failed\n");
>> +				return;
>> +			}
>> +		}
>>   		val = dwc3_omap_readl(omap->base, USBOTGSS_UTMI_OTG_STATUS);
>>   		val &= ~(USBOTGSS_UTMI_OTG_STATUS_IDDIG
>>   				| USBOTGSS_UTMI_OTG_STATUS_VBUSVALID
>> @@ -172,6 +191,9 @@ int dwc3_omap_mailbox(enum omap_dwc3_vbus_id_status status)
>>   		break;
>>
>>   	case OMAP_DWC3_ID_FLOAT:
>> +		if (omap->vbus_reg)
>> +			regulator_disable(omap->vbus_reg);
>> +
>>   	case OMAP_DWC3_VBUS_OFF:
>>   		dev_dbg(omap->dev, "VBUS Disconnect\n");
>>
>> @@ -185,12 +207,9 @@ int dwc3_omap_mailbox(enum omap_dwc3_vbus_id_status status)
>>   		break;
>>
>>   	default:
>> -		dev_dbg(omap->dev, "ID float\n");
>> +		dev_dbg(omap->dev, "invalid state\n");
>>   	}
>> -
>> -	return 0;
>>   }
>> -EXPORT_SYMBOL_GPL(dwc3_omap_mailbox);
>>
>>   static irqreturn_t dwc3_omap_interrupt(int irq, void *_omap)
>>   {
>> @@ -282,6 +301,32 @@ static void dwc3_omap_disable_irqs(struct dwc3_omap *omap)
>>
>>   static u64 dwc3_omap_dma_mask = DMA_BIT_MASK(32);
>>
>> +static int dwc3_omap_id_notifier(struct notifier_block *nb,
>> +	unsigned long event, void *ptr)
>> +{
>> +	struct dwc3_omap *omap = container_of(nb, struct dwc3_omap, id_nb);
>> +
>> +	if (event)
>> +		dwc3_omap_set_mailbox(omap, OMAP_DWC3_ID_GROUND);
>> +	else
>> +		dwc3_omap_set_mailbox(omap, OMAP_DWC3_ID_FLOAT);
>> +
>> +	return NOTIFY_DONE;
>> +}
>> +
>> +static int dwc3_omap_vbus_notifier(struct notifier_block *nb,
>> +	unsigned long event, void *ptr)
>> +{
>> +	struct dwc3_omap *omap = container_of(nb, struct dwc3_omap, vbus_nb);
>> +
>> +	if (event)
>> +		dwc3_omap_set_mailbox(omap, OMAP_DWC3_VBUS_VALID);
>> +	else
>> +		dwc3_omap_set_mailbox(omap, OMAP_DWC3_VBUS_OFF);
>> +
>> +	return NOTIFY_DONE;
>> +}
>> +
>>   static int dwc3_omap_probe(struct platform_device *pdev)
>>   {
>>   	struct device_node	*node = pdev->dev.of_node;
>> @@ -289,6 +334,8 @@ static int dwc3_omap_probe(struct platform_device *pdev)
>>   	struct dwc3_omap	*omap;
>>   	struct resource		*res;
>>   	struct device		*dev = &pdev->dev;
>> +	struct extcon_dev	*edev;
>> +	struct regulator	*vbus_reg = NULL;
>>
>>   	int			ret = -ENOMEM;
>>   	int			irq;
>> @@ -330,19 +377,22 @@ static int dwc3_omap_probe(struct platform_device *pdev)
>>   		return -ENOMEM;
>>   	}
>>
>> +	if (of_property_read_bool(node, "vbus-supply")) {
>> +		vbus_reg = devm_regulator_get(dev, "vbus");
>> +		if (IS_ERR(vbus_reg)) {
>> +			dev_err(dev, "vbus init failed\n");
>> +			return PTR_ERR(vbus_reg);
>> +		}
>> +	}
>> +
>>   	spin_lock_init(&omap->lock);
>>
>>   	omap->dev	= dev;
>>   	omap->irq	= irq;
>>   	omap->base	= base;
>> +	omap->vbus_reg	= vbus_reg;
>>   	dev->dma_mask	= &dwc3_omap_dma_mask;
>>
>> -	/*
>> -	 * REVISIT if we ever have two instances of the wrapper, we will be
>> -	 * in big trouble
>> -	 */
>> -	_omap	= omap;
>> -
>>   	pm_runtime_enable(dev);
>>   	ret = pm_runtime_get_sync(dev);
>>   	if (ret < 0) {
>> @@ -381,14 +431,41 @@ static int dwc3_omap_probe(struct platform_device *pdev)
>>
>>   	dwc3_omap_enable_irqs(omap);
>>
>> +	if (of_property_read_bool(node, "extcon")) {
>> +		edev = of_extcon_get_extcon_dev(dev, 0);
>> +		if (IS_ERR(edev)) {
>> +			dev_vdbg(dev, "couldn't get extcon device\n");
>> +			ret = PTR_ERR(edev);
>> +			goto err2;
>> +		}
>> +
>> +		omap->vbus_nb.notifier_call = dwc3_omap_vbus_notifier;
>> +		extcon_register_interest(&omap->extcon_vbus_dev, edev->name,
>> +					 "USB", &omap->vbus_nb);
>> +		omap->id_nb.notifier_call = dwc3_omap_id_notifier;
>> +		extcon_register_interest(&omap->extcon_id_dev, edev->name,
>> +					 "USB-HOST", &omap->id_nb);
>
> I prefer adding exception handling code about return value of extcon_register_interest().
>
>> +
>> +		if (extcon_get_cable_state(edev, "USB") == true)
>> +			dwc3_omap_set_mailbox(omap, OMAP_DWC3_VBUS_VALID);
>> +		if (extcon_get_cable_state(edev, "USB-HOST") == true)
>> +			dwc3_omap_set_mailbox(omap, OMAP_DWC3_ID_GROUND);
>> +	}
>> +
>>   	ret = of_platform_populate(node, NULL, NULL, dev);
>>   	if (ret) {
>>   		dev_err(&pdev->dev, "failed to create dwc3 core\n");
>> -		goto err2;
>> +		goto err3;
>>   	}
>>
>>   	return 0;
>>
>> +err3:
>> +	if (omap->extcon_vbus_dev.edev)
>> +		extcon_unregister_interest(&omap->extcon_vbus_dev);
>> +	if (omap->extcon_id_dev.edev)
>> +		extcon_unregister_interest(&omap->extcon_id_dev);
>> +
>>   err2:
>>   	dwc3_omap_disable_irqs(omap);
>>
>> @@ -405,6 +482,10 @@ static int dwc3_omap_remove(struct platform_device *pdev)
>>   {
>>   	struct dwc3_omap	*omap = platform_get_drvdata(pdev);
>>
>> +	if (omap->extcon_vbus_dev.edev)
>> +		extcon_unregister_interest(&omap->extcon_vbus_dev);
>> +	if (omap->extcon_id_dev.edev)
>> +		extcon_unregister_interest(&omap->extcon_id_dev);
>>   	dwc3_omap_disable_irqs(omap);
>>   	pm_runtime_put_sync(&pdev->dev);
>>   	pm_runtime_disable(&pdev->dev);
>> diff --git a/include/linux/usb/dwc3-omap.h b/include/linux/usb/dwc3-omap.h
>> deleted file mode 100644
>> index 5615f4d..0000000
>>
>
> It looks good if you add exception handler about return value of extcon_register_interest().

Ok. I'll fix exception handler and also add depend on of EXTCON here.

Thanks
Kishon
