From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 0/3] Add support for ADC on am437x-gp and
 am43x-epos-evm
Date: Fri, 14 Nov 2014 10:50:49 -0800
Message-ID: <20141114185049.GB7046@atomide.com>
References: <1415099728-10959-1-git-send-email-vigneshr@ti.com>
 <54657FFA.1070200@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <54657FFA.1070200@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>
List-Id: linux-omap@vger.kernel.org

* Vignesh R <vigneshr@ti.com> [141113 20:09]:
> 
> On Tuesday 04 November 2014 04:45 PM, Vignesh R wrote:
> > This series of patches enable ADC on am437x-gp-evm and am43x-epos-evm.
> > The ADC clock hwmod data of am33xx has been moved to commom place so that
> > both am43xx and am33xx can reuse them.
> > tscadc DT node has been adided to am437x-gp and am43x-epos dt files.
> > With these patches, ADC functionalities are now available on am43xx.
> > 
> > Changelog:
> > 
> > v2:
> > Removed phy addresses in hwmod. Using DT instead.
> > Removed unused "ti,am4372" compatible string.
> > Use macro to set clk domain name.
> > Fixed subject format of all patches
> > 
> 
> Please accept these patches.

Adding Paul to Cc, I don't think Paul has seen these, probably because
get_maintainer.pl did not catch these hwmod files?

Regards,

Tony
 
> > Vignesh R (3):
> >   ARM: OMAP2+: hwmod: AM335x/AM43x: Move am33xx_l4_hs_hwmod to
> >     ipblock_data
> >   ARM: OMAP2+: hwmod: AM335x/AM43x: add hwmod support for tscadc on
> >     am43x-evm
> >   ARM: dts: AM43xx: add tscadc DT entries for am437x-evm and
> >     am43x-epos-evm
> > 
> >  arch/arm/boot/dts/am4372.dtsi                      | 20 ++++++
> >  arch/arm/boot/dts/am437x-gp-evm.dts                |  8 +++
> >  arch/arm/boot/dts/am43x-epos-evm.dts               |  8 +++
> >  .../mach-omap2/omap_hwmod_33xx_43xx_common_data.h  |  2 +
> >  .../mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c | 71 ++++++++++++++++++++++
> >  arch/arm/mach-omap2/omap_hwmod_33xx_data.c         | 64 -------------------
> >  arch/arm/mach-omap2/omap_hwmod_43xx_data.c         |  1 +
> >  7 files changed, 110 insertions(+), 64 deletions(-)
> > 
