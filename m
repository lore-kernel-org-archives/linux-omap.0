From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [BISECTED, REGRESSION] v4.12-rc: omapdrm fails to probe on Nokia
 N900
Date: Mon, 19 Jun 2017 00:31:24 +0300
Message-ID: <20170618213124.ilacwpkh34rusliz@darkstar.musicnaut.iki.fi>
References: <20170614221133.k7gmbzzjsbmbjgbc@darkstar.musicnaut.iki.fi>
 <f7697b9f-b506-bf18-43f9-921ed7f27607@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <f7697b9f-b506-bf18-43f9-921ed7f27607@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Thu, Jun 15, 2017 at 09:51:06AM +0300, Tomi Valkeinen wrote:
> On 15/06/17 01:11, Aaro Koskinen wrote:
> > When booting v4.12-rc5 on Nokia N900, omapdrm fails to probe and there
> > is no display.
> 
> Are you sure it doesn't probe? It fails the omapdss_stack_is_ready()
> check? If that's the case then this is easier to debug.

Yes I think so, I added debug prints to omap_connect_dssdevs() and
pdev_probe(), and it's omapdss_stack_is_ready() that is failing.

> > Bisected to:
> > 
> > a09d2bc1503508c17ef3a71c6b1905e3660f3029 is the first bad commit
> > commit a09d2bc1503508c17ef3a71c6b1905e3660f3029
> > Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
> > Date:   Tue May 3 22:08:01 2016 +0300
> > 
> >     drm/omap: Use omapdss_stack_is_ready() to check that the display stack is up
> >     
> >     Instead of 'guessing' based on aliases of the status of the DSS drivers,
> >     use the new interface to check that all needed drivers are loaded.
> >     In this way we can be sure that all needed drivers are loaded so it is
> >     safe to continue the probing of omapdrm.
> >     This method will allow the omapdrm to be probed 'headless', without
> >     outputs.
> >     
> >     Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> >     Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > 
> > Reverting the commit seems to fix the issue.
> 
> This is probably "fixed" by adding the display aliases into the n900 dts
> file. The aliases should not really be required, although they are
> recommended. Without the aliases the order of the displays is random,
> and n900 could end up using tv-out as the first display. But even then,
> the displays should still work.

I'm using up-to-date DTS from the kernel tree.

A.
