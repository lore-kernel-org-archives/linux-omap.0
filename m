From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/7] thermal: ti-soc-thermal: Migrate slope/offset data
 to device tree
Date: Tue, 7 Mar 2017 07:12:28 -0800
Message-ID: <20170307151227.GR20572@atomide.com>
References: <1488364190-23488-1-git-send-email-j-keerthy@ti.com>
 <20170306184215.GO20572@atomide.com>
 <1c47d169-7962-2fe7-0635-570881e85e06@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1c47d169-7962-2fe7-0635-570881e85e06@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: edubezval@gmail.com, rui.zhang@intel.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, robh+dt@kernel.org, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org

* Keerthy <j-keerthy@ti.com> [170306 23:15]:
> 
> 
> On Tuesday 07 March 2017 12:12 AM, Tony Lindgren wrote:
> > * Keerthy <j-keerthy@ti.com> [170301 02:31]:
> > > Currently the slope and offset values for calculating the
> > > hot spot temperature of a particular thermal zone is part
> > > of driver data. Pass them here instead and obtain the values
> > > while of node parsing.
> > > 
> > > Tested for the slope and constant values on DRA7-EVM.
> > > 
> > > Keerthy (7):
> > >   ARM: DRA7: Thermal: Add slope and offset values
> > >   ARM: OMAP5: Thermal: Add slope and offset values
> > >   ARM: OMAP443x: Thermal: Add slope and offset values
> > >   ARM: OMAP4460: Thermal: Add slope and offset values
> > >   thermal: ti-soc-thermal: Fetch slope and offset from DT
> > >   thermal: ti-soc-thermal: Remove redundant constants
> > >   thermal: ti-soc-thermal: Remove redundant code
> > 
> > Are the dts changes safe for me to pick separately into
> > omap-for-v4.12/dt?
> 
> Tony,
> 
> Seems like omap3 has no thermal_zone node defined in Device Tree.
> It seems like it still uses driver data. I would need to add that as well.
> Can you confirm that? If yes i will send a new series with the omap3 device
> tree changes as well.

OK cool. It might be worth checking how it was configured with
the legacy platform data.

Regards,

Tony
