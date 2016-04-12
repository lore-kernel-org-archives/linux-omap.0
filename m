From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] of: Add generic handling for hardware incomplete fail
 state
Date: Tue, 12 Apr 2016 15:02:45 -0700
Message-ID: <20160412220244.GK5995@atomide.com>
References: <1460486275-12256-1-git-send-email-tony@atomide.com>
 <570D56FE.2070408@gmail.com>
 <20160412203431.GU5995@atomide.com>
 <570D6B7A.3050203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <570D6B7A.3050203-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Tom Rini <trini-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [160412 14:42]:
> On 4/12/2016 1:34 PM, Tony Lindgren wrote:
> > 
> > OK thanks for the clarification. I don't see why "fail-hw-incomplete"
> > could not be set dynamically during the probe in some cases based
> > on the SoC revision detection for example. So from that point of
> > view using status with the "fail-sss" logic would make more sense.
> 
> If the probe detects that the device should only be power managed
> based on the SoC revision, then it would simply be one more
> test added at the top of probe.  The patch would change from:
> 
>    if (of_device_is_incomplete(pdev->dev.of_node)) {
> 
> to:
> 
>    if (of_device_is_incomplete(pdev->dev.of_node) || socrev == XXX) {
> 
> That code would be the same whether the property involved was
> status or something else.

Yeah that should work if we had a generic way to get the runtime
socrev somehow :) I guess the closest thing is the ARM system_rev.

> >> I would prefer to come up with a new boolean property (with a
> >> standard name that any node binding could choose to implement)
> >> that says something like "only power management is available for
> >> this node, do not attempt to use any other feature of the node".
> > 
> > Heh that's going to be a long property name :) How about
> > unusable-incomplete-idle-only :)
> 
> Or even pm-only.  Maybe I got a little carried away with my
> verbosity. :)

That works for me unless somebody comes up with a better one.
I can only think unusable-for-io, which is no better.

> >> With that change, the bulk of your patch looks good, with
> >> minor changes:
> >>
> >>   __of_device_is_available() would not need to change.
> >>
> >>   __of_device_is_incomplete() would change to check the new
> >>   boolean property.  (And I would suggest renaming it to
> >>   something that conveys it is ok to power manage the
> >>   device, but do not do anything else to the device.)
> > 
> > I'm fine with property too, but the runtime probe fail state
> > changes worry me a bit with that one.
> 
> I don't understand what the concern is.  The change I suggested
> would use exactly the same code for probe as the example patch
> you provided, but just with a slight name change for the function.

I guess I'm just wondering if using property vs status will make
things harder to change during runtime. For example, let's assume
u-boot needs to set some devices to "pm-only" state based on the
SoC revision on a board.

> > I think Rob also preferred to use the status though while we
> > chatted at ELC?
> 
> That is the impression I got too.  We'll have to see if I can
> convince him otherwise.

Yeah let's wait for his comments.

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
