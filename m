From: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>
Subject: Re: [PATCH V2 00/19] irqchip: crossbar: driver fixes
Date: Fri, 13 Jun 2014 12:37:14 -0400
Message-ID: <20140613163714.GR8664@titan.lakedaemon.net>
References: <1402574007-13987-1-git-send-email-r.sricharan@ti.com>
 <20140613150122.GP8664@titan.lakedaemon.net>
 <1402676074.12385.40.camel@joe-AO725>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1402676074.12385.40.camel@joe-AO725>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
Cc: Sricharan R <r.sricharan-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, santosh.shilimkar-l0cyMroinI0@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Fri, Jun 13, 2014 at 09:14:34AM -0700, Joe Perches wrote:
> On Fri, 2014-06-13 at 11:01 -0400, Jason Cooper wrote:
> > Please format the subject lines like so:
> > 
> >   irqchip: crossbar: Set cb pointer ...
> >                      ^
> >                      |
> >                      \-- note the capitalization
> 
> I suggest you don't make this a rule and focus
> on more important stuff instead.

It's not my rule.  ;-)

> Nobody is going to write tools that parse the
> changelogs by "git log --format=%s" for case
> sensitivity.
> 
> As is, it's about half/half.
> 
> $ git log --format=%s --no-merges drivers/irqchip/ | \
>   grep "^irqchip:" | cut -f3- -d":"

Yeah, we haven't been perfect in the past, and a lot of stuff was merged
without going though tglx's tree.  That's why I was asked to help out.

Either I'm fixing up the subject line as I apply the patch, or, I kindly
ask the submitter to fix it up during a re-spin.

thx,

Jason.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
