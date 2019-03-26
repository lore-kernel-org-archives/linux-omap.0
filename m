From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 09/14] bus: ti-sysc: Move rstctrl reset to happen later
Date: Tue, 26 Mar 2019 16:40:22 -0700
Message-ID: <20190326234022.GD49658@atomide.com>
References: <20190325215849.13182-1-tony@atomide.com>
 <20190325215849.13182-10-tony@atomide.com>
 <20190326231306.GC49658@atomide.com>
 <b6bd2b04-00b4-6730-4401-6ac95e75322a@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b6bd2b04-00b4-6730-4401-6ac95e75322a@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Suman Anna <s-anna@ti.com>
Cc: linux-omap@vger.kernel.org, Dave Gerlach <d-gerlach@ti.com>, Faiz Abbas <faiz_abbas@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Roger Quadros <rogerq@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

* Suman Anna <s-anna@ti.com> [190326 23:22]:
> On 3/26/19 6:13 PM, Tony Lindgren wrote:
> Hmm, are you envisioning the SYSC reset (OCP SoftReset) here or the PRCM
> RSTCTRL hardresets here? The latter in general requires the clocks to be
> running first (module won't be in ready status until you deassert the
> hardresets with clocks running). You can look up the Warm-reset or
> Cold-reset sequences in the TRMs for any of the processors.

That's for rstctrl. I just did a quick test with my earlier
reset-simple patch and I noticed sgx on am33xx produces a
clock error unless we deassert it's rstrctrl before enabling
clocks first:

gfx-l3-clkctrl:0004:0: failed to enable

> I am working on preparing the next version of PRUSS patches with ti-sysc
> on AM33xx/AM437x/AM57xx platforms, so will pick up these patches for my
> testing.

OK great, yes please check and test with your rstctrl use case.
I guess you still need to use the reset-simple patch for now
until we have a proper prm rstctrl driver.

Note that you probably also want to leave out the struct
omap_hwmod data from omap_hwmod_*_data.c files with rstctrl
entries.

Regards,

Tony
