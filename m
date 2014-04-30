From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH/RFC 3/4] of/clk: Register clocks suitable for Runtime PM with the PM core
Date: Wed, 30 Apr 2014 23:25:35 +0200
Message-ID: <2401458.kIFL7AxWq0@avalon>
References: <1398334403-26181-1-git-send-email-geert+renesas@glider.be> <7hoazpdldx.fsf@paris.lan> <20140429131610.29859C4094A@trevor.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140429131610.29859C4094A-WNowdnHR2B42iJbIjFUEsiwD8/FfD2ys@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tuesday 29 April 2014 14:16:10 Grant Likely wrote:
> On Fri, 25 Apr 2014 16:44:58 -0700, Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> > Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org> writes:
> > > When adding a device from DT, check if its clocks are suitable for
> > > Runtime PM, and register them with the PM core.
> > > If Runtime PM is disabled, just enable the clock.
> > > 
> > > This allows the PM core to automatically manage gate clocks of devices
> > > for Runtime PM.
> > 
> > ...unless the device is already in an existing pm_domain, right?
> > 
> > I like this approach, and it extends nicely what we already do on
> > platforms using drivers/base/power/clock_ops.c into DT land.
> > 
> > My only concern is how this will interact if it's used along with
> > devices that have existing pm_domains.  I don't have any specific
> > concerns (yet, because it's Friday, and my brain is turing off), but it
> > just made me wonder if this will be potentially confusing.
> 
> I have big concerns about this approach. First, it will only work if
> a clock is available at deivce creation time. The conversion of irq
> controllers to normal device drivers has already shown that is a bad
> idea.
> 
> I also don't like that it tries to set up every clock, but there is no
> guarantee that the driver will even use it. I would rather see this
> behaviour linked into the function that obtains the clock at driver
> .probe() time. That way it can handle deferred probe correctly and it
> only sets up clocks that are actually used by the driver.

I like the idea, as it gives an opt-in approach to the problem: drivers could 
decide whether they want the runtime PM core to handle clocks automatically 
(which should cover most cases), but would have the option of handling clocks 
manually if needed for special purposes.

-- 
Regards,

Laurent Pinchart

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
