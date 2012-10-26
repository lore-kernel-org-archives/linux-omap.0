From: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/5] drivers: usb: otg: make twl6030_usb as a comparator
 driver to omap_usb2
Date: Fri, 26 Oct 2012 17:54:00 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1210261750430.7573@utopia.booyaka.com>
References: <1346943430-18236-1-git-send-email-kishon@ti.com> <1346943430-18236-3-git-send-email-kishon@ti.com> <CAH+eYFAj1ecvmiJCu8QDCr3LjHT5eXjq6zsZMiVRPROoWcDuNQ@mail.gmail.com> <CAAe_U6K1RXA3b5u9WvE=2VoXym9Vj3KM7c0J27jKz+2KrV4tsg@mail.gmail.com>
 <CAH+eYFAhVE8cAte2PFk3jinV9n3m+eDLtE43QxzRXMScnFGcrA@mail.gmail.com> <508AA94B.10504@ti.com> <508AAA85.6070905@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <508AAA85.6070905-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
Cc: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, "ABRAHAM, KISHON VIJAY" <kishon-l0cyMroinI0@public.gmane.org>, Rabin Vincent <rabin-66gdRtMMWGc@public.gmane.org>, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Fri, 26 Oct 2012, Benoit Cousson wrote:

> On 10/26/2012 05:16 PM, Roger Quadros wrote:
> 
> > I still can't get musb to work on 3.7-rc2. Apparently it is still
> > missing the patches from Benoit's for_3.7/dts_part2.
> > 
> > Maybe I just need to wait for it to be merged?
> 
> They are now in a for_3.8/dts. Unfortunately, one patch that was adding
> ctrl_module address in the USB data was rejected and thus I'm not sure
> it will work without that.

For v3.7-rc timeframe, looks like it's waiting on an ack from you:

http://www.spinics.net/lists/arm-kernel/msg201028.html


- Paul
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
