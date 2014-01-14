From: "Anna, Suman" <s-anna-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv4 6/7] hwspinlock/omap: enable module before reading SYSSTATUS
 register
Date: Tue, 14 Jan 2014 10:56:26 -0600
Message-ID: <52D56C3A.7000704@ti.com>
References: <1389658764-39199-1-git-send-email-s-anna@ti.com> <1389658764-39199-7-git-send-email-s-anna@ti.com> <20140114131052.GA10818@saruman.home> <20140114140440.GA15785@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140114140440.GA15785-HgARHv6XitL9zxVx7UNMDg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Felipe,

On 01/14/2014 08:04 AM, Felipe Balbi wrote:
> Hi again,
>
> On Tue, Jan 14, 2014 at 07:10:52AM -0600, Felipe Balbi wrote:
>>> diff --git a/drivers/hwspinlock/omap_hwspinlock.c b/drivers/hwspinlock/omap_hwspinlock.c
>>> index 9f56fb2..194886e 100644
>>> --- a/drivers/hwspinlock/omap_hwspinlock.c
>>> +++ b/drivers/hwspinlock/omap_hwspinlock.c
>>> @@ -101,10 +101,23 @@ static int omap_hwspinlock_probe(struct platform_device *pdev)
>>>   	if (!io_base)
>>>   		return -ENOMEM;
>>>
>>> +	/*
>>> +	 * make sure the module is enabled and clocked before reading
>>> +	 * the module SYSSTATUS register
>>> +	 */
>>> +	pm_runtime_enable(&pdev->dev);
>>> +	pm_runtime_get_sync(&pdev->dev);
>
> another thing, you need to check return of pm_runtime_get_sync()

OK, let me check this and your other comment, and the fix is probably a 
separate patch.

regards
Suman

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
