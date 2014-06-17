From: Vladimir Pantelic <vladoman-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Unifying cape overlays into boot .dtb for BeagleBoard.org boards
Date: Tue, 17 Jun 2014 15:45:59 +0200
Message-ID: <53A04697.1020904@gmail.com>
References: <CA+T6QP==raXdWz9mezK3JxSvZjWhUZZ7aKv4CpCr0SbdaCMgDQ@mail.gmail.com> <CA+T6QPmCk9GzHPHqCKG4vHDvUGirgGaizH-V9bsHT4V=8=gCaA@mail.gmail.com> <20140617090931.GB3705@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140617090931.GB3705-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Jason Kridner <jkridner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "beagleboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org" <beagleboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 06/17/2014 11:09 AM, Russell King - ARM Linux wrote:

> Here's the most obvious question in the world on this topic.  Are capes
> hot-pluggable?

"capes" as in Beaglebone capes might not be due to the mechanical 
constraints you listed.

"capes" as a concept of pluggable hardware might well be. here is a real 
world example of commercially available pluggable hardware add-ons on a 
Linux system back from 2008:

http://en.wikipedia.org/wiki/Archos_Generation_6#Accessories

depending on the add-on, different interfaces like GPIO, UART, USB, SPI 
using the same pins were used and there was no reboot needed to load a 
new hardware configuration or change the pinmux
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
