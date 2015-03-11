From: Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v5 3/3] ARM: dts: igep00x0: add wl18xx bindings
Date: Wed, 11 Mar 2015 02:00:59 +0100
Message-ID: <CABxcv=ndnNj4MhoXeW=GHXT4aEWQYHdbu-Mg4R2Zhf9CJTrJCA@mail.gmail.com>
References: <1425915402-10012-1-git-send-email-eliad@wizery.com>
	<2223973.a64rBcZvaA@wuerfel>
	<CAB3XZEftjwUGS_Kj2dCxYY1m82C+a1_=akbnG3_hLETCr+Dddg@mail.gmail.com>
	<5683860.JYkc24rKim@wuerfel>
	<CAB3XZEfEQnb7qsxuAAr6pUehm1nw6Eu4ZsV1+E477yF5K1hczA@mail.gmail.com>
	<20150310161801.GR5264@atomide.com>
	<CAB3XZEdK2O7tSSTchvRQtaefzCECjjQ-biQmOBHGdzJaBknSFQ@mail.gmail.com>
	<20150310173550.GT5264@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150310173550.GT5264-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Eliad Peller <eliad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hello Tony,

On Tue, Mar 10, 2015 at 6:35 PM, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:
>>
>> we do have to make sure these wl18xx bindings are future-compatible
>> with the wl12xx ones, but i think the current bindings are pretty much
>> standard (and are actually a subset of the bindings needed by wl12xx),
>> so it should be fine.
>
> Well how about add just the parsing of the clock and assume it's always
> WL12XX_REFCLOCK_38 for now as that's the only thing we're currently
> using. Then we can add a property or compatible value if using something
> else as needed.
>

What do you mean by parsing here? IIUC there isn't a clock driver for
these clocks and are setup directly in the
drivers/net/wireless/ti/wl12xx/main.c driver.

So you can't make the WLAN chip dev node a consumer of these clocks by
adding a phandle to a clock provider and clock specifiers since there
isn't a provider to be referenced in the DT. Or did I misunderstand?

> Regards,
>
> Tony

Best regards,
Javier
--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
