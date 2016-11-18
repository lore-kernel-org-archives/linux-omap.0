From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Subject: Re: [RFC 6/6] ARM: dts: am57xx-beagle-x15-common: enable etnaviv
Date: Thu, 17 Nov 2016 22:34:24 -0600
Message-ID: <82862612-8d19-d58c-ca24-292c041abf65@ti.com>
References: <20161118024436.13447-1-robertcnelson@gmail.com>
 <20161118024436.13447-6-robertcnelson@gmail.com>
 <e69a797c-bec3-2243-5c19-9d7633092369@ti.com>
 <CAOCHtYiUz1cjYw9nNa4YZGtzNVgSgjEa=4Lqiktz07rszsSksw@mail.gmail.com>
 <3eb346ad-1675-e613-93ef-bd2d07bf2ab8@ti.com>
 <CAOCHtYh8QebrYA2ioaXgURdc47QY4x+EwZLBXLLGP1-k7eAMmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAOCHtYh8QebrYA2ioaXgURdc47QY4x+EwZLBXLLGP1-k7eAMmw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Julien <jboulnois-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 11/17/2016 10:26 PM, Robert Nelson wrote:
[...]
> Oh yeah, defintely, we can move gpu-subsystem to the base dra7.dtsi,
> as the whole dra.dtsi family has a gc320 and then the board device
> tree can enable it via:
>
> &bb2d {
>        status = "okay";
> };

Yep, thanks.

-- 
Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
