From: Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v1 01/11] drivers: usb: otg: add a new driver for omap
 usb2 phy
Date: Tue, 10 Jul 2012 12:19:04 +0530
Message-ID: <4FFBD060.5010903@ti.com>
References: <1340884267-28908-1-git-send-email-kishon@ti.com>	<1340884267-28908-2-git-send-email-kishon@ti.com>	<4FFBC1D0.5030506@ti.com>
 <CAAe_U6L9qiBMXWeS2POeBod8uASCtmqDc4DigwBx1bJ-hhaNRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <CAAe_U6L9qiBMXWeS2POeBod8uASCtmqDc4DigwBx1bJ-hhaNRQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: "ABRAHAM, KISHON VIJAY" <kishon-l0cyMroinI0@public.gmane.org>
Cc: linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

>>
>>> +
>>> +static int __devinit omap_usb2_probe(struct platform_device *pdev)
>>> +{
>>> +       struct omap_usb                 *phy;
>>> +       struct usb_otg                  *otg;
>>> +       struct resource                 *res;
>>> +
>>> +       phy = devm_kzalloc(&pdev->dev, sizeof(*phy), GFP_KERNEL);
>>> +       if (!phy) {
>>> +               dev_err(&pdev->dev, "unable to allocate memory for USB2
>>> PHY\n");
>>> +               return -ENOMEM;
>>> +       }
>>> +
>>> +       otg = devm_kzalloc(&pdev->dev, sizeof(*otg), GFP_KERNEL);
>>> +       if (!otg) {
>>> +               dev_err(&pdev->dev, "unable to allocate memory for USB
>>> OTG\n");
>>> +               return -ENOMEM;
>>> +       }
>>> +
>>> +       phy->dev                =&pdev->dev;
>>>
>>> +
>>> +       phy->phy.dev            = phy->dev;
>>> +       phy->phy.label          = "omap-usb2";
>>> +       phy->phy.set_suspend    = omap_usb2_suspend;
>>> +       phy->phy.otg            = otg;
>>> +
>>> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
>>> +
>>> +       phy->control_dev_conf = devm_request_and_ioremap(&pdev->dev, res);
>>> +       if (phy->control_dev_conf == NULL) {
>>> +               dev_err(&pdev->dev, "Failed to obtain io memory\n");
>>> +               return -ENXIO;
>>> +       }
>>> +
>>> +       phy->is_suspended       = 1;
>>> +       omap_usb_phy_power(phy, 0);
>>> +
>>> +       otg->set_host           = omap_usb_set_host;
>>> +       otg->set_peripheral     = omap_usb_set_peripheral;
>>> +       otg->set_vbus           = omap_usb_set_vbus;
>>> +       otg->start_srp          = omap_usb_start_srp;
>>> +       otg->phy                =&phy->phy;
>>>
>>> +
>>> +       phy->wkupclk = devm_clk_get(phy->dev, "usb_phy_cm_clk32k");
>>
>>
>> Why not just use clk_get()? What does devm_clk_get() do?
> It just associates the clk with the device. So whenever the the driver
> gets detached, the devres will take care to do a clk_put() of the
> clock.

ok, makes sense.

>>
>>
>>> +       if (IS_ERR(phy->wkupclk)) {
>>> +               dev_err(&pdev->dev, "unable to get usb_phy_cm_clk32k\n");
>>> +               return PTR_ERR(phy->wkupclk);
>>> +       }
>>> +       clk_prepare(phy->wkupclk);
>>
>>
>> Ideally clk_prepare() is an extension of clk_enable() and is expected
>> to be used that way. Not to be clubbed with clk_get(). Same with
>> clk_unprepare(). Do you do a clk_enable()/_disable() in interrupt/
>> atomic context?
>
> Currently it is called from a work queue. But Felipe wanted to remove
> those work_queue from omap2430 glue. Then this would be called from
> atomic context.
> A query for you here. If pm_runtime_get_sync() is called in interrupt
> context, will runtime resume of that device will also be called in the
> same context?

Yes, it would. You also need to then tell the runtime pm framework about
it by calling a pm_runtime_irq_safe() api I guess.

regards,
Rajendra

>
>>
>>
>>> +
>>> +       usb_add_phy(&phy->phy, USB_PHY_TYPE_USB2);
>>> +
>>> +       platform_set_drvdata(pdev, phy);
>>> +
>>> +       pm_runtime_enable(phy->dev);
>>> +
>>> +       return 0;
>>> +}
>>> +
>>> +static int __devexit omap_usb2_remove(struct platform_device *pdev)
>>> +{
>>> +       struct omap_usb *phy = platform_get_drvdata(pdev);
>>> +
>>> +       clk_unprepare(phy->wkupclk);
>>> +       usb_remove_phy(&phy->phy);
>>> +       platform_set_drvdata(pdev, NULL);
>>> +
>>> +       return 0;
>>> +}
>>> +
>>> +#ifdef CONFIG_PM
>>> +
>>> +static int omap_usb2_runtime_suspend(struct device *dev)
>>> +{
>>> +       struct platform_device  *pdev = to_platform_device(dev);
>>> +       struct omap_usb *phy = platform_get_drvdata(pdev);
>>> +
>>> +       clk_disable(phy->wkupclk);
>>> +
>>> +       return 0;
>>> +}
>>> +
>>> +static int omap_usb2_runtime_resume(struct device *dev)
>>> +{
>>> +       struct platform_device  *pdev = to_platform_device(dev);
>>> +       struct omap_usb *phy = platform_get_drvdata(pdev);
>>> +
>>> +       clk_enable(phy->wkupclk);
>>> +
>>> +       return 0;
>>> +}
>>> +
>>> +static const struct dev_pm_ops omap_usb2_pm_ops = {
>>> +       SET_RUNTIME_PM_OPS(omap_usb2_runtime_suspend,
>>> omap_usb2_runtime_resume,
>>> +               NULL)
>>> +};
>>> +
>>> +#define DEV_PM_OPS     (&omap_usb2_pm_ops)
>>> +#else
>>> +#define DEV_PM_OPS     NULL
>>> +#endif
>>> +
>>> +#ifdef CONFIG_OF
>>> +static const struct of_device_id omap_usb2_id_table[] = {
>>> +       { .compatible = "ti,omap-usb2" },
>>> +       {}
>>> +};
>>> +MODULE_DEVICE_TABLE(of, omap_usb2_id_table);
>>> +#else
>>> +#define omap_usb2_id_table NULL;
>>> +#endif
>>> +
>>> +static struct platform_driver omap_usb2_driver = {
>>> +       .probe          = omap_usb2_probe,
>>> +       .remove         = __devexit_p(omap_usb2_remove),
>>> +       .driver         = {
>>> +               .name   = "omap-usb2",
>>> +               .owner  = THIS_MODULE,
>>> +               .pm     = DEV_PM_OPS,
>>> +               .of_match_table = omap_usb2_id_table,
>>
>>
>> Use of_match_ptr() instead.
>
> Ok. And I'll remove #define omap_usb2_id_table NULL;.
>
> Thanks
> Kishon
