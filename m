From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: DRA7: Enable Cortex A15 errata 798181
Date: Fri, 27 Mar 2015 14:38:49 -0700
Message-ID: <20150327213848.GG10805@atomide.com>
References: <1427325909-7014-1-git-send-email-praneeth@ti.com>
 <5513458A.50001@ti.com>
 <20150326173515.GB10805@atomide.com>
 <5515BEF4.7030201@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5515BEF4.7030201@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Praneeth Bajjuri <praneeth@ti.com>, linux-omap@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Nishanth Menon <nm@ti.com> [150327 13:35]:
> On 03/26/2015 12:35 PM, Tony Lindgren wrote:
> > * Nishanth Menon <nm@ti.com> [150325 16:32]:
> >> On 03/25/2015 06:25 PM, Praneeth Bajjuri wrote:
> >>> ARM errata 798181 is applicable for OMAP5/DRA7 based devices. So enable
> >>> the same in the build.
> >>>
> >>> DRA7xx is based on Cortex-A15 r2p2 revision.
> >>>
> >>> ARM Errata extract and workaround information is as below.
> >>>
> >>> On Cortex-A15 (r0p0..r3p2) the TLBI*IS/DSB operations are not
> >>> adequately shooting down all use of the old entries. The
> >>> ARM_ERRATA_798181 option enables the Linux kernel workaround
> >>> for this erratum which sends an IPI to the CPUs that are running
> >>> the same ASID as the one being invalidated.
> >>>
> >>> Signed-off-by: Praneeth Bajjuri <praneeth@ti.com>
> >>> ---
> >>>  arch/arm/mach-omap2/Kconfig |    1 +
> >>>  1 file changed, 1 insertion(+)
> >>>
> >>> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> >>> index c7d8d86..3e4b4ae 100644
> >>> --- a/arch/arm/mach-omap2/Kconfig
> >>> +++ b/arch/arm/mach-omap2/Kconfig
> >>> @@ -69,6 +69,7 @@ config SOC_DRA7XX
> >>>  	select ARM_GIC
> >>>  	select HAVE_ARM_ARCH_TIMER
> >>>  	select IRQ_CROSSBAR
> >>> +	select ARM_ERRATA_798181 if SMP
> >>>  
> >>>  config ARCH_OMAP2PLUS
> >>>  	bool
> >>>
> >> Gee thanks and Apologies on missing this patch.
> >>
> >> Acked-by: Nishanth Menon <nm@ti.com>
> >>
> >> Seen on DRA7 only builds, so kinda slipped radar a bit.. verified to
> >> apply on v4.0-rc1
> > 
> > Is this needed as a fix for v4.0-rc series or can this wait for v4.1?
> I think we can wait till 4.1

OK thanks applying into omap-for-v4.1/fixes-not-urgent.

Tony 
