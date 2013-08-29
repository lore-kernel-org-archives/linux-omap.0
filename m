From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] OMAPDSS: use new display drivers
Date: Thu, 29 Aug 2013 00:07:33 -0700
Message-ID: <20130829070732.GP7656@atomide.com>
References: <521DAC2B.4080100@ti.com>
 <20130829061923.GM7656@atomide.com>
 <521EE98D.9070209@ti.com>
 <20130829063534.GN7656@atomide.com>
 <521EF102.5020607@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:32546 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753830Ab3H2HHf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Aug 2013 03:07:35 -0400
Content-Disposition: inline
In-Reply-To: <521EF102.5020607@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Kevin Hilman <khilman@linaro.org>, Olof Johansson <olof@lixom.net>

* Tomi Valkeinen <tomi.valkeinen@ti.com> [130829 00:05]:
> On 29/08/13 09:35, Tony Lindgren wrote:
> > * Tomi Valkeinen <tomi.valkeinen@ti.com> [130828 23:33]:
> >> On 29/08/13 09:19, Tony Lindgren wrote:
> >>> * Tomi Valkeinen <tomi.valkeinen@ti.com> [130828 00:59]:
> 
> >>> I suggest you keep this branch immutable in case it need to be merged to arm-soc
> >>> tree, and merge it yourself along with the DSS patches. That way you
> >>
> >> I do feel a bit uneasy with merging lots of arch changes via fbdev tree,
> >> but yes, I guess I can do that. Is that an "ack" from you for all the
> >> patches? If I do merge it via fbdev, I want to have at least acked-by in
> >> the commits. If that was an ack, I'll add them, but it means I need to
> >> update the branch.
> > 
> > I would not start messing with the patches at this point to add acks
> > as then your branch is no longer immutable. If you prefer, then it's
> > best that Kevin and Olof merge take this pull request directly.
> 
> Well, the branch was just created yesterday anyway, as I rebased on -rc6
> as you requested.
> 
> I created a new branch with acks, 3.12/linux-omap-acked. I'll keep the
> old branch in place.

Oh OK, please remove the old branch ASAP so Kevin or Olof won't
accidentally pulls it!
 
> >>> don't have a dependency to arm-soc for removal of the old drivers.
> >>
> >> The dependency is run-time dependency, so the removal series does not
> >> need to be based on this. As long as this series is merged first, things
> >> should work.
> > 
> > OK, that's good. The only issue is that we're pretty much out of time
> > right now for v3.12 merge window.
> 
> Yep. Well, maybe it's easier if I try to merge this via fbdev. The
> problem there is that the fbdev maintainer has been inactive more or
> less for the whole summer, so how the pull requests will be managed is a
> bit unclear. But my guess is that I will be handling fbdev, which makes
> merging this series via fbdev easier.

Sounds good to me.

Regards,

Tony
