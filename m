From: Moreno Bartalucci <moreno.bartalucci-Hj/TeGiWV4YL5bzFcGmneg@public.gmane.org>
Subject: Re: [PATCH] usb-musb: keep VBUS on when device is disconnected
Date: Mon, 27 Mar 2017 14:53:27 +0200
Message-ID: <00882633-3F61-4010-A4D2-D04473282B10@tecnorama.it>
References: <20170315140801.97230-1-moreno.bartalucci@tecnorama.it>
 <20170324185836.GC19814@uda0271908>
 <2d10809f-d482-ffa9-30b7-8785e94ab102@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <2d10809f-d482-ffa9-30b7-8785e94ab102-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lars Melin <larsm17-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Alessio Igor Bogani <abogani-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

> Il giorno 25 mar 2017, alle ore 08:21, Lars Melin <larsm17-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> ha scritto:
> 
>> 
>> The usb device has been disconnected, why it still cares about VBUS
>> power?
> 
> Morphing devices (3G dongles, wifi dongles, some printers) boots up in install mode, usually only as a virtual cd-rom containing Windows drivers and software.
> [...]
> why a host only configured port should cut the VBUS supply, it could be always on right?
> 

Yes, that’s exactly the problem I tried to solve with this patch.
I have to add that the problem was not there with kernels up to 4.8.17, I started to see it with 4.9 and up.

By git-bisecting kernel sources, it appears this behaviour has been introduced by this commit:

2f3fd2c5bde1f94513c3dc311ae64494085ec371

I also agree that, in my opinion, a host only port should never remove the VBUS supply, as it happens on all the PCs (linux+windows+mac) that I tested until now.

I saw this problem on a beaglebone black. Of course I’m available to do all the tests that you might suggest me to help you better understand the issue.

Moreno Bartalucci


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
