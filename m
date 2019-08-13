From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/8] ARM: OMAP2+: Remove unconfigured midlemode for am3
 lcdc
Date: Tue, 13 Aug 2019 04:29:30 -0700
Message-ID: <20190813112930.GO52127@atomide.com>
References: <20190723112811.44381-1-tony@atomide.com>
 <20190723112811.44381-3-tony@atomide.com>
 <bcc130a5-f7e0-e182-9f4b-5a48fc3d6e17@ti.com>
 <b5d757dc-6326-4b93-c2a2-2db02a440c26@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b5d757dc-6326-4b93-c2a2-2db02a440c26@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>
Cc: Suman Anna <s-anna@ti.com>, linux-omap@vger.kernel.org, Dave Gerlach <d-gerlach@ti.com>, Faiz Abbas <faiz_abbas@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Roger Quadros <rogerq@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Jyri Sarha <jsarha@ti.com> [190813 11:05]:
> On 23/07/2019 22:03, Suman Anna wrote:
> > + Jyri
> > 
> > On 7/23/19 6:28 AM, Tony Lindgren wrote:
> >> We currently get a warning for lcdc because of a difference
> >> with dts provided configuration compared to the legacy platform
> >> data. This is because lcdc has SYSC_HAS_MIDLEMODE configured in
> >> the platform data without configuring the modes.
> > 
> > Hi Tony,
> > While I understand that you are trying to match the DT data with the
> > existing legacy data, do you know if there was a reason why this was
> > omitted in the first place? Should we be really adding the MSTANDBY_
> > flags and fix up the DTS node accordingly? I tried looking through the
> > git log, and the initial commit itself didn't add the MSTANDBY_ flags
> > but used the SYSC_HAS_MIDLEMODE.
> > 
> > Jyri,
> > Do you know the history?
> > 
> 
> Sorry. This all has happened before my time. This is all new to me.

Oh OK. Well if possible, could you please check if the following patch
behaves with v5.2 for you for LCDC? I only have rack access to a
beaglebone with hdmi right now.

TRM "Table 13-34. SYSCONFIG Register Field Descriptions" lists both
standbymode and idlemode that should be just the sidle and midle
registers where midle is currently unconfigured.

Regards,

Tony

8< ---------------------
diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
@@ -255,8 +255,9 @@ static struct omap_hwmod am33xx_gpio0_hwmod = {
 static struct omap_hwmod_class_sysconfig lcdc_sysc = {
 	.rev_offs	= 0x0,
 	.sysc_offs	= 0x54,
-	.sysc_flags	= (SYSC_HAS_SIDLEMODE | SYSC_HAS_MIDLEMODE),
-	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+	.sysc_flags	= SYSC_HAS_SIDLEMODE | SYSC_HAS_MIDLEMODE,
+	.idlemodes	= SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
+			  MSTANDBY_FORCE | MSTANDBY_NO | MSTANDBY_SMART,
 	.sysc_fields	= &omap_hwmod_sysc_type2,
 };
 
