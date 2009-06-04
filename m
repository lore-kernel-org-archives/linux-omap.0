From: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: Re: MUSB ISSUE on OMAP3530 with USB-2-Ethernet converter
Date: Thu, 4 Jun 2009 13:17:55 +0300
Message-ID: <20090604101755.GA23310@nokia.com>
References: <9c4da51b0905290224i24ad0385jfaf04d0982f12bbc@mail.gmail.com> <20090529094055.GE5229@nokia.com> <9c4da51b0905290716k787b43c7l82f06c5ba857efc7@mail.gmail.com> <814dfab70906040312v65a83b2dke58d50dbe6fd5ef9@mail.gmail.com>
Reply-To: felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <814dfab70906040312v65a83b2dke58d50dbe6fd5ef9-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ext Remith Ravi <remithmailinglist-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "umeshdelhi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <umeshdelhi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Jun 04, 2009 at 12:12:04PM +0200, ext Remith Ravi wrote:
> Hi,
> 
> Anybody had a chance to attend this issue? Any hint to solve the problem?
> 
> The ASIX AX88772A USB2.0 Fast Ethernet Network Adapter Linux driver
> available in Asix website supports only upto Linux 2.6.26.
> I integrated that driver into the git kernel and tested it on the
> OMAP35xx dev board (EHCI port). The driver detects the presence of
> USB-2-Ethernet
> converter and it is possible to assign ip address to the new Ethernet
> interface. But the ping test fails  (ping statistics ---
> 40 packets transmitted, 0 packets received, 100% packet loss) and
> therefore I cant continue testing it on the latest git kernel.
> 
> Any help towards solving this issue will be highly appreciated.

sorry, we can't support you with such an old kernel. You have to
fallback to the company who provided you the kernel.

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
