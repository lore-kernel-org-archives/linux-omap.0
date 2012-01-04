From: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] OMAP/I2C - Fix timeout problem during suspend.
Date: Wed, 04 Jan 2012 14:19:48 -0800
Message-ID: <87boqjaz5n.fsf@ti.com>
References: <20111230124030.12c3d02c@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20111230124030.12c3d02c-wvvUuzkyo1EYVZTmpyfIwg@public.gmane.org> (NeilBrown's message of
	"Fri, 30 Dec 2011 12:40:30 +1100")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

+Felipe

NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org> writes:

> On a board with OMAP3 processor and TWL4030 Power management,
> we need to talk to the TWL4030 during late suspend but cannot
> because the I2C interrupt is disabled (as late suspend disables
> interrupt).

I'm not convinced this is the right solution to this problem.

IMO, this problem is caused by the MUSB driver being broken for
suspend/resume.  I've reported this problem (and an RFC/PATCH)
already[1], but I don't think the driver has been fixed.

Can you try my patch[1] to see if it fixes your problem as well?

Kevin

[1] http://marc.info/?l=linux-omap&m=132252827112721&w=2
