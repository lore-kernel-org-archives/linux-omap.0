From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v3 04/23] mfd: omap-usb-tll: Use devm_kzalloc/ioremap
 and clean up error path
Date: Wed, 5 Dec 2012 16:17:03 +0200
Message-ID: <50BF575F.5080602@ti.com>
References: <1354630396-24545-1-git-send-email-rogerq@ti.com> <1354630396-24545-5-git-send-email-rogerq@ti.com> <50BF5556.4020500@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <50BF5556.4020500-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, keshava_mgowda-l0cyMroinI0@public.gmane.org, bjorn-yOkvZcmFvRU@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 12/05/2012 04:08 PM, Sergei Shtylyov wrote:
> Hello.
> 
> On 04-12-2012 18:12, Roger Quadros wrote:
> 
>> Use devm_ variants of kzalloc() and ioremap(). Simplify the error path.
> 
>> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
>> ---
>>   drivers/mfd/omap-usb-tll.c |   37 +++++++++++--------------------------
>>   1 files changed, 11 insertions(+), 26 deletions(-)
> 
>> diff --git a/drivers/mfd/omap-usb-tll.c b/drivers/mfd/omap-usb-tll.c
>> index e67cafc..828207f 100644
>> --- a/drivers/mfd/omap-usb-tll.c
>> +++ b/drivers/mfd/omap-usb-tll.c
> [...]
>> @@ -230,28 +229,21 @@ static int __devinit usbtll_omap_probe(struct
>> platform_device *pdev)
>>       if (IS_ERR(tll->usbtll_p1_fck)) {
>>           ret = PTR_ERR(tll->usbtll_p1_fck);
>>           dev_err(dev, "usbtll_p1_fck failed error:%d\n", ret);
>> -        goto err_tll;
>> +        return ret;
>>       }
>>
>>       tll->usbtll_p2_fck = clk_get(dev, "usb_tll_hs_usb_ch1_clk");
>>       if (IS_ERR(tll->usbtll_p2_fck)) {
>>           ret = PTR_ERR(tll->usbtll_p2_fck);
>>           dev_err(dev, "usbtll_p2_fck failed error:%d\n", ret);
>> -        goto err_usbtll_p1_fck;
>> +        goto err_p2_fck;
>>       }
>>
>>       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> -    if (!res) {
>> -        dev_err(dev, "usb tll get resource failed\n");
>> -        ret = -ENODEV;
>> -        goto err_usbtll_p2_fck;
>> -    }
> 
>    Not clear why you removed the error check...
> 

It is because devm_request_and_ioremap does it for you.

http://lxr.free-electrons.com/source/lib/devres.c#L88

>> -
>> -    base = ioremap(res->start, resource_size(res));
>> +    base = devm_request_and_ioremap(dev, res);
>>       if (!base) {
>> -        dev_err(dev, "TLL ioremap failed\n");
>> -        ret = -ENOMEM;
>> -        goto err_usbtll_p2_fck;
>> +        ret = -EADDRNOTAVAIL;
> 
>    Why you changed this from ENOMEM?

as per the documentation for devm_request_and_ioremap() in the
same link I sent above.

cheers,
-roger
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
