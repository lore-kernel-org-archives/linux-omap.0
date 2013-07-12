From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH] arm: omap2plus: unidle devices which are about to probe
Date: Fri, 12 Jul 2013 14:58:17 +0300
Message-ID: <51DFEF59.1010509@ti.com>
References: <20130711092612.GG23892@arwen.pp.htv.fi> <1373537788-30413-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54349 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932878Ab3GLL7U (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 12 Jul 2013 07:59:20 -0400
In-Reply-To: <1373537788-30413-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Rajendra Nayak <rnayak@ti.com>, Kevin Hilman <khilman@linaro.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, vaibhav.bedia@ti.com, linux-arm-kernel@lists.infradead.org, mpfj-list@newflow.co.uk, Sourav Poddar <sourav.poddar@ti.com>, paul@pwsan.com

On 07/11/2013 01:16 PM, Felipe Balbi wrote:
> in order to make HWMOD and pm_runtime agree on the
> initial state of the device, we will unidle the device
> and call pm_runtime_set_active() to tell pm_runtime
> that the device is really active.
>
> By the time driver's probe() is reached, a call to
> pm_runtime_get_sync() will not cause driver's
> ->runtime_resume() method to be called at first, only
> after a successful ->runtime_suspend().
>
> Note that we must prevent pm_runtime transitions while
> driver is probing otherwise drivers would be suspended
> as soon as they call pm_runtime_use_autosuspend(). By
> calling pm_runtime_forbid() before probe() and
> pm_runtime_allow() after probe() we 'fix' that detail.
>
> Note that this patch was inspired by PCI's pci_pm_init().

NAK. This is a hack.
In addition to what I've mentioned in
http://www.spinics.net/lists/arm-kernel/msg258061.html there are 
following issues:
1) this patch disables call to PM runtime callbacks for all
OMAP drivers which is wrong - I've found, for example, that
omap-usb-host.c driver enables TLL in some configurations in its
.runtime_resume():

usbhs_runtime_resume()
|-omap_tll_enable()


2) even with this fix the restore context issue will not be fixed for 
*non* console UARTs. Just try:
#echo 0xDEAD > dev/ttyO3 // checked on OMAP4 SDP

3) I've checked most of OMAP drivers and all of them solve such kind of 
problem internally (SPI, MMC, I2C, etc.)

4) See inline
>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>
> boot tested on top of today's Linus master
> 6d128e1e72bf082542e85f72e6b7ddd704193588 with OMAP4
> panda. Reached console prompt and, after setting a
> proper autosuspend delay, consoles autosuspend just
> fine.
>
> It needs to be tested on other platforms.
>
> ps: note that we also call pm_runtime_set_suspended(dev)
> from our late_initcall() to disable devices so that pm_runtime
> and HWMOD continue to aggree on device's state.
>
>   arch/arm/mach-omap2/omap_device.c | 44 +++++++++++++++++++++++++++++++++++----
>   1 file changed, 40 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_device.c b/arch/arm/mach-omap2/omap_device.c
> index 5cc9287..cb1fc1d 100644
> --- a/arch/arm/mach-omap2/omap_device.c
> +++ b/arch/arm/mach-omap2/omap_device.c
> @@ -178,6 +178,26 @@ odbfd_exit:
>   	return ret;
>   }
>
> +static void omap_device_pm_init(struct platform_device *pdev)
> +{
> +	omap_device_enable(pdev);
> +	pm_runtime_forbid(&pdev->dev);
It's wrong to use pm_runtime_forbid() - pm_runtime_get_noresume() should 
be used instead.
pm_runtime_forbid()
|-rpm_resume()


> +	pm_runtime_set_active(&pdev->dev);
> +	device_enable_async_suspend(&pdev->dev);
why did you use device_enable_async_suspend() - it would enable async 
suspend for devices - this is not related to the current issue and topic 
for discussion (currently is used by usb/scsi/pci/ata drivers only).
> +}
> +
> +static void omap_device_pm_allow(struct platform_device *pdev)
> +{
> +	pm_runtime_allow(&pdev->dev);
> +}
> +
> +static void omap_device_pm_exit(struct platform_device *pdev)
> +{
> +	device_disable_async_suspend(&pdev->dev);
> +	pm_runtime_set_suspended(&pdev->dev);
> +	omap_device_idle(pdev);
> +}
> +
>   static int _omap_device_notifier_call(struct notifier_block *nb,
>   				      unsigned long event, void *dev)
>   {
> @@ -189,16 +209,31 @@ static int _omap_device_notifier_call(struct notifier_block *nb,
>   		if (pdev->archdata.od)
>   			omap_device_delete(pdev->archdata.od);
>   		break;
> +	case BUS_NOTIFY_BIND_DRIVER:
> +		if (pdev->archdata.od)
> +			omap_device_pm_init(pdev);
> +		break;
> +	case BUS_NOTIFY_BOUND_DRIVER:
> +		if (pdev->archdata.od)
> +			omap_device_pm_allow(pdev);
> +		break;
> +	case BUS_NOTIFY_UNBOUND_DRIVER:
> +		if (pdev->archdata.od)
> +			omap_device_pm_exit(pdev);
> +		break;
>   	case BUS_NOTIFY_ADD_DEVICE:
>   		if (pdev->dev.of_node)
>   			omap_device_build_from_dt(pdev);
> -		/* fall through */
> +		break;
>   	default:
> -		od = to_omap_device(pdev);
> -		if (od)
> -			od->_driver_status = event;
> +		/* nothing */
> +		break;
>   	}
>
> +	od = to_omap_device(pdev);
> +	if (od)
> +		od->_driver_status = event;
> +
>   	return NOTIFY_DONE;
>   }
>
> @@ -855,6 +890,7 @@ static int __init omap_device_late_idle(struct device *dev, void *data)
>   			dev_warn(dev, "%s: enabled but no driver.  Idling\n",
>   				 __func__);
>   			omap_device_idle(pdev);
> +			pm_runtime_set_suspended(dev);
>   		}
>   	}
>
>

