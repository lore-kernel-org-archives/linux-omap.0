From: Mark Salter <msalter-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] usb: ehci: make HC see up-to-date qh/qtd descriptor ASAP
Date: Wed, 31 Aug 2011 14:58:05 -0400
Message-ID: <1314817086.2344.99.camel@deneb.redhat.com>
References: <1314720193-26577-1-git-send-email-ming.lei@canonical.com>
			<1314722311.2344.64.camel@deneb.redhat.com>
			<20110830172642.GE3464@e102144-lin.cambridge.arm.com>
			<20110830174859.GA23098@kroah.com>
			<20110830175432.GG3464@e102144-lin.cambridge.arm.com>
			<5484D075-A7DA-41B7-B8FA-9B6D72A23723@freescale.com>
			<20110831084922.GA8777@e102144-lin.cambridge.arm.com>
			<1314798215.2344.76.camel@deneb.redhat.com>
			<20110831152137.GG8777@e102144-lin.cambridge.arm.com>
			<alpine.LFD.2.00.1108311332410.20358@xanadu.home>
		 <20110831175147.GI8777@e102144-lin.cambridge.arm.com>
		 <4E5E7B35.9080008@gmail.com> <1314815719.2344.95.camel@deneb.redhat.com>
	 <4E5E8230.9060307@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4E5E8230.9060307-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Nicolas Pitre <nico-vtqb6HGKxmzR7s880joybQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, Chen Peter-B29397 <B29397-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "ming.lei-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org" <ming.lei-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org" <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, 2011-08-31 at 13:49 -0500, Rob Herring wrote:
> An outer_sync will only drain the write buffer of the L2. It does not
> flush the cache though. If the write buffer does in fact keep data as
> long as possible (until it needs a free slot or the line is full), then
> long delays to write out data are certainly possible. The exact
> operation is not documented AFAIR.

Ah, thanks for that. I really haven't been paying close attention to
ARMv6/7 hardware and I'm in the process of playing catch up.

--Mark


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
