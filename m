From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v5 8/8] ARM: DTS: dra7x: Integrate sDMA crossbar
Date: Tue, 14 Jul 2015 03:28:56 -0700
Message-ID: <20150714102855.GL17550@atomide.com>
References: <1428572154-3548-1-git-send-email-peter.ujfalusi@ti.com>
 <1428572154-3548-9-git-send-email-peter.ujfalusi@ti.com>
 <20150409151846.GR18048@atomide.com>
 <5526C9E5.4070601@ti.com>
 <20150409190126.GT18048@atomide.com>
 <5526CD6A.8010300@ti.com>
 <20150409191206.GU18048@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150409191206.GU18048@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: vinod.koul@intel.com, linux@arm.linux.org.uk, grant.likely@linaro.org, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org, nm@ti.com, arnd@arndb.de, maxime.ripard@free-electrons.com
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [150409 12:17]:
> * Peter Ujfalusi <peter.ujfalusi@ti.com> [150409 12:07]:
> > On 04/09/2015 10:01 PM, Tony Lindgren wrote:
> > > * Peter Ujfalusi <peter.ujfalusi@ti.com> [150409 11:55]:
> > >> On 04/09/2015 06:18 PM, Tony Lindgren wrote:
> > >>> * Peter Ujfalusi <peter.ujfalusi@ti.com> [150409 02:37]:
> > >>>> The sDMA requests are routed through the DMA crossbar and without the
> > >>>> crossbar only peripherals using DMA request 0-127 can be used.
> > >>>
> > >>> I assume this can be merged separately from the driver
> > >>> changes?
> > >>
> > >> Unfortunately not. We need to have the drivers in place for the DTS changes to
> > >> work.
> > > 
> > > Right but just merging the driver changes presumably won't
> > > break things?
> > 
> > No, they will not break anything. We just do not have control over the DMA
> > crossbar (in a same way as we don't have control right now).
> 
> OK good to hear.

Looks like the related DMA changes are now merged, so applying this
into omap-for-v4.3/dt thanks.

Tony
