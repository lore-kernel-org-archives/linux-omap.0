From: Eliad Peller <eliad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v5 2/3] wl18xx: add basic device-tree support
Date: Wed, 11 Mar 2015 13:50:47 +0200
Message-ID: <CAB3XZEcUC5H5b3rpFWQ_NG7fAT22x-MO9HajpD15WG6G=s7=NQ@mail.gmail.com>
References: <1425915402-10012-1-git-send-email-eliad@wizery.com>
	<1425915402-10012-2-git-send-email-eliad@wizery.com>
	<CABxcv=mygdT2Q+ByVKPx4+o_Oj9KSy=zVX9ng9yN25ivkfSn1A@mail.gmail.com>
	<2121942.zIG9BfPsTV@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <2121942.zIG9BfPsTV@wuerfel>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ido Yariv <ido-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Mar 11, 2015 at 11:51 AM, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org> wrote:
>> > +static void wlcore_del_platform_data(struct wl12xx_platform_data *pdata)
>> > +{
>> > +       kfree(pdata);
>> > +}
>> > +
>>
>> This function seems to be an unnecessary, why not just call kfree() directly?
>>
>> Or better, maybe the resource-managed devm_*() functions can be used
>> so the data doesn't have to be explicitly freed?
>
> As I said earlier, I think it would be best not to dynamically allocate anything
> here at all. As Eliad explained, the data is used by two different drivers:
> wl12xx and wl18xx, and only the latter is converted for now, but after the
> conversion, it should not need the platform data structure any more, only
> the irq number that gets passed in from DT.
>
sure, i'll try taking care of it (probably with additional patch after
the conversion)

Eliad.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
