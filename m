From: Suman Anna <s-anna@ti.com>
Subject: Re: [PATCH 09/14] bus: ti-sysc: Move rstctrl reset to happen later
Date: Wed, 27 Mar 2019 11:27:06 -0500
Message-ID: <cd0bce74-4af7-bcde-2552-e12c8d1c9da4@ti.com>
References: <20190325215849.13182-1-tony@atomide.com>
 <20190325215849.13182-10-tony@atomide.com>
 <20190326231306.GC49658@atomide.com>
 <b6bd2b04-00b4-6730-4401-6ac95e75322a@ti.com>
 <20190326234022.GD49658@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190326234022.GD49658@atomide.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Dave Gerlach <d-gerlach@ti.com>, Faiz Abbas <faiz_abbas@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Roger Quadros <rogerq@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On 3/26/19 6:40 PM, Tony Lindgren wrote:
> Hi,
> 
> * Suman Anna <s-anna@ti.com> [190326 23:22]:
>> On 3/26/19 6:13 PM, Tony Lindgren wrote:
>> Hmm, are you envisioning the SYSC reset (OCP SoftReset) here or the PRCM
>> RSTCTRL hardresets here? The latter in general requires the clocks to be
>> running first (module won't be in ready status until you deassert the
>> hardresets with clocks running). You can look up the Warm-reset or
>> Cold-reset sequences in the TRMs for any of the processors.
> 
> That's for rstctrl. I just did a quick test with my earlier
> reset-simple patch and I noticed sgx on am33xx produces a
> clock error unless we deassert it's rstrctrl before enabling
> clocks first:
> 
> gfx-l3-clkctrl:0004:0: failed to enable

Yeah, and I see a similar one across the other modules controlled by
RSTCTRL bits for me as well - MMUs, PRUSS etc. This is because you can
only check the module ready status in _omap4_clkctrl_clk_enable() only
both after the clocks are turned on and resets are deasserted. That
check will always fail with rstctrl asserted. The omap_hwmod code does
use the reset status checks for bailing out, but that stuff is not
present in clkctrl code and can only be achieved by adding a
CLKF_NO_IDLEST (somewhat misnamed) to the corresponding clkctrl atm.

See [1] for AM33xx SGX. I will be posting some of these once I check the
behavior.

> 
>> I am working on preparing the next version of PRUSS patches with ti-sysc
>> on AM33xx/AM437x/AM57xx platforms, so will pick up these patches for my
>> testing.
> 
> OK great, yes please check and test with your rstctrl use case.
> I guess you still need to use the reset-simple patch for now
> until we have a proper prm rstctrl driver.
> 
> Note that you probably also want to leave out the struct
> omap_hwmod data from omap_hwmod_*_data.c files with rstctrl
> entries.

You mean no hwmod entries at all, or hwmod entries with no rstctrl data?

regards
Suman

[1]
http://git.ti.com/gitweb/?p=ti-linux-kernel/ti-linux-kernel.git;a=commitdiff;h=536d660714e98bdb7f96e5990a095283e52e4d8a
