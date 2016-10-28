From: Milo Kim <woogyom.kim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 5/7] ARM: dts: am335x: Add the charger interrupt
Date: Fri, 28 Oct 2016 13:01:46 +0900
Message-ID: <7fbec6ad-9774-8b40-1cdb-b3aa9f04c8ea@gmail.com>
References: <20161021140106.21531-1-woogyom.kim@gmail.com>
 <20161021140106.21531-6-woogyom.kim@gmail.com>
 <CAOCHtYgBTq0a1FAMQJb5VoLPWBHYkF3rH_Km6U9u6ep=8ApZuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAOCHtYgBTq0a1FAMQJb5VoLPWBHYkF3rH_Km6U9u6ep=8ApZuQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 10/22/2016 05:47 AM, Robert Nelson wrote:
>> +#include <dt-bindings/mfd/tps65217.h>
> ^ this hasn't been posted nor pushed to mainline yet.. ;)
>

Oops! I've created this file but not captured not only in my git tree 
but also in my head! Thanks for your review.

Best regards,
Milo
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
