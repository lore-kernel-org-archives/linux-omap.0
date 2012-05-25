From: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv9 06/10] I2C: OMAP: Fix the crash in i2c remove
Date: Fri, 25 May 2012 14:51:34 -0700
Message-ID: <878vggkjyx.fsf@ti.com>
References: <1335969135-20858-1-git-send-email-shubhrajyoti@ti.com>
	<1335969135-20858-7-git-send-email-shubhrajyoti@ti.com>
	<20120512181019.GA28973@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120512181019.GA28973-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> (Wolfram Sang's message
	of "Sat, 12 May 2012 20:10:19 +0200")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Wolfram,

Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> writes:

> On Wed, May 02, 2012 at 08:02:11PM +0530, Shubhrajyoti D wrote:
>>     In omap_i2c_remove we are accessing the I2C_CON register without
>>     enabling the clocks. Fix the same by enabling the clocks and disabling
>>     it.

[...]

> I'd really like a comment from the PM experts if each and every driver
> has to ensure that the clocks are enabled on remove like this?

Yes, this is correct.

In fact, this is the goal of runtime PM.  The driver itself tells the PM
core (using runtime PM) when the device needs to be accessible and when
it doesn't.

Technically speaking, the it's up to the platform-specific runtime PM
implementation to decide whether or not the clocks are actually disable
or not  (e.g. due to wakeup latency requirements, it might decide not to
cut clocks.)

Because of that, the changelog should be reworded to say something like
"ensure device is accessible" instead of "enable the clocks", because
the runtime PM implementation does more than just manage clocks.

Kevin

P.S. It's great to see you helping out maintaining i2c drivers.  Thanks!

P.P.S. Before you merge this, I would strongly recommend we wait for a
       few more Tested-bys, and a bit more description about how this
       was tested.  We've been having quite a few problems with
       regressions introduced in OMAP drivers that have not been well
       reviewed or tested.
