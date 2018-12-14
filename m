From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/4] phy: ti: usb2: Fix logic on -EPROBE_DEFER
Date: Fri, 14 Dec 2018 09:23:59 -0800
Message-ID: <20181214172359.GV6707@atomide.com>
References: <1544022206-2300-1-git-send-email-rogerq@ti.com>
 <1544022206-2300-2-git-send-email-rogerq@ti.com>
 <5C137AE2.4080803@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5C137AE2.4080803@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: kishon@ti.com, robh+dt@kernel.org, nsekhar@ti.com, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Roger Quadros <rogerq@ti.com> [181214 09:42]:
> Kishon,
> 
> On 05/12/18 17:03, Roger Quadros wrote:
> > If clk_get() returns -EPROBE_DEFER then we should just
> > return instead of falling back to old clock name.
> > 
> > Use clk_prepare_enable() and clk_disable_unprepare() instead
> > of splitting up prepare/unprepare from enable/disable.
> > 
> > Signed-off-by: Roger Quadros <rogerq@ti.com>
> 
> I think you should pick this one for -next independently of the rest
> of the series as Tony's ti-sysc patches might cause this issue to trigger
> due to re-ordering of devices.

Yes good idea. FYI, the reason why we can start seeing deferred
probe happen for some new devices with the ti-sysc changes is
because we group the devices by the l4 interconnect and probe
the interconnect instances separately.

Regards,

TOny
