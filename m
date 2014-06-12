From: Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH V2 08/19] irqchip: crossbar: fix checkpatch warning
Date: Thu, 12 Jun 2014 09:05:59 -0700
Message-ID: <1402589159.12385.4.camel@joe-AO725>
References: <1402574007-13987-1-git-send-email-r.sricharan@ti.com>
	 <1402574007-13987-9-git-send-email-r.sricharan@ti.com>
	 <20140612131042.GU8664@titan.lakedaemon.net> <5399AC9C.4080602@ti.com>
	 <1402582711.9947.17.camel@joe-AO725>
	 <20140612153226.GE8664@titan.lakedaemon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140612153226.GE8664-u4khhh1J0LxI1Ri9qeTfzeTW4wlIGRCZ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>
Cc: Sricharan R <r.sricharan-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, santosh.shilimkar-l0cyMroinI0@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thu, 2014-06-12 at 11:32 -0400, Jason Cooper wrote:

Hi Jason.

> > But bugfix backports haven't been much of an issue in
> > other subsystems with fairly active whitespace/style
> > changes.
> 
> Most of the mvebu fixes we've had that failed to apply were generally
> due to a large whitespace change (dts node shuffling, admittedly not
> checkpatch-related).

So not due to this.

>   I've also frequently been stymied by code cleanups
> when using git blame to find the commit introducing a regression.

git blame -w can frequently help there.

> So, my general rule is: If you're submitting a patch to make checkpatch
> be quiet, re-assess the need.  If you're making changes and you can fix
> some checkpatch items while you're there, then do so.

Decent rule.

> There are certainly legitimate checkpatch-only patches, I just don't
> think this is one qualifies.

Of course it's the maintainer's choice (and last I saw,
that's you) to ignore whatever doesn't fit the appropriate
vision for the code.

$ ./scripts/get_maintainer.pl -f drivers/irqchip/irq-crossbar.c
Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org> (maintainer:IRQCHIP DRIVERS)
Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org> (maintainer:IRQCHIP DRIVERS)
...

cheers, Joe

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
