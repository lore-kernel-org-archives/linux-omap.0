From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 5/7] tty: 8250: workaround errata on disabling UART after
 using DMA
Date: Mon, 13 Jul 2015 14:39:12 +0530
Message-ID: <55A38038.8000801@ti.com>
References: <cover.1436174801.git.nsekhar@ti.com> <9f70a47010d019f76b822b60e7d4f512aa4e46d7.1436174801.git.nsekhar@ti.com> <559DCF83.8010703@hurleysoftware.com> <559E8209.9080005@ti.com> <55A040A5.1080909@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <55A040A5.1080909-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Device Tree Mailing List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, John Ogness <john.ogness-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Peter,

On Saturday 11 July 2015 03:31 AM, Peter Hurley wrote:
> On 07/09/2015 10:15 AM, Sekhar Nori wrote:
>> On Thursday 09 July 2015 07:03 AM, Peter Hurley wrote:
> 
> [...]
> 
>>>> @@ -1307,6 +1320,36 @@ static int omap8250_runtime_suspend(struct device *dev)
>>>>  			return -EBUSY;
>>>>  	}
>>>>  
>>>> +	if (priv->habit & UART_ERRATA_CLOCK_DISABLE) {
>>>> +		int sysc;
>>>> +		int syss;
>>>> +		int timeout = 100;
>>>> +
>>>> +		sysc = serial_in(up, UART_OMAP_SYSC);
>>>> +
>>>> +		/* softreset the UART */
>>>> +		sysc |= OMAP_UART_SYSC_SOFTRESET;
>>>> +		serial_out(up, UART_OMAP_SYSC, sysc);
>>>> +
>>>> +		/* By experiments, 1us enough for reset complete on AM335x */
>>>> +		do {
>>>> +			udelay(1);
>>>> +			syss = serial_in(up, UART_OMAP_SYSS);
>>>> +		} while (--timeout && !(syss & OMAP_UART_SYSS_RESETDONE));
>>>
>>>
>>> If there is not a omap helper function to reset modules, there should be.
>>> Open-coding the module reset is not appropriate.
>>
>> There is work planned to have something implemented for OMAP as part of
>> drivers/reset/ API. AFAIK, this depends on some PRCM code clean-up
>> affecting multiple OMAP platforms and is couple of merge windows away
>> from taking shape.
>>
>> Meanwhile, I think this is the best we can do. Other drivers like
>> i2c-omap have done something similar (see omap_i2c_reset()).
> 
> Ok, then please make the reset a separate local function
> (returning success/failure?). omap_8250_reset()?
> 
> A TODO or FIXME above it explaining
> the temporary nature of the function would be appreciated :)

Okay, will do.

> 
>>>
>>>> +		if (!timeout) {
>>>> +			dev_err(dev, "timed out waiting for reset done\n");
>>>> +			return -ETIMEDOUT;
>>>> +		}
>>>> +
>>>> +		/*
>>>> +		 * For UART module wake-up to work, MDR1.MODESELECT should
>>>> +		 * not be set to "Disable", so update it.
>>>> +		 */
>>>> +		if (device_may_wakeup(dev))
>>>> +			omap8250_update_mdr1(up, priv);
>>>
>>> Should this be unconditional?
>>
>> I do not see it doing any harm if done unconditionally. But it will be
>> unnecessary. Unless the UART is being used for wakeup, we don't need
>> MDR1 restored at this stage. And omap8250_restore_regs() will eventually
>> restore the register anyway.
> 
> Yeah, I understand that, but special-casing it isn't adding any value;
> it's not as if you actually want the module to not be in UART mode.
> 
> And the comment could be single-line:
> 
> 		/* Restore to UART mode after reset (for wakeup) */

Alright, will change this as well.

Thanks,
Sekhar
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
