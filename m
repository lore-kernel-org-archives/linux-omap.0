From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCHv2 16/28] OMAP3: HWMOD: Add DSS opt clocks
Date: Tue, 02 Aug 2011 10:47:35 +0300
Message-ID: <1312271255.1917.29.camel@deskari>
References: <1307627810-3768-1-git-send-email-tomi.valkeinen@ti.com>
	 <1307627810-3768-17-git-send-email-tomi.valkeinen@ti.com>
	 <alpine.DEB.2.00.1107150048530.16606@utopia.booyaka.com>
	 <alpine.DEB.2.00.1108011914280.28427@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:39993 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751743Ab1HBHrm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Aug 2011 03:47:42 -0400
In-Reply-To: <alpine.DEB.2.00.1108011914280.28427@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, b-cousson@ti.com, khilman@ti.com

HI,

On Mon, 2011-08-01 at 19:27 -0600, Paul Walmsley wrote:
> Hello Tomi,
> 
> On Fri, 15 Jul 2011, Paul Walmsley wrote:
> 
> > On Thu, 9 Jun 2011, Tomi Valkeinen wrote:
> > 
> > > Add DSS optional clocks to HWMOD data for OMAP3xxx.
> > 
> > Thanks; queued for 3.1-rc fixes at git://git.pwsan.com/linux-2.6 in the 
> > branch 'omap2_3_hwmod_dss_fixes_3.1rc'.  
> 
> This patch has been updated to remove the temporary hack added to the DSS 
> driver.  Care to review it before it's sent to Tony?

My hacks (for the OMAP2 case also) use the clocks from the clockdata,
thus fixing the hwmod data won't make the hacks break. So I think it's
cleaner if the HWMOD patches go separately through you, and I'll revert
the hacks in my tree.

But a few comments inline, which I noticed just now.

> - Paul
> 
> From: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Date: Fri, 15 Jul 2011 00:54:34 -0600
> Subject: [PATCH 2/2] OMAP3: HWMOD: Add DSS opt clocks
> 
> Add DSS optional clocks to HWMOD data for OMAP3xxx.
> 
> Revert OMAP3 portion of commit
> 9ede365aa6f74428a1f69c21ca1cf21213167576 ("HACK: OMAP: DSS2: clk hack
> for OMAP2/3").
> 
> Cc: Benoit Cousson <b-cousson@ti.com>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> [paul@pwsan.com: remove temporary DSS driver hack; update changelog]
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   32 ++++++++++++++++++++++++---
>  drivers/video/omap2/dss/dsi.c              |    2 +-
>  drivers/video/omap2/dss/dss.h              |    2 -
>  drivers/video/omap2/dss/rfbi.c             |    5 +---
>  drivers/video/omap2/dss/venc.c             |    5 +---
>  5 files changed, 31 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> index 25bf43b..38ee033 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> @@ -1365,9 +1365,14 @@ static struct omap_hwmod_ocp_if *omap3xxx_dss_slaves[] = {
>  };
>  
>  static struct omap_hwmod_opt_clk dss_opt_clks[] = {
> -	{ .role = "tv_clk", .clk = "dss_tv_fck" },
> -	{ .role = "video_clk", .clk = "dss_96m_fck" },
> +	/*
> +	 * The rest of the clocks are not needed by the driver,
> +	 * but are needed by the hwmod to reset DSS properly.
> +	 */

I think this wording should be changed, as with the latest hwmod code
changes the dss_core does not use any opt clocks, and these all are just
to make the dss reset work.

Perhaps something like "The DSS HW needs all DSS clocks enabled during
reset. The dss_core driver does not use these clocks."

>  	{ .role = "sys_clk", .clk = "dss2_alwon_fck" },
> +	{ .role = "tv_clk", .clk = "dss_tv_fck" },
> +	/* required only on OMAP3430 */
> +	{ .role = "tv_dac_clk", .clk = "dss_96m_fck" },
>  };

The dss_96m_fck exists only on OMAP3430. What happens when the HWMOD
code tries to reset DSS on OMAP3630, and it first enables all the opt
clocks, and encounters the dss_96m_fck which doesn't exist?

Although, looking at the clock3xxx_data.c, it looks like dss_96m_fck is
there, but I'm not sure what it is controlling. Does the clock exist in
the HW, but it's just not connected to DSS?

The hwmod code should also set HWMOD_CONTROL_OPT_CLKS_IN_RESET for
dss_core, shouldn't it?

>  static struct omap_hwmod omap3430es1_dss_core_hwmod = {
> @@ -1504,6 +1509,10 @@ static struct omap_hwmod_ocp_if *omap3xxx_dss_dsi1_slaves[] = {
>  	&omap3xxx_l4_core__dss_dsi1,
>  };
>  
> +static struct omap_hwmod_opt_clk dss_dsi1_opt_clks[] = {
> +	{ .role = "sys_clk", .clk = "dss2_alwon_fck" },
> +};
> +

DSI is missing the interface clock in omap3xxx_l4_core__dss_dsi1. Should
it have .clk = "dss_ick" like the other dss modules?

I can make a new patch with these changes if they look correct to you.

 Tomi


