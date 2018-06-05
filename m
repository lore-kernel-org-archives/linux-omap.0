From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [EXTERNAL] Re: [RFT 3/6] wlcore: Add support for runtime PM
Date: Tue, 5 Jun 2018 03:44:04 -0700
Message-ID: <20180605104404.GD5738@atomide.com>
References: <20180529180605.73622-1-tony@atomide.com>
 <20180529180605.73622-4-tony@atomide.com>
 <20180531171420.GQ5705@atomide.com>
 <fe42f9d6bb744cd39e38db8f51c0b74e@ti.com>
 <20180605042000.GA5738@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180605042000.GA5738-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Reizer, Eyal" <eyalr-l0cyMroinI0@public.gmane.org>
Cc: Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, KISHON VIJAY ABRAHAM <kishon-l0cyMroinI0@public.gmane.org>, "Mishol, Guy" <guym-l0cyMroinI0@public.gmane.org>, Luca Coelho <luciano.coelho-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Hahn, Maital" <maitalm-l0cyMroinI0@public.gmane.org>, "Altshul, Maxim" <maxim.altshul-l0cyMroinI0@public.gmane.org>, Shahar Patury <shaharp-l0cyMroinI0@public.gmane.org>, "linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [180605 04:22]:
> * Reizer, Eyal <eyalr-l0cyMroinI0@public.gmane.org> [180603 06:07]:
> > I have noticed the following recovery a couple of times on my setup when the board was 
> > just sitting for a long time with just pings
> > It starts with a firmware recovery started from the interrupt handler but the recovery fails 
> 
> Sounds like the recovery needs some more work :)
> 
> > leaving the sdio stuck.
> > At this stage the only way to get out of it is unload/load of the driver modules.
> > Have you seen this on your side as well?
> 
> Hmm I don't think I've seen this one yet.
> 
> > 64 bytes from 192.168.100.1: seq=32772 ttl=64 time=9.644 ms
> > 64 bytes from 192.168.100.1: seq=32773 ttl=64 time=9.572 ms
> > 64 bytes from 192.168.100.1: seq=32774 ttl=64 time=10.974 ms
> > 64 bytes from 192.168.100.1: seq=32775 ttl=64 time=9.618 ms
> > [127899.040526] wlcore: ERROR SW watchdog interrupt received! starting recovery.
> 
> Do you know what does the SW watchdog means here? Does it mean the
> interrupt did not get delivered to wlcore? Or a spurious IRQ to wlcore?
> Or a timeout waiting for the ELP wake interrupt?

Also, can you check if patch "[RFT 7/6] wlcore: Make sure firmware is initialized
in wl1271_op_add_interface()" already fixes this issue if you did not have it
already applied?

Regards,

Tony
