From: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Subject: Re: MUSB peripheral DMA regression caused by driver core runtime PM
 change
Date: Fri, 23 Oct 2015 15:50:21 +0300
Message-ID: <562A2D0D.3060104@ti.com>
References: <20151021234134.GQ3078@atomide.com>
 <20151022180216.GT3078@atomide.com> <20151022230133.GV3078@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151022230133.GV3078-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Heikki Krogerus <heikki.krogerus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 10/23/2015 02:01 AM, Tony Lindgren wrote:
> * Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [151022 11:03]:
>> * Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [151021 16:44]:
>>> Hi all,
>>>
>>> I noticed a regresssino in v4.3-rc series to day with MUSB gadgets
>>> and DMA. Doing a git bisect between v4.2..v4.3-rc1 on it pointed to:
>>>
>>> ddef08dd00f5 ("Driver core: wakeup the parent device before trying probe")
>>>
>>> With the commit above reverted things work fine with DMA and USB gadgets.
>>>
>>> This is on omap3 with CONFIG_USB_INVENTRA_DMA selected. Selecting
>>> CONFIG_MUSB_PIO_ONLY still works even without reverting ddef08dd00f5.
>>>
>>> Anybody got ideas what might be wrong? Some wrong runtime PM usage
>>> under drivers/usb/musb?
>>
>> Here's some more debug info on where things are different initializing
>> the USB gadgets. I added some printks and diffed the dmesg output. The
>> added calls from commit ddef08dd00f5 start with dd:
>
> Well turns out the problem actually happens earlier. We end up calling
> omap2430_runtime_resume with NULL struct musb while EPROBE_DEFER
> probing.
>
> No ideas yet how it should be fixed though.
>

I'm not sure, but below diff might help

diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index 70f2b8a..aba8ca7 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -391,6 +391,8 @@ static int omap2430_musb_init(struct musb *musb)
         }
         musb->isr = omap2430_musb_interrupt;

+       pm_runtime_enable(glue->dev);
+
         status = pm_runtime_get_sync(dev);
         if (status < 0) {
                 dev_err(dev, "pm_runtime_get_sync FAILED %d\n", status);
@@ -626,8 +628,6 @@ static int omap2430_probe(struct platform_device *pdev)
                 goto err2;
         }

-       pm_runtime_enable(&pdev->dev);
