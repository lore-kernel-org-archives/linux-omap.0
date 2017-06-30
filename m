From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [BISECTED, REGRESSION] v4.12-rc: omapdrm fails to probe on Nokia
 N900
Date: Fri, 30 Jun 2017 12:37:59 +0300
Message-ID: <20170630093759.okfhlkmcz74ow7lk@darkstar.musicnaut.iki.fi>
References: <20170614221133.k7gmbzzjsbmbjgbc@darkstar.musicnaut.iki.fi>
 <f7697b9f-b506-bf18-43f9-921ed7f27607@ti.com>
 <20170629185013.aec7qhvrl3waifww@darkstar.musicnaut.iki.fi>
 <e0373c98-a2e3-1231-3aa9-2092d012fe7e@ti.com>
 <ef561ff4-c96d-b59c-0df1-dfcac8163259@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <ef561ff4-c96d-b59c-0df1-dfcac8163259@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
List-Id: linux-omap@vger.kernel.org

Hi,

On Fri, Jun 30, 2017 at 11:47:55AM +0300, Tomi Valkeinen wrote:
> > So, I don't know... I guess I need to try to invent some horrible hacks
> > around the driver to somehow manage the omap3 problems. Perhaps
> > disabling/enabling the outputs when sync lost happens...
> 
> Well, I tried that (attached), but it didn't work either. For some
> reason the error worker seems to stop after the disable. Possibly the
> irq flood keeps it from running, so maybe it should catch all the errors
> (I see underflows too).
> 
> Sorry, but I can't use more time on this today, and I'm leaving for
> vacation today. I hope Laurent can help during my absence.
> 
> We could try reverting the patch you mention, but I think it doesn't
> cause the problem.

True, reverting the patch only allows me to use display without connector.
And apparently it just works by luck.

> Did you have CONFIG_DRM_OMAP_CONNECTOR_ANALOG_TV enabled earlier when
> things worked?

No. I have never enabled it before, I didn't even know it was supported
by the mainline.

> If you didn't, and the dts did not contain display aliases, I think the
> omapdrm may have started without TV. So maybe the TV side is the culprit,
> somehow (I couldn't find anything when I looked at that side either).

Could be. 

Here is the summary from my testing:

0) v4.17-rc7 + connector disabled

	==> nothing happens, omapdrm waits forever for connector driver

1) v4.17-rc7 + connector disabled +
   Revert "drm/omap: Use omapdss_stack_is_ready()"

	==> LCD error flood, system unusable

2) v4.17-rc7 + connector disabled +
   Revert "drm/omap: Use omapdss_stack_is_ready()" +
   Apply "drm/omap: work-around for omap3 display enable"

	==> display works!

3) v4.17-rc7 + connector enabled +
   Revert "drm/omap: Use omapdss_stack_is_ready()" +
   Apply "drm/omap: work-around for omap3 display enable"

	==> LCD error flood, system unusable

4) v4.17-rc7 + connector enabled +
   Apply "drm/omap: work-around for omap3 display enable"

	==> LCD error flood, system unusable

A.
