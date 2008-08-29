From: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: Re: <Solved !!!> RE: OMAP35xx MUSB kernel crash with Linux 2.6.26
Date: Fri, 29 Aug 2008 11:35:51 +0300
Message-ID: <20080829083551.GT7354@gandalf.research.nokia.com>
References: <19F8576C6E063C45BE387C64729E7394034F30B16D@dbde02.ent.ti.com> <19F8576C6E063C45BE387C64729E739403CD61A341@dbde02.ent.ti.com>
Reply-To: felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <19F8576C6E063C45BE387C64729E739403CD61A341-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "ext Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>
Cc: "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Aug 29, 2008 at 02:01:27PM +0530, ext Gupta, Ajay Kumar wrote:
> Back porting drivers/usb/storage from v2.6.27rc4 to v2.6.26-omap1 solved this kernel panic.

Cool it wasn't a bug in musb :-)

Thanks for notifying us about it.

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
