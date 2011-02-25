From: Hema Kalliguddi <hemahk-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 3/5] usb: musb: Idle path retention and offmode support
 for OMAP3
Date: Fri, 25 Feb 2011 15:46:39 +0530
Message-ID: <df9176b6d64dfea70a212e70675e75fd@mail.gmail.com>
References: <1298628663-27650-1-git-send-email-hemahk@ti.com>
 <1298628663-27650-4-git-send-email-hemahk@ti.com> <20110225101452.GB4190@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110225101452.GB4190-UiBtZHVXSwEVvW8u9ZQWYwjfymiNCTlR@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

 Felipe,

>-----Original Message-----
>From: Felipe Balbi [mailto:balbi-l0cyMroinI0@public.gmane.org]
>Sent: Friday, February 25, 2011 3:45 PM
>To: Hema HK
>Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Felipe Balbi
>Subject: Re: [PATCH 3/5] usb: musb: Idle path retention and
>offmode support for OMAP3
>
>On Fri, Feb 25, 2011 at 03:41:01PM +0530, Hema HK wrote:
>> @@ -520,8 +524,8 @@ static int omap2430_resume(struct device *dev)
>>  }
>>
>>  static struct dev_pm_ops omap2430_pm_ops = {
>> -	.suspend	= omap2430_suspend,
>> -	.resume		= omap2430_resume,
>> +	.runtime_suspend = omap2430_suspend,
>> +	.runtime_resume = omap2430_resume,
>
>while at that, please rename omap2430_suspend to
>omap2430_runtime_suspend and omap2430_resume to omap2430_runtime_resume
>just to keep consistency.
>

Ok.

Regards,
Hema
>--
>balbi
>
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
