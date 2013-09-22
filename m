From: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 3/4] usb: musb: omap2430: use SIMPLE_DEV_PM_OPS
Date: Sun, 22 Sep 2013 17:02:03 +0200
Message-ID: <523F066B.1030304@gmail.com>
References: <1379860999-7106-1-git-send-email-zonque@gmail.com> <1379860999-7106-3-git-send-email-zonque@gmail.com> <523F05C4.50104@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <523F05C4.50104-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 22.09.2013 16:59, Sergei Shtylyov wrote:
> On 22-09-2013 18:43, Daniel Mack wrote:
> 
>> This makes omap2430_pm_ops const and will stub the struct out in case
>> CONFIG_PM_SLEEP is not set.
> 
>> Signed-off-by: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> ---
>>   drivers/usb/musb/omap2430.c | 15 +++++----------
>>   1 file changed, 5 insertions(+), 10 deletions(-)
> 
>> diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
>> index 59d2245..be42460 100644
>> --- a/drivers/usb/musb/omap2430.c
>> +++ b/drivers/usb/musb/omap2430.c
>> @@ -659,17 +659,12 @@ static int omap2430_runtime_resume(struct device *dev)
>>
>>   	return 0;
>>   }
>> -
>> -static struct dev_pm_ops omap2430_pm_ops = {
>> -	.runtime_suspend = omap2430_runtime_suspend,
>> -	.runtime_resume = omap2430_runtime_resume,
>> -};
>> -
>> -#define DEV_PM_OPS	(&omap2430_pm_ops)
>> -#else
>> -#define DEV_PM_OPS	NULL
>>   #endif
>>
>> +static SIMPLE_DEV_PM_OPS(omap2430_pm_ops,
>> +			 omap2430_runtime_suspend,
>> +			 omap2430_runtime_resume);
> 
>     No, SIMPLE_DEV_PM_OPS() won't do here, it's runtime PM, didn't you see?

Eh, you're right, sorry. Whoever applies this series, just drop that one
patch. The rest of this series is not affected.

Sergei, thanks for the review again :)


Daniel

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
