From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [BISECTED, REGRESSION] v4.12-rc: omapdrm fails to probe on Nokia
 N900
Date: Fri, 30 Jun 2017 11:58:51 +0300
Message-ID: <20170630085851.j5apctivufhmhp64@darkstar.musicnaut.iki.fi>
References: <20170614221133.k7gmbzzjsbmbjgbc@darkstar.musicnaut.iki.fi>
 <f7697b9f-b506-bf18-43f9-921ed7f27607@ti.com>
 <20170629185013.aec7qhvrl3waifww@darkstar.musicnaut.iki.fi>
 <e0373c98-a2e3-1231-3aa9-2092d012fe7e@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <e0373c98-a2e3-1231-3aa9-2092d012fe7e@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Fri, Jun 30, 2017 at 09:41:35AM +0300, Tomi Valkeinen wrote:
> On 29/06/17 21:50, Aaro Koskinen wrote:
> > On Thu, Jun 15, 2017 at 09:51:06AM +0300, Tomi Valkeinen wrote:
> >> On 15/06/17 01:11, Aaro Koskinen wrote:
> >>> When booting v4.12-rc5 on Nokia N900, omapdrm fails to probe and there
> >>> is no display.
> >>
> >> Are you sure it doesn't probe? It fails the omapdss_stack_is_ready()
> >> check?
> > 
> > It appears the reason was that I didn't have
> > CONFIG_DRM_OMAP_CONNECTOR_ANALOG_TV enabled.
> > 
> > I think that's wrong. I don't own an analog TV, so why should I enable
> > such option to get device's built-in display working?
> 
> Indeed. Unfortunately I don't have a solution for that.
> 
> DRM doesn't support adding devices after probe. So at omapdrm probe time
> we have to decide which displays to use. In the dts file, n900 defines
> the lcd and analog tv. omapdrm sees those, and, of course, must wait
> until their respective drivers have probed. If you don't have the
> display driver enabled, it's never loaded and omapdrm never probes as it
> keeps waiting for those.

Could you at least print some kind of message early in the boot ("omapdrm
is waiting for drivers for display x and y")?

A.
