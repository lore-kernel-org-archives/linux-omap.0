From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 02/16] mfd: omap-usb-tll: Clean up clock handling
Date: Wed, 21 Nov 2012 17:39:57 +0200
Message-ID: <50ACF5CD.9010209@ti.com>
References: <1352990054-14680-1-git-send-email-rogerq@ti.com> <1352990054-14680-3-git-send-email-rogerq@ti.com> <20121121115556.GD10216@arwen.pp.htv.fi> <50ACCAE0.3030907@ti.com> <20121121140354.GR10216@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121121140354.GR10216-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: keshava_mgowda-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 11/21/2012 04:03 PM, Felipe Balbi wrote:
> Hi,
> 
> On Wed, Nov 21, 2012 at 02:36:48PM +0200, Roger Quadros wrote:
>>>>  		break;
>>>>  	default:
>>>> -		dev_err(dev, "TLL version failed\n");
>>>> -		ret = -ENODEV;
>>>> -		goto err_ioremap;
>>>> +		tll->nch = DEFAULT_TLL_CHANNEL_COUNT;
>>>> +		dev_info(dev,
>>>> +		 "USB TLL Rev : 0x%x not recognized, assuming %d channels\n",
>>>> +			ver, tll->nch);
>>>
>>> this hsould be dev_dbg().
>>>
>>
>> I think it should be more of a warning because it signals a problem.
>> There is another pr_info in the success path which could probably be a
>> dev_dbg.
> 
> it's not a problem at all. It just means that a newer OMAP has come to
> market and perhaps we don't need extra code to support it. A revision
> detection should *never* be grounds to failure. When we can't understand
> the revision, we default to the highest possible value we know.
> 
> that's not an error.

Agreed. I'm not treating it as an error. We still continue probe and the
driver should work for newer revisions. Just prints a line on the
console about the new revision. Thought it would be useful to us, but if
you think it is a problem I don't mind removing it :).

> 
>>>> +		struct clk *fck;
>>>> +
>>>> +		sprintf(clk_name, "usb_tll_hs_usb_ch%d_clk", i);
>>>
>>> this will overflow if 'i' (for whatever reason) goes over 9.
>>
>> OK i'll add an extra character. Highly unlikely to go above 99 :)
> 
> I'd stick to snprintf() though, or something safer.

OK.

> 
>>>> +		fck = clk_get(dev, clk_name);
>>>
>>> please use devm_clk_get().
> 
> sidenote, it would be amazing to a patch at the top of this series
> converting to devm_* api ;-)
> 
>>>> @@ -373,11 +385,17 @@ static int usbtll_runtime_resume(struct device *dev)
>>>>  
>>>>  	spin_lock_irqsave(&tll->lock, flags);
>>>>  
>>>> -	if (is_ehci_tll_mode(pdata->port_mode[0]))
>>>> -		clk_enable(tll->usbtll_p1_fck);
>>>> -
>>>> -	if (is_ehci_tll_mode(pdata->port_mode[1]))
>>>> -		clk_enable(tll->usbtll_p2_fck);
>>>> +	for (i = 0; i < tll->nch; i++) {
>>>> +		if (is_ehci_tll_mode(pdata->port_mode[i])) {
>>>> +			int r;
>>>> +			r = clk_enable(tll->ch_clk[i]);
>>>> +			if (r) {
>>>> +				dev_err(dev,
>>>> +				 "%s : Error enabling ch %d clock: %d\n",
>>>> +				 __func__, i, r);
>>>
>>> you don't need __func__.
>>>
>>
>> Thought it would be useful to point out where the message is coming
>> from. But it should be easy to grep too so I'll remove it.
> 
> correct, if messages are unique, you don't need __func__ anyway ;-)
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
