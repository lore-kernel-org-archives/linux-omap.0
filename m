From: Tony Lindgren <tony@atomide.com>
Subject: Re: omap4: support for manually updated display
Date: Mon, 10 Sep 2018 10:44:53 -0700
Message-ID: <20180910174453.GV5662@atomide.com>
References: <20180830090456.GA17277@amd>
 <797c13fa-7a5b-a809-7dd0-14b01a3046be@ti.com>
 <3205865.8O8aibZXye@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3205865.8O8aibZXye@avalon>
Sender: linux-kernel-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Pavel Machek <pavel@ucw.cz>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org

* Laurent Pinchart <laurent.pinchart@ideasonboard.com> [180910 12:28]:
> On Monday, 10 September 2018 14:59:23 EEST Tomi Valkeinen wrote:
> > A large omapdrm change set from Laurent was merged into drm-next, and
> > I'm certain they conflict with this series. Laurent also has continued
> > that work, and while those new patches haven't been sent for review yet,
> > I fear they'll also conflict with these.
> > 
> > So in the minimum, a rebase on top of drm-next is needed.
> > 
> > I also continue to be very worried that adding DSI support to omapdrm at
> > this stage will be a huge extra burden for Laurent's work.
> > 
> > We should transform the panel-dsi-cm.c towards the common DRM model.
> > With a quick look, there seems to be a driver for Samsung's S6E63J0X03
> > panel. So possibly all the DSI features are there in the DRM framework,
> > but someone needs to check that and start working on panel-dsi-cm.c so
> > that it's ready when we finally switch to the DRM model.
> > 
> > In my opinion, which I've also expressed before, the above work is much
> > easier to do by first changing the omapdrm to DRM model, without any DSI
> > displays, and then add the DSI command mode support. But if people
> > insist on adding the DSI support already now, I would appreciate the
> > same people working on the DSI support so that Laurent doesn't have to
> > do it all.
> 
> I want to make it clear that I don't want to claim any privilege in getting 
> patches merged first. I am however worried that, without an easy way to test 
> DSI support, and without enough time to focus on it, I would break whatever 
> would be merged now in future reworks. I would thus like to find out how to 
> collaborate on this task, hopefully to move towards usage of drm_bridge and 
> drm_panel for DSI-based pipelines.

Real users with mainline kernel with a real product should
always have priority over any ongoing clean-up.

And for testing, a bunch of real users is something you can't
beat for proper testing of code on ongoing basis!

Naturally the burden of getting the patches ready is on the people
using them for rebase and fixing comments. And Sebastian has
already agreed help with maintaining it.

I've been actually using DSI command mode support and testing
Linux next several times a week to prevent regressions from
sneaking into -rc1 in general. So now I can't test omapdrm with
next until Sebastian is done with rebasing.. Back to headless
testing then.

Anyways, I'd say let's add the DSI command mode support ASAP after
rebasing, there are at least Sebastian, Pavel and I then testing
and helping with further ongoing panel conversion work.

Regards,

Tony
