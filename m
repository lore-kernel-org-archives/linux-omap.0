From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2] OMAP2PLUS: DSS: Ensure DSS works correctly if
 display is enabled in bootloader
Date: Mon, 03 Oct 2011 11:21:10 +0300
Message-ID: <1317630070.2026.27.camel@deskari>
References: <1315811306-11001-1-git-send-email-archit@ti.com>
	 <alpine.DEB.2.00.1110022237171.4611@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:48775 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751620Ab1JCIVQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Oct 2011 04:21:16 -0400
Received: by bkbzt4 with SMTP id zt4so6338605bkb.33
        for <linux-omap@vger.kernel.org>; Mon, 03 Oct 2011 01:21:14 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1110022237171.4611@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Archit Taneja <archit@ti.com>, santosh.shilimkar@ti.com, r.sricharan@ti.com, tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Paul,

On Sun, 2011-10-02 at 22:45 -0600, Paul Walmsley wrote:
> Hi
> 
> some comments:
> 
> On Mon, 12 Sep 2011, Archit Taneja wrote:
> 
> > Resetting DISPC when a DISPC output is enabled causes the DSS to go into an
> > inconsistent state. Thus if the bootloader has enabled a display, the hwmod code
> > cannot reset the DISPC module just like that, but the outputs need to be
> > disabled first.
> > 
> > Add function dispc_disable_outputs() which disables all active overlay manager
> > and ensure all frame transfers are completed.
> > 
> > Modify omap_dss_reset() to call this function and clear DSS_CONTROL,
> > DSS_SDI_CONTROL and DSS_PLL_CONTROL so that DSS is in a clean state when the
> > DSS2 driver starts.
> > 
> > This resolves the hang issue(caused by a L3 error during boot) seen on the
> > beagle board C3, which has a factory bootloader that enables display. The issue
> > is resolved with this patch.

<snip>

> +struct omap_dss_dispc_dev_attr {
> +	u8	manager_count;
> +	bool	has_framedonetv_irq;
> +};
> +
> +#endif
> diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
> index 09d9395..8e32cb3 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
> @@ -945,6 +945,7 @@ static struct omap_hwmod omap2420_dss_dispc_hwmod = {
>  	.slaves_cnt	= ARRAY_SIZE(omap2420_dss_dispc_slaves),
>  	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
>  	.flags		= HWMOD_NO_IDLEST,
> +	.dev_attr	= &omap2_3_dss_dispc_dev_attr
>  };

I didn't know you can add arbitrary data like that to hwmods. What kind
of data is it meant for? Can the data be used by the driver, or is it
meant just for arch stuff?

I'm wondering this as we have a complex mechanism in the dss driver to
find out about the differences of DSS hardware
(drivers/video/omap2/dss/dss_features.[ch]). The dss_features system is
currently part of the driver, but should be moved under arch/arm/*omap*
at some point, and this hwmod dev_attr sounds like it could possibly be
a right place to handle these.

I looked at how the dev_attrs are used, and all of them seemed to be
very small, a few fields at max. The DSS features set is, on the other
hand, quite big amount of data, and meant for the driver.

 Tomi


