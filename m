From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 0/4] phy: ti-pipe3: fixes for 3.19-rc
Date: Tue, 24 Feb 2015 10:02:06 -0800
Message-ID: <20150224180206.GA11056@atomide.com>
References: <1421151802-7396-1-git-send-email-rogerq@ti.com>
 <20150113155409.GA2419@atomide.com>
 <54E44694.4070801@ti.com>
 <54E448B2.80103@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <54E448B2.80103@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: kishon@ti.com, nm@ti.com, balbi@ti.com, george.cherian@ti.com, nsekhar@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Roger Quadros <rogerq@ti.com> [150218 00:13]:
> On 18/02/15 10:00, Roger Quadros wrote:
> > On 13/01/15 17:54, Tony Lindgren wrote:
> >> * Roger Quadros <rogerq@ti.com> [150113 04:26]:
> >>> Hi,
> >>>
> >>> During system suspend L3INIT_960M_GFCLK and L3INIT_480M_GFCLK clocks remain
> >>> active on the DRA7 platform. This is because the pipe3 driver doesn't shut
> >>> them off as part of .suspend(). Patch 1 addresses this issue.
> >>>
> >>> SATA on both OMAP5 and DRA7 breaks when SATA drive is plugged in after a
> >>> system suspend/resume or if AHCI_PLATFORM driver is used as module.
> >>> Patches 2,3,4 fix it.
> >>>
> >>> Hope to get these patches in through the 3.19-rc cycle.
> >>>
> >>> Tony,
> >>>
> >>> Do you wish to take the DTS patches or let them go in through PHY tree?
> >>
> >> Those look ok to me to merge along with the fixes, will ack those two.
> >>
> > 
> > Looks like this missed 3.19-rc. My bad for not following up.
> > 
> > Kishon, can you please queue these for 3.20-rc? Thanks.
> 
> Well the PHY patches (1 and 2) are already queued for v3.20-rc1 via Greg's usb-next tree.
> Tony can you please queue the DT side patches for v3.20? Thanks.

Applying these into omap-for-v4.0/fixes. Lookse like we're a few
kernel releases behind with these :)

Tony
