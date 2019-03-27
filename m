From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 09/14] bus: ti-sysc: Move rstctrl reset to happen later
Date: Wed, 27 Mar 2019 11:37:38 -0700
Message-ID: <20190327183738.GE49658@atomide.com>
References: <20190325215849.13182-1-tony@atomide.com>
 <20190325215849.13182-10-tony@atomide.com>
 <20190326231306.GC49658@atomide.com>
 <b6bd2b04-00b4-6730-4401-6ac95e75322a@ti.com>
 <20190326234022.GD49658@atomide.com>
 <cd0bce74-4af7-bcde-2552-e12c8d1c9da4@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cd0bce74-4af7-bcde-2552-e12c8d1c9da4@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Suman Anna <s-anna@ti.com>
Cc: linux-omap@vger.kernel.org, Dave Gerlach <d-gerlach@ti.com>, Faiz Abbas <faiz_abbas@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Roger Quadros <rogerq@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Suman Anna <s-anna@ti.com> [190327 16:27]:
> On 3/26/19 6:40 PM, Tony Lindgren wrote:
> > That's for rstctrl. I just did a quick test with my earlier
> > reset-simple patch and I noticed sgx on am33xx produces a
> > clock error unless we deassert it's rstrctrl before enabling
> > clocks first:
> > 
> > gfx-l3-clkctrl:0004:0: failed to enable
> 
> Yeah, and I see a similar one across the other modules controlled by
> RSTCTRL bits for me as well - MMUs, PRUSS etc. This is because you can
> only check the module ready status in _omap4_clkctrl_clk_enable() only
> both after the clocks are turned on and resets are deasserted. That
> check will always fail with rstctrl asserted. The omap_hwmod code does
> use the reset status checks for bailing out, but that stuff is not
> present in clkctrl code and can only be achieved by adding a
> CLKF_NO_IDLEST (somewhat misnamed) to the corresponding clkctrl atm.

Sounds like on ti-sysc init we should just deassert the rstctrl if
asserted, then enable clocks, and then read the revision.

Then if we actually need to toggle rstctrl reset, that can be added
with later patches. But with reset driver, the device IP handling
device driver(s) should probably manage the rstctrl bits directly.

> See [1] for AM33xx SGX. I will be posting some of these once I check the
> behavior.

Yeah OK sounds like we can avoid those issues by deasserting the
module related rstctrl bit before enabling the clocks. Then
deal with resets later if needed.

> > Note that you probably also want to leave out the struct
> > omap_hwmod data from omap_hwmod_*_data.c files with rstctrl
> > entries.
> 
> You mean no hwmod entries at all, or hwmod entries with no rstctrl data?

Except for the lack of rstctrl reset driver, struct hwmod_data
entries should only be needed for the few cases where we're not
yet handling some oh->flags quirks. I think most of the remaining
unhandled quirks are for omap2 and 3.

Regards,

Tony


> [1]
> http://git.ti.com/gitweb/?p=ti-linux-kernel/ti-linux-kernel.git;a=commitdiff;h=536d660714e98bdb7f96e5990a095283e52e4d8a
> 
> 
