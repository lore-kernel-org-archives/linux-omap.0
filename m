From: Enric Balletbo i Serra <enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Subject: Re: [PATCH 1/2] ARM: dts: igep00x0: Add SD card-detect.
Date: Fri, 06 May 2016 23:22:24 +0200
Message-ID: <572D0B10.60908@collabora.com>
References: <1462568554-7868-1-git-send-email-enric.balletbo@collabora.com> <CABxcv=nZ1hjVGnNG65eKDrxAYFBcavML+GjxXtfTcVO5N83xkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CABxcv=nZ1hjVGnNG65eKDrxAYFBcavML+GjxXtfTcVO5N83xkA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>
Cc: Linux Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Javier,

On 06/05/16 23:07, Javier Martinez Canillas wrote:
> Hello Enric,
> 
> On Fri, May 6, 2016 at 5:02 PM, Enric Balletbo i Serra
> <enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org> wrote:
>> Fix SD card remove/insert detection by adding the correct card-detect
>> pin. All IGEP OMAP3 based boards use the same card-detect pin.
>>
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
>> Signed-off-by: Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
> 
> Shouldn't his be Suggested-by: Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org> instead?
> 
> Or if the patch was originally from Ladis, then he should remain the
> author with your S-o-B after his.
> 

Well Ladis sent the same patch as I had in my local repository for long
time, so to be strict the correct is have two authors and two S-o-B. My bad
is not send the patch before.

> Patch looks good to me though.
> 
> Reviewed-by: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
> 
> Best regards,
> Javier
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
