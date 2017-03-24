From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 0/8] thermal: ti-soc-thermal: Migrate slope/offset
 data to device tree
Date: Fri, 24 Mar 2017 07:26:10 -0700
Message-ID: <20170324142610.GX10760@atomide.com>
References: <1489046762-11288-1-git-send-email-j-keerthy@ti.com>
 <64ab8413-6cf1-864f-0550-9c8db59523f7@ti.com>
 <20170323205256.GO10760@atomide.com>
 <a410d37f-92e5-39b4-ac6c-158673163cb0@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <a410d37f-92e5-39b4-ac6c-158673163cb0@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: edubezval@gmail.com, rui.zhang@intel.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, robh+dt@kernel.org, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org

* Keerthy <j-keerthy@ti.com> [170323 20:29]:
> 
> 
> On Friday 24 March 2017 02:22 AM, Tony Lindgren wrote:
> > * Keerthy <j-keerthy@ti.com> [170321 20:45]:
> >>
> >>
> >> On Thursday 09 March 2017 01:35 PM, Keerthy wrote:
> >>> Currently the slope and offset values for calculating the
> >>> hot spot temperature of a particular thermal zone is part
> >>> of driver data. Pass them here instead and obtain the values
> >>> while of node parsing.
> >>>
> >>> Tested for the slope and constant values on DRA7-EVM, OMAP3-BEAGLE. 
> >>
> >> Hi Eduardo,
> >>
> >> If the series looks okay could you please pull this?
> > 
> > Also.. Are the dts changes safe for me to pick separately?
> 
> Yes Tony they are safe to pulled separately.

OK applying patches 1 - 5 of this series into omap-for-v4.12/dt-v2.

Thanks,

Tony
