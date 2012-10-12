From: Vikas Sajjan <vikas.sajjan@linaro.org>
Subject: Re: [PATCH 1/3] usb: dwc3: Add the suspend/resume functionality
Date: Fri, 12 Oct 2012 19:24:33 +0530
Message-ID: <CAD025yRKnLWKzVGneMnudSKHasWw-2Qe8b40VpiFJev=zPiVdw@mail.gmail.com>
References: <1349877949-18872-1-git-send-email-vikas.sajjan@linaro.org>
	<1349877949-18872-2-git-send-email-vikas.sajjan@linaro.org>
	<5077F7B5.9000509@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:37612 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932808Ab2JLNye (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Oct 2012 09:54:34 -0400
Received: by mail-gg0-f174.google.com with SMTP id k5so776860ggd.19
        for <linux-omap@vger.kernel.org>; Fri, 12 Oct 2012 06:54:33 -0700 (PDT)
In-Reply-To: <5077F7B5.9000509@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: kishon <kishon@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, gregkh@linuxfoundation.org, sarah.a.sharp@linux.intel.com, balbi@ti.com, Abhilash Kesavan <a.kesavan@samsung.com>, Doug Anderson <dianders@chromium.org>

Hi kishon,

On 12 October 2012 16:27, kishon <kishon@ti.com> wrote:
> Hi,
>
>
> On Wednesday 10 October 2012 07:35 PM, Vikas C Sajjan wrote:
>>
>> From: Vikas Sajjan <vikas.sajjan@linaro.org>
>>
>> Adding the suspend and resume funtionality to DWC3 core.
>>
>> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
>> Signed-off-by: Vikas C Sajjan <vikas.sajjan@linaro.org>
>> CC: Doug Anderson <dianders@chromium.org>
>> ---
>>   drivers/usb/dwc3/core.c |  268
>> +++++++++++++++++++++++++++++-----------------
>>   1 files changed, 169 insertions(+), 99 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>> index b415c0c..58b51e1 100644
>> --- a/drivers/usb/dwc3/core.c
>> +++ b/drivers/usb/dwc3/core.c
>>
>> @@ -70,51 +70,20 @@ MODULE_PARM_DESC(maximum_speed, "Maximum supported
>> speed.");
>>
>>   static DECLARE_BITMAP(dwc3_devs, DWC3_DEVS_POSSIBLE);
>>
>> -int dwc3_get_device_id(void)
>> -{
>> -       int             id;
>> -
>> -again:
>> -       id = find_first_zero_bit(dwc3_devs, DWC3_DEVS_POSSIBLE);
>> -       if (id < DWC3_DEVS_POSSIBLE) {
>> -               int old;
>> -
>> -               old = test_and_set_bit(id, dwc3_devs);
>> -               if (old)
>> -                       goto again;
>> -       } else {
>> -               pr_err("dwc3: no space for new device\n");
>> -               id = -ENOMEM;
>> -       }
>> -
>> -       return id;
>> -}
>> -EXPORT_SYMBOL_GPL(dwc3_get_device_id);
>> -
>> -void dwc3_put_device_id(int id)
>> -{
>> -       int                     ret;
>> -
>> -       if (id < 0)
>> -               return;
>> -
>> -       ret = test_bit(id, dwc3_devs);
>> -       WARN(!ret, "dwc3: ID %d not in use\n", id);
>> -       smp_mb__before_clear_bit();
>> -       clear_bit(id, dwc3_devs);
>> -}
>> -EXPORT_SYMBOL_GPL(dwc3_put_device_id);
>> -
>> -void dwc3_set_mode(struct dwc3 *dwc, u32 mode)
>> +static void __devinit dwc3_cache_hwparams(struct dwc3 *dwc)
>>   {
>> -       u32 reg;
>> +       struct dwc3_hwparams    *parms = &dwc->hwparams;
>>
>> -       reg = dwc3_readl(dwc->regs, DWC3_GCTL);
>> -       reg &= ~(DWC3_GCTL_PRTCAPDIR(DWC3_GCTL_PRTCAP_OTG));
>> -       reg |= DWC3_GCTL_PRTCAPDIR(mode);
>> -       dwc3_writel(dwc->regs, DWC3_GCTL, reg);
>> +       parms->hwparams0 = dwc3_readl(dwc->regs, DWC3_GHWPARAMS0);
>> +       parms->hwparams1 = dwc3_readl(dwc->regs, DWC3_GHWPARAMS1);
>> +       parms->hwparams2 = dwc3_readl(dwc->regs, DWC3_GHWPARAMS2);
>> +       parms->hwparams3 = dwc3_readl(dwc->regs, DWC3_GHWPARAMS3);
>> +       parms->hwparams4 = dwc3_readl(dwc->regs, DWC3_GHWPARAMS4);
>> +       parms->hwparams5 = dwc3_readl(dwc->regs, DWC3_GHWPARAMS5);
>> +       parms->hwparams6 = dwc3_readl(dwc->regs, DWC3_GHWPARAMS6);
>> +       parms->hwparams7 = dwc3_readl(dwc->regs, DWC3_GHWPARAMS7);
>> +       parms->hwparams8 = dwc3_readl(dwc->regs, DWC3_GHWPARAMS8);
>>   }
>> -
>>   /**
>>    * dwc3_core_soft_reset - Issues core soft reset and PHY reset
>>    * @dwc: pointer to our context structure
>> @@ -160,6 +129,102 @@ static void dwc3_core_soft_reset(struct dwc3 *dwc)
>>         dwc3_writel(dwc->regs, DWC3_GCTL, reg);
>>   }
>>
>> +static int dwc3_core_reset(struct dwc3 *dwc)
>> +{
>> +       unsigned long   timeout;
>> +       u32     reg;
>> +
>> +       /* issue device SoftReset too */
>> +       timeout = jiffies + msecs_to_jiffies(500);
>> +       dwc3_writel(dwc->regs, DWC3_DCTL, DWC3_DCTL_CSFTRST);
>> +       do {
>> +               reg = dwc3_readl(dwc->regs, DWC3_DCTL);
>> +               if (!(reg & DWC3_DCTL_CSFTRST))
>> +                       break;
>> +
>> +               if (time_after(jiffies, timeout)) {
>> +                       dev_err(dwc->dev, "Reset Timed Out\n");
>> +                       return -ETIMEDOUT;
>> +               }
>> +
>> +               cpu_relax();
>> +       } while (true);
>> +
>> +       dwc3_core_soft_reset(dwc);
>> +
>> +       dwc3_cache_hwparams(dwc);
>> +
>> +       reg = dwc3_readl(dwc->regs, DWC3_GCTL);
>> +       reg &= ~DWC3_GCTL_SCALEDOWN_MASK;
>> +       reg &= ~DWC3_GCTL_DISSCRAMBLE;
>> +
>> +       switch (DWC3_GHWPARAMS1_EN_PWROPT(dwc->hwparams.hwparams1)) {
>> +       case DWC3_GHWPARAMS1_EN_PWROPT_CLK:
>> +               reg &= ~DWC3_GCTL_DSBLCLKGTNG;
>> +               break;
>> +       default:
>> +               dev_dbg(dwc->dev, "No power optimization available\n");
>> +       }
>> +
>> +       /*
>>
>> +        * WORKAROUND: DWC3 revisions <1.90a have a bug
>> +        * where the device can fail to connect at SuperSpeed
>> +        * and falls back to high-speed mode which causes
>> +        * the device to enter a Connect/Disconnect loop
>> +        */
>> +       if (dwc->revision < DWC3_REVISION_190A)
>> +               reg |= DWC3_GCTL_U2RSTECN;
>> +
>> +       dwc3_writel(dwc->regs, DWC3_GCTL, reg);
>> +
>> +       return 0;
>> +}
>> +
>> +int dwc3_get_device_id(void)
>> +{
>> +       int             id;
>> +
>> +again:
>> +       id = find_first_zero_bit(dwc3_devs, DWC3_DEVS_POSSIBLE);
>> +       if (id < DWC3_DEVS_POSSIBLE) {
>> +               int old;
>> +
>> +               old = test_and_set_bit(id, dwc3_devs);
>> +               if (old)
>> +                       goto again;
>> +       } else {
>> +               pr_err("dwc3: no space for new device\n");
>> +               id = -ENOMEM;
>> +       }
>> +
>> +       return id;
>> +}
>> +EXPORT_SYMBOL_GPL(dwc3_get_device_id);
>> +
>> +void dwc3_put_device_id(int id)
>> +{
>> +       int                     ret;
>> +
>> +       if (id < 0)
>> +               return;
>> +
>> +       ret = test_bit(id, dwc3_devs);
>> +       WARN(!ret, "dwc3: ID %d not in use\n", id);
>> +       smp_mb__before_clear_bit();
>> +       clear_bit(id, dwc3_devs);
>> +}
>> +EXPORT_SYMBOL_GPL(dwc3_put_device_id);
>> +
>> +void dwc3_set_mode(struct dwc3 *dwc, u32 mode)
>> +{
>> +       u32 reg;
>> +
>> +       reg = dwc3_readl(dwc->regs, DWC3_GCTL);
>> +       reg &= ~(DWC3_GCTL_PRTCAPDIR(DWC3_GCTL_PRTCAP_OTG));
>> +       reg |= DWC3_GCTL_PRTCAPDIR(mode);
>> +       dwc3_writel(dwc->regs, DWC3_GCTL, reg);
>> +}
>> +
>>   /**
>>    * dwc3_free_one_event_buffer - Frees one event buffer
>>    * @dwc: Pointer to our controller context structure
>> @@ -303,20 +368,7 @@ static void dwc3_event_buffers_cleanup(struct dwc3
>> *dwc)
>>         }
>>   }
>>
>> -static void __devinit dwc3_cache_hwparams(struct dwc3 *dwc)
>> -{
>> -       struct dwc3_hwparams    *parms = &dwc->hwparams;
>>
>> -       parms->hwparams0 = dwc3_readl(dwc->regs, DWC3_GHWPARAMS0);
>> -       parms->hwparams1 = dwc3_readl(dwc->regs, DWC3_GHWPARAMS1);
>> -       parms->hwparams2 = dwc3_readl(dwc->regs, DWC3_GHWPARAMS2);
>> -       parms->hwparams3 = dwc3_readl(dwc->regs, DWC3_GHWPARAMS3);
>> -       parms->hwparams4 = dwc3_readl(dwc->regs, DWC3_GHWPARAMS4);
>> -       parms->hwparams5 = dwc3_readl(dwc->regs, DWC3_GHWPARAMS5);
>> -       parms->hwparams6 = dwc3_readl(dwc->regs, DWC3_GHWPARAMS6);
>> -       parms->hwparams7 = dwc3_readl(dwc->regs, DWC3_GHWPARAMS7);
>> -       parms->hwparams8 = dwc3_readl(dwc->regs, DWC3_GHWPARAMS8);
>> -}
>>
>>   /**
>>    * dwc3_core_init - Low-level initialization of DWC3 Core
>> @@ -326,7 +378,6 @@ static void __devinit dwc3_cache_hwparams(struct dwc3
>> *dwc)
>>    */
>>   static int __devinit dwc3_core_init(struct dwc3 *dwc)
>>   {
>> -       unsigned long           timeout;
>>         u32                     reg;
>>         int                     ret;
>>
>> @@ -339,49 +390,9 @@ static int __devinit dwc3_core_init(struct dwc3 *dwc)
>>         }
>>         dwc->revision = reg;
>>
>> -       /* issue device SoftReset too */
>> -       timeout = jiffies + msecs_to_jiffies(500);
>> -       dwc3_writel(dwc->regs, DWC3_DCTL, DWC3_DCTL_CSFTRST);
>> -       do {
>> -               reg = dwc3_readl(dwc->regs, DWC3_DCTL);
>> -               if (!(reg & DWC3_DCTL_CSFTRST))
>> -                       break;
>> -
>> -               if (time_after(jiffies, timeout)) {
>> -                       dev_err(dwc->dev, "Reset Timed Out\n");
>> -                       ret = -ETIMEDOUT;
>> -                       goto err0;
>> -               }
>> -
>> -               cpu_relax();
>> -       } while (true);
>> -
>> -       dwc3_core_soft_reset(dwc);
>> -
>> -       dwc3_cache_hwparams(dwc);
>> -
>> -       reg = dwc3_readl(dwc->regs, DWC3_GCTL);
>> -       reg &= ~DWC3_GCTL_SCALEDOWN_MASK;
>> -       reg &= ~DWC3_GCTL_DISSCRAMBLE;
>> -
>> -       switch (DWC3_GHWPARAMS1_EN_PWROPT(dwc->hwparams.hwparams1)) {
>> -       case DWC3_GHWPARAMS1_EN_PWROPT_CLK:
>> -               reg &= ~DWC3_GCTL_DSBLCLKGTNG;
>> -               break;
>> -       default:
>> -               dev_dbg(dwc->dev, "No power optimization available\n");
>> -       }
>> -
>> -       /*
>> -        * WORKAROUND: DWC3 revisions <1.90a have a bug
>> -        * where the device can fail to connect at SuperSpeed
>> -        * and falls back to high-speed mode which causes
>> -        * the device to enter a Connect/Disconnect loop
>> -        */
>> -       if (dwc->revision < DWC3_REVISION_190A)
>> -               reg |= DWC3_GCTL_U2RSTECN;
>> -
>> -       dwc3_writel(dwc->regs, DWC3_GCTL, reg);
>> +       ret = dwc3_core_reset(dwc);
>> +       if (ret < 0)
>> +               goto err0;
>>
>>         ret = dwc3_alloc_event_buffers(dwc, DWC3_EVENT_BUFFERS_SIZE);
>>         if (ret) {
>>
>> @@ -622,11 +633,70 @@ static int __devexit dwc3_remove(struct
>> platform_device *pdev)
>>         return 0;
>>   }
>>
>> +#ifdef CONFIG_PM
>> +static int dwc3_core_resume(struct device *dev)
>> +{
>> +       struct dwc3     *dwc;
>> +       int     ret;
>> +
>> +       dwc = dev_get_drvdata(dev);
>> +       if (!dwc)
>> +               return -EINVAL;
>> +
>> +       ret = dwc3_core_reset(dwc);
>
>
> Do you have to add core_reset because of any issues you observed? In the
> ideal working case, you shouldn't have to do reset every-time on resume.
>
Initially we tested on kernel 3.4 with which we had some issue in detecting
USB devices on SS hub. But now as you pointed out, we tested after removing
core_reset  during resume, and it seems to be working fine.
Thanks for pointing out, we shall re-confirm and update the new patch-set soon.

> Maybe I have missed your mail so I'm asking Felipe's question again. how has
> this patch series been tested?
>
We tested the patch series on 'usb-next' on greg's tree after applying
our local patches
for exynos5 USB3.0 PHY support and also reverting the patch for dwc3-core
"usb: dwc3: add basic PHY support" since our USB3.0 PHY driver is underway.

> Thanks
> Kishon



-- 
Thanks and Regards
 Vikas Sajjan
