From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v2] ARM: OMAP4: clock: Add device tree support for AUXCLKs
Date: Fri, 5 Apr 2013 03:48:36 -0500
Message-ID: <20130405084836.GA11331@kahuna>
References: <1363703220-4777-2-git-send-email-rogerq@ti.com>
 <1364293408-20677-1-git-send-email-rogerq@ti.com>
 <515A958B.5080905@ti.com>
 <515E8F85.2060700@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <515E8F85.2060700@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, tony@atomide.com, rnayak@ti.com, b-cousson@ti.com, santosh.shilimkar@ti.com, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 11:47-20130405, Roger Quadros wrote:
> On 04/02/2013 11:23 AM, Roger Quadros wrote:
> > + Paul
> > 
> > On 03/26/2013 12:23 PM, Roger Quadros wrote:
> >> Register a device tree clock provider for the clocks
> >> on the OMAP4 SoC. Also provide the binding information.
> >>
> >> For now we only provide AUXCLKs.
> 
> NOTE: this patch depends on
> https://patchwork.kernel.org/patch/2312211/
> 
> >>
> >> Signed-off-by: Roger Quadros <rogerq@ti.com>
> >> ---
> >>  .../devicetree/bindings/clock/omap4-clock.txt      |   33 ++++++++++++++++
> >>  arch/arm/boot/dts/omap4.dtsi                       |    5 ++
> >>  arch/arm/mach-omap2/cclock44xx_data.c              |   41 ++++++++++++++++++++
> >>  3 files changed, 79 insertions(+), 0 deletions(-)
> >>  create mode 100644 Documentation/devicetree/bindings/clock/omap4-clock.txt
If we are doing this, we might as well do for all platforms(OMAP3-5,
AM..) in an series, no?

-- 
Regards,
Nishanth Menon
