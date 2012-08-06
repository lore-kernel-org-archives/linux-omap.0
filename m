From: "ABRAHAM, KISHON VIJAY" <kishon-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v6 01/11] drivers: usb: otg: add a new driver for omap
 usb2 phy
Date: Mon, 6 Aug 2012 15:14:42 +0530
Message-ID: <CAAe_U6LhfrRk7PP-Td7BTXPngo7+chvTp4LwwKR_GbsjE4jNJQ@mail.gmail.com>
References: <1343639400-28725-1-git-send-email-kishon@ti.com>
 <1343639400-28725-2-git-send-email-kishon@ti.com>
 <20120803132708.GC8269@arwen.pp.htv.fi>
 <CAAe_U6K15Nm5aNs2Vn71G7ELZWka1zB2E3VGZWTc0VjyViJ6Yw@mail.gmail.com>
 <20120806084928.GD17551@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20120806084928.GD17551-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
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
To: balbi-l0cyMroinI0@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Felipe,

On Mon, Aug 6, 2012 at 2:19 PM, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> wrote:
> Hi,
>
> On Fri, Aug 03, 2012 at 08:01:44PM +0530, ABRAHAM, KISHON VIJAY wrote:
>> >> +     return 0;
>> >> +}
>> >> +
>> >> +#ifdef CONFIG_PM_RUNTIME
>> >> +
>> >> +static int omap_usb2_runtime_suspend(struct device *dev)
>> >> +{
>> >> +     struct platform_device  *pdev = to_platform_device(dev);
>> >> +     struct omap_usb *phy = platform_get_drvdata(pdev);
>> >> +
>> >> +     clk_disable(phy->wkupclk);
>> >
>> > weird. I would expect the wakeup clock to be enabled on suspend and
>> > disabled on resume. Isn't this causing any unbalanced disable warnings ?
>>
>> Even I was expecting the wakeup clock to be enabled on suspend but if
>> we have this enabled coreaon domain is never
>> gated and core does not hit low power state. btw Why do think this is
>> unbalanced?
>
> because you never do a clk_enable() on probe(), so on your first
> suspend, you will disable the clock without having enabled it before,
> no? Unless pm_runtime forces a runtime_resume() when you call
> pm_runtime_enable()...
>
>> >> +static int omap_usb2_runtime_resume(struct device *dev)
>> >> +{
>> >> +     u32 ret = 0;
>> >> +     struct platform_device  *pdev = to_platform_device(dev);
>> >> +     struct omap_usb *phy = platform_get_drvdata(pdev);
>> >> +
>> >> +     ret = clk_enable(phy->wkupclk);
>> >> +     if (ret < 0)
>> >> +             dev_err(phy->dev, "Failed to enable wkupclk %d\n", ret);
>> >> +
>> >> +     return ret;
>> >> +}
>> >> +
>> >> +static const struct dev_pm_ops omap_usb2_pm_ops = {
>> >> +     SET_RUNTIME_PM_OPS(omap_usb2_runtime_suspend, omap_usb2_runtime_resume,
>> >> +             NULL)
>> >
>> > only runtime ? What about static suspend ? We need this to work also
>> > after a traditional echo mem > /sys/power/state ;-)
>>
>> The static suspend case is handled by users of this phy using
>> set_suspend hooks.
>
> I'm not sure if that's too wise, what if your user enabled USB, but
> for whatever reason loaded only the phy driver and not musb or dwc3. It
> will fail, right ?

The enabling and disabling of phy is solely governed by usb controller
driver (musb/dwc3). So if you dont have musb/dwc3 loaded, the phy will
be for sure disabled.

Thanks
Kishon
