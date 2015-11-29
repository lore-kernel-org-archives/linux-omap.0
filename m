From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [PATCH 5/5] arm: boot: store ATAGs structure into DT
 "/chosen/linux,atags" entry
Date: Sun, 29 Nov 2015 18:09:39 +0000
Message-ID: <20151129180939.GE30871@n2100.arm.linux.org.uk>
References: <20150713131902.GH26485@atomide.com>
 <20151127132722.GA30871@n2100.arm.linux.org.uk>
 <20151127195148.GB30871@n2100.arm.linux.org.uk>
 <11537945.4HX4Y84tjV@wuerfel>
 <alpine.LFD.2.20.1511271817230.22569@knanqh.ubzr>
 <20151128123328.GC30871@n2100.arm.linux.org.uk>
 <alpine.LFD.2.20.1511281232440.22569@knanqh.ubzr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.20.1511281232440.22569-fMhRO7WWcppj+hNMo8g0rg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nicolas Pitre <nicolas.pitre-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Laura Abbott <lauraa-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Sebastian Reichel <sre-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber-l3A5Bk7waGM@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Sat, Nov 28, 2015 at 12:34:23PM -0500, Nicolas Pitre wrote:
> Good. And Arnd likes the idea too. So we might be converging at last 
> which is a good thing.

I disagree with the idea that there is convergence.  There might be
convergence towards an idea, but... Here's a mail extract, from July
7th, from earlier in this very thread:

Pali:
> Me:
> > Are the ATAGs at a fixed address on the N900?
> 
> Yes, in board-rx51.c is:
> 
> .atag_offset    = 0x100
> 
> and Nokia Bootloader (proprietary) store them to that address.
> 
> > Can that be handled in
> > some kind of legacy file for the N900 which calls save_atags() on it, so
> > we don't end up introducing yet more stuff that we have to maintain into
> > the distant future?  If not, what about copying a known working atag
> > structure into a legacy file for the N900?
> >
> 
> I already asked question if it is possible to read ATAGs from DT booted
> kernel. And somebody (do not remember who) wrote to ML, that it is not
> possible and it can be done in that uncompress code.

So you're converging on an idea that has already been rejected.  That's
not a good thing, IMHO.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
