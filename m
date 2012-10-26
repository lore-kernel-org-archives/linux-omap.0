From: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/5] drivers: usb: otg: make twl6030_usb as a comparator
 driver to omap_usb2
Date: Fri, 26 Oct 2012 20:09:43 +0200
Message-ID: <508AD1E7.3080101@ti.com>
References: <1346943430-18236-1-git-send-email-kishon@ti.com> <1346943430-18236-3-git-send-email-kishon@ti.com> <CAH+eYFAj1ecvmiJCu8QDCr3LjHT5eXjq6zsZMiVRPROoWcDuNQ@mail.gmail.com> <CAAe_U6K1RXA3b5u9WvE=2VoXym9Vj3KM7c0J27jKz+2KrV4tsg@mail.gmail.com> <CAH+eYFAhVE8cAte2PFk3jinV9n3m+eDLtE43QxzRXMScnFGcrA@mail.gmail.com> <508AA94B.10504@ti.com> <508AAA85.6070905@ti.com> <alpine.DEB.2.00.1210261750430.7573@utopia.booyaka.com> <508ACF0B.60808@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <508ACF0B.60808-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, "ABRAHAM, KISHON VIJAY" <kishon-l0cyMroinI0@public.gmane.org>, Rabin Vincent <rabin-66gdRtMMWGc@public.gmane.org>, balbi-l0cyMroinI0@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 10/26/2012 07:57 PM, Benoit Cousson wrote:
> Hi Paul,
> 
> On 10/26/2012 07:54 PM, Paul Walmsley wrote:
>> On Fri, 26 Oct 2012, Benoit Cousson wrote:
>>
>>> On 10/26/2012 05:16 PM, Roger Quadros wrote:
>>>
>>>> I still can't get musb to work on 3.7-rc2. Apparently it is still
>>>> missing the patches from Benoit's for_3.7/dts_part2.
>>>>
>>>> Maybe I just need to wait for it to be merged?
>>>
>>> They are now in a for_3.8/dts. Unfortunately, one patch that was adding
>>> ctrl_module address in the USB data was rejected and thus I'm not sure
>>> it will work without that.
>>
>> For v3.7-rc timeframe, looks like it's waiting on an ack from you:
>>
>> http://www.spinics.net/lists/arm-kernel/msg201028.html
> 
> Oups, I missed that one. But I thought Roger was mentioning the DT patch
> and not that one.
> 
> Anyway, I will answer to Tony. Thanks for the reminder Paul.

Well, in fact, I cannot even find the original email in my mailbox :-(
I was banned again from linux-omap around that time, so that might be
the reason.


Tony,

So please take that hacky patch if it prevents the regression.

Thanks,
Benoit

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
