From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/3] ARM: dra762: hwmod: Add MCAN support
Date: Tue, 15 May 2018 10:23:24 -0700
Message-ID: <20180515172324.GS98604@atomide.com>
References: <1523181542-3770-1-git-send-email-faiz_abbas@ti.com>
 <1523181542-3770-2-git-send-email-faiz_abbas@ti.com>
 <20180501152615.GB98604@atomide.com>
 <b4d95a08-82fd-9f39-53e7-977351788c88@ti.com>
 <20180515171459.GP98604@atomide.com>
 <20180515171808.GR98604@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180515171808.GR98604@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Faiz Abbas <faiz_abbas@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, bcousson@baylibre.com, robh+dt@kernel.org, mark.rutland@arm.com, paul@pwsan.com, lokeshvutla@ti.com, linux@armlinux.org.uk
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [180515 17:20]:
> * Tony Lindgren <tony@atomide.com> [180515 17:17]:
> > * Faiz Abbas <faiz_abbas@ti.com> [180515 06:05]:
> > > Hi Tony,
> > > 
> > > On Tuesday 01 May 2018 08:56 PM, Tony Lindgren wrote:
> > > > Hi,
> > > > 
> > > > * Faiz Abbas <faiz_abbas@ti.com> [180408 09:59]:
> > > >> From: Lokesh Vutla <lokeshvutla@ti.com>
> > > >>
> > > >> Add MCAN hwmod data and register it for dra762 silicons.
> > > >>
> > > >> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> > > >> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> > > >> ---
> > > >>  arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 32 +++++++++++++++++++++++++++++++
> > > >>  1 file changed, 32 insertions(+)
> > > >>
> > > >> diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> > > >> index 62352d1..a2cd7f8 100644
> > > >> --- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> > > >> +++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> > > >> @@ -1356,6 +1356,29 @@ static struct omap_hwmod dra7xx_mailbox13_hwmod = {
> > > >>  };
> > > >>  
> > > >>  /*
> > > >> + * 'mcan' class
> > > >> + *
> > > >> + */
> > > >> +static struct omap_hwmod_class dra76x_mcan_hwmod_class = {
> > > >> +	.name	= "mcan",
> > > >> +};
> > > > 
> > > > Looks like you're missing the related struct omap_hwmod_class_sysconfig
> > > > entry for this with the rev and sysconfig registers.
> > > > 
> > > 
> > > Sorry, I missed this email earlier. The MCAN module doesn't have
> > > sysconfig registers.
> > 
> > If there's no sysconfig register you should have no need for adding
> > anything to omap_hwmod_7xx_data.c. We now have the dts clkctrl
> > clocks, you can just add that to the dts node for the device.
> 
> However.. My guess is there is somewhere a top level interconnect
> target module that uses DRA7XX_CM_WKUPAON_ADC_CLKCTRL. And that
> module may have multiple child devices.

And I'm guessing the top level module with sysconfig related
registers is named "adc" :)

Regards,

Tony
