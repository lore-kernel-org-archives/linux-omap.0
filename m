From: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH v4 00/18] I2C: OMAP: I2C fixes, removal of cpu_is...
	from driver
Date: Fri, 8 Jul 2011 00:01:22 +0100
Message-ID: <20110707230122.GM15795@trinity.fluff.org>
References: <1306973984-15165-1-git-send-email-khilman@ti.com> <20110615213637.GH15795@trinity.fluff.org> <87k4cm1xgj.fsf@ti.com> <1309212726.6231.14.camel@vence> <1309212918.6231.16.camel@vence> <1309892457.3077.8.camel@vence>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1309892457.3077.8.camel@vence>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
Cc: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andy Green <andy.green-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Jul 05, 2011 at 12:00:56PM -0700, Kevin Hilman wrote:
> Hi Ben,
> 
> On Mon, 2011-06-27 at 15:15 -0700, Kevin Hilman wrote:
> > On Mon, 2011-06-27 at 15:12 -0700, Kevin Hilman wrote:
> > 
> > > Ping.  I don't see this in linux-next yet.
> > > 
> > > Are you planning to queue this for v3.1?
> > > 
> > 
> > Oops, pushed send too soon on this...
> > 
> > As this series touches various data files in arch/arm/mach-omap2/* and
> > we have a handful of other changes to that data for this merge window, I
> > think it would be better for conflict avoidance if this series is merged
> > via Tony's linux-omap tree.
> > 
> > With your Ack, we'll merge it via OMAP.
> 
> I see that the same day I sent this, you merged it into your next-i2c
> branch.  Guess I was too late with my request.
> 
> As I mentioned above, we will have several conflicts with the
> arch/arm/mach-omap2 changes in this series, so we would prefer to merge
> them via the OMAP tree if at all possible so we can properly handle the
> conflicts.
> 
> Do you mind dropping it from your next-i2c so we can merge it via
> linux-omap (with your Ack.)

Yes, and if you could indicate all the other omap i2c patches and I'll
add my ack to yours.

Acked-by: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>

> Thanks,
> 
> Kevin
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Ben Dooks, ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disappear.
