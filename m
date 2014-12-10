From: Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>
Subject: Re: BCM2048 bluetooth connected over OMAP serial
Date: Wed, 10 Dec 2014 18:42:33 +0100
Message-ID: <5C56C73A-1D8E-4ACC-B1B7-3E8D49943A70@holtmann.org>
References: <20141210164333.GA3154@amd> <CAL_Jsq+dy+5Fsg_oasP_hN3RuL1Wk7fOcQjyp+UdaJZyGa=uEg@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAL_Jsq+dy+5Fsg_oasP_hN3RuL1Wk7fOcQjyp+UdaJZyGa=uEg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, =?utf-8?Q?Pali_Roh=C3=A1r?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sebastian Reichel <sre-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>, Sebastian Reichel <sre-GFxCN5SEZAc@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Rob,

>> So, there's bluetooth chip that's connected to the SoC by UART and some
>> GPIOs. What would be right representation in the device tree?
>> Something like this?
>> 
>>        bluetooth {
>>                  compatible = "broadcom,bcm2048";
>>                  uart = <&uart2>;
>>                  reset-gpios = <&gpio3 27 GPIO_ACTIVE_HIGH>; /* want 91 */
>>                  host-wakeup-gpios = <&gpio4 5 GPIO_ACTIVE_HIGH>; /* want 101 */
>>                  bluetooth-wakeup-gpios = <&gpio2 5 GPIO_ACTIVE_HIGH>; /* want 37 */
>>                  chip-type = <3>;
>>                  bt-sysclk = <2>;
>>                  reset-gpio-shared = <0>;
>>        };
>> 
>> Is there some way to prevent OMAP tty driver from binding to the
>> device and exporting the device to userspace?
> 
> Isn't the normal way for BT to work is the uart is exposed to
> userspace and the BT stack is all in userspace? This is how other
> Broadcom BT/WiFi combo parts work.

not on Linux actually. The Bluetooth core layer (including the HCI transport) are all in kernel space.

However UART based Bluetooth chips are exposed as TTY and then the N_HCI line discipline is used to attach it to the kernel Bluetooth subsystem.

Regards

Marcel

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
