From: Vikas Sajjan <vikas.sajjan@linaro.org>
Subject: Re: [PATCH v3 1/3] usb: dwc3: Add the suspend/resume functionality
Date: Tue, 16 Oct 2012 17:10:39 +0530
Message-ID: <CAD025yRD+u+z=SEtJvEY+NAdNtg8_cWcCMWaa347e-idmb6GpQ@mail.gmail.com>
References: <1350380738-32473-1-git-send-email-vikas.sajjan@linaro.org>
	<1350380738-32473-2-git-send-email-vikas.sajjan@linaro.org>
	<20121016100656.GB17416@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ye0-f174.google.com ([209.85.213.174]:46596 "EHLO
	mail-ye0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754547Ab2JPLkk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Oct 2012 07:40:40 -0400
Received: by mail-ye0-f174.google.com with SMTP id m12so92273yen.19
        for <linux-omap@vger.kernel.org>; Tue, 16 Oct 2012 04:40:39 -0700 (PDT)
In-Reply-To: <20121016100656.GB17416@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, gregkh@linuxfoundation.org, sarah.a.sharp@linux.intel.com, joshi@samsung.com, kishon@ti.com, Abhilash Kesavan <a.kesavan@samsung.com>, Doug Anderson <dianders@chromium.org>

Hi Felipe,

On 16 October 2012 15:36, Felipe Balbi <balbi@ti.com> wrote:
> Hi,
>
> On Tue, Oct 16, 2012 at 03:15:36PM +0530, Vikas Sajjan wrote:
>> Adds suspend and resume callbacks as part of the power management
>> support to DWC3 controller Driver.
>> This patch facilitates transition of DWC3 controller between D0 and D3
>> power states during suspend/resume cycles.
>>
>> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
>> Signed-off-by: Vikas C Sajjan <vikas.sajjan@linaro.org>
>> CC: Doug Anderson <dianders@chromium.org>
>> ---
>>  drivers/usb/dwc3/core.c |   44 ++++++++++++++++++++++++++++++++++++++++++++
>>  1 files changed, 44 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>> index 5db4c76..9f35cf8 100644
>> --- a/drivers/usb/dwc3/core.c
>> +++ b/drivers/usb/dwc3/core.c
>> @@ -621,11 +621,55 @@ static int __devexit dwc3_remove(struct platform_device *pdev)
>>       return 0;
>>  }
>>
>> +#ifdef CONFIG_PM_SLEEP
>> +static int dwc3_resume(struct device *dev)
>> +{
>> +     struct dwc3 *dwc = dev_get_drvdata(dev);
>> +     int     ret;
>> +
>> +     ret = dwc3_core_init(dwc);
>> +     if (ret < 0)
>> +             return ret;
>> +
>> +     switch (dwc->mode) {
>> +     case DWC3_MODE_DEVICE:
>> +             dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_DEVICE);
>> +             break;
>> +     case DWC3_MODE_HOST:
>> +             dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_HOST);
>> +             break;
>> +     case DWC3_MODE_DRD:
>> +             dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_OTG);
>> +     }
>> +
>> +     /* runtime set active to reflect active state. */
>> +     pm_runtime_disable(dev);
>> +     pm_runtime_set_active(dev);
>> +     pm_runtime_enable(dev);
>> +
>> +     return 0;
>> +}
>> +
>> +static int dwc3_suspend(struct device *dev)
>> +{
>> +     struct dwc3 *dwc = dev_get_drvdata(dev);
>> +
>
> there is one check you need to do here. If you are playing the
> peripheral role, you can't allow suspend unless link is in U3 or you're
> not enumerated.
>
> Have you tested running 'echo mem > /sys/power/state' on your device
> while you're transferring data in a USB session with the Host ?
>
we have tested only when DWC3 is in HOST mode.

> I'll ask again, how was this tested ? What did you actually run (which
> commands, which use cases have you validated) ? I'm not asking only
> which platform you used, I need to know how you exercised this feature,
> how did you trigger suspend/resume, in which conditions (enumerated ?
> bus suspended ? no cable attached ?), etc.
>
1) We have tested by connecting a USB Mouse, USB 2.0 Mass Storage Device and
USB 3.0 Mass Storage Device on a SS hub connected on USB 3.0 port to
Exynos5250 board, in which DWC3 is configured for HOST mode.

2) We tested by running  command
echo +20  > /sys/class/rtc/rtc0/wakealarm  &&  echo mem > /sys/power/state

> cheers
>
> --
> balbi



-- 
Thanks and Regards
 Vikas Sajjan
