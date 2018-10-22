From: Tony Lindgren <tony@atomide.com>
Subject: Re: omap4: support for manually updated display
Date: Mon, 22 Oct 2018 11:43:14 -0700
Message-ID: <20181022184314.GG43338@atomide.com>
References: <20180830090456.GA17277@amd>
 <797c13fa-7a5b-a809-7dd0-14b01a3046be@ti.com>
 <3205865.8O8aibZXye@avalon>
 <20180910174453.GV5662@atomide.com>
 <20181018221549.GB6364@amd>
 <20181019164450.GD43338@atomide.com>
 <20181019225827.s76wapp3cxrmp5af@earth.universe>
 <20181020003812.GE43338@atomide.com>
 <6ebd84ad-3428-c2f5-da8b-e5b1c54ea5e2@ti.com>
 <20181022163134.GF43338@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181022163134.GF43338@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Sebastian Reichel <sre@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Pavel Machek <pavel@ucw.cz>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [181022 16:31]:
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [181022 08:14]:
> > On 20/10/18 03:38, Tony Lindgren wrote:
> > > * Sebastian Reichel <sre@kernel.org> [181019 15:58]:
> > >> I uploaded my current status here. It's not based on the newest
> > >> -next, but contains the interesting patches from Laurent. Also
> > >> the last few patches are not yet cleaned up, sorry for the mess.
> > > 
> > > Way to go, thanks :) Here's a quick fix for issues with loading
> > > and unloading modules, seems like this should be fixed somewhere
> > > else though?
> 
> Sorry one oops was for rmmod, the other one was for modprobe.
> 
> > I didn't get that far on drm-next with pandaboard. When loading modules, dsi_probe crashes. It is missing runtime_get(). But after adding runtime_get call, it fails and I see:
> > 
> > [   44.671081] omap_hwmod: dss_dsi2: _wait_target_ready failed: -16
> > [   44.677459] omapdss_dsi 58005000.encoder: use pm_runtime_put_sync_suspend() in driver?
> > 
> > Why is dsi2 busy (and what does it even mean)...
> 
> Hmm below segfault is what I see on pandaboard-es with
> next-20181019 with no extra patches.

And git bisect points to these issues starting with commit
27d624527d99 ("drm/omap: dss: Acquire next dssdev at probe time")
if that might help.

Regards,

Tony
