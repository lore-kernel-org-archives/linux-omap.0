From: Eliad Peller <eliad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v5 3/3] ARM: dts: igep00x0: add wl18xx bindings
Date: Wed, 11 Mar 2015 14:12:54 +0200
Message-ID: <CAB3XZEfnZbZqH95suJ9n39aZRr8kxPdj2HZuWKMvQtYmXe3QEQ@mail.gmail.com>
References: <1425915402-10012-1-git-send-email-eliad@wizery.com>
	<20150310173550.GT5264@atomide.com>
	<CABxcv=ndnNj4MhoXeW=GHXT4aEWQYHdbu-Mg4R2Zhf9CJTrJCA@mail.gmail.com>
	<3439869.6umCuOq6SV@wuerfel>
	<CABxcv=nE_Qd7do+dRyp=fw3wYmWFb+0eEjXYOtdjqE55Cp0zmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CABxcv=nE_Qd7do+dRyp=fw3wYmWFb+0eEjXYOtdjqE55Cp0zmQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Mar 11, 2015 at 1:34 PM, Javier Martinez Canillas
<javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org> wrote:
> I think that patch [0] should not be needed since for external clocks,
> the IP providing the clocks should have its own clock driver and for
> internal clocks, a property should be used instead as you said.
>
>> If there is no external clock provider for this chip and the clocks
>> are provided by the device itself, then all we need is a clock-frequency
>> property in the device node.
>>
>
> Agreed, IIUC Luciano wanted to expose the internal clocks by
> registering in the common clock framework but if those clocks are not
> really accessible from outside the wlan chip, then I also think that a
> device node property should be used instead.
>
how should i describe multiple clock-frequency properties (there are 2
relevant clocks) in this case?

does something like the following makes sense?

wlcore: wlcore@2 {
    ...
    refclock: refclock {
        compatible = "fixed-clock";
        #clock-cells = <0>;
        clock-frequency = <38400000>;
    };
}

Eliad.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
