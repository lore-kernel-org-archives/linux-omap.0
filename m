From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 12/23] drm: omapdrm: plane: update fifo size on atomic update
Date: Wed, 14 Dec 2016 23:36:50 +0200
Message-ID: <6335179.lCaUdnt7KS@avalon>
References: <1457455195-1938-1-git-send-email-sre@kernel.org> <a60e0657-e0cd-839c-20ea-d29a73e198ff@ti.com> <20161214140308.bpbykzp6yfghxfn6@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161214140308.bpbykzp6yfghxfn6@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, dri-devel@lists.freedesktop.org, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Sebastian,

(CC'ing Peter Ujfalusi)

On Wednesday 14 Dec 2016 15:03:08 Sebastian Reichel wrote:
> On Wed, Dec 14, 2016 at 11:14:32AM +0200, Tomi Valkeinen wrote:
> > On 14/12/16 11:10, Laurent Pinchart wrote:
> >> On Wednesday 14 Dec 2016 10:43:18 Tomi Valkeinen wrote:
> >>> On 13/12/16 19:35, Laurent Pinchart wrote:
> >>>> On Tuesday 08 Mar 2016 17:39:44 Sebastian Reichel wrote:
> >>>>> This is a workaround for a hardware bug occuring
> >>>>> on OMAP3 with manually updated panels.
> >>>> 
> >>>> Could you please explain what the bug is and how the workaround
> >>>> operates ? Do you have a reference to an errata document ?
> 
> FWIW I don't know anything about this bug. I just hit it while
> getting omapdrm working on n950 and ported this over from omapfb.

I wonder if it's a bug or an expected behaviour. In any case, looking at the 
FIFO thresholds computation function it's quite clear that we need to 
recompute and set the values when the panel mode changes. Maybe you should 
explain this in the commit message.

> >>> I don't think I ever found out exactly why the problem happens. But on
> >>> OMAP3 DSI, the fifo thresholds had to be tuned slightly, otherwise
> >>> DISPC would stop. dispc_ovl_compute_fifo_thresholds() does that tuning
> >>> if "manual_update" parameter is set on OMAP3.
> >> 
> >> I've had a look at dispc_ovl_compute_fifo_thresholds() and the patch
> >> makes sense to me. If Sebastian could address the small issues I pointed
> >> out, we could then merge this. Alternatively I can take care of
> >> addressing them.
> > 
> > It's only needed with the rest of the DSI manual update series, so I'd
> > rather keep it as part of that series.
> 
> To be honest I haven't worked on this for some time. From some
> comments on the patchset I think the biggest issue is, that omapdrm
> does not use generic panel drivers and cannot easily use the
> mipi_dsi_driver_register. I simply did not have enough time to
> implement such a huge change.

I'll probably give it a go at some point, but it will take time.

> I guess a first step is Peter Ujfalusi's series:
> https://lkml.org/lkml/2016/9/1/267

Peter, do you plan to respin that patch series ?

-- 
Regards,

Laurent Pinchart
