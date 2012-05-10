From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL 10/10] omap dss clean up for v3.5 merge window
Date: Thu, 10 May 2012 11:53:41 -0700
Message-ID: <20120510185341.GK21851@atomide.com>
References: <pull-1336675159-747052>
 <E1SSYJW-0006gd-Dw@merlin.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:45417 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760305Ab2EJSxn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 May 2012 14:53:43 -0400
Content-Disposition: inline
In-Reply-To: <E1SSYJW-0006gd-Dw@merlin.infradead.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Tony Lindgren <tony@atomide.com> [120510 11:49]:
> The following changes since commit d48b97b403d23f6df0b990cee652bdf9a52337a3:
> 
>   Linux 3.4-rc6 (2012-05-06 15:07:32 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-cleanup-dss-for-v3.5
> 
> for you to fetch changes up to 21f787b356279798a002c68d53628755c84168de:
> 
>   Merge branch 'for-l-o-3.5' of git://gitorious.org/linux-omap-dss2/linux into cleanup-dss (2012-05-09 08:39:20 -0700)
> 
> ----------------------------------------------------------------
> 
> Clean up for omap DSS board init in preparation for adding DT support.
> 
> ----------------------------------------------------------------

Merging in this branch should avoid issues in linux-next for the
DSS changes. There's a small merge conflict here too:

--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@@ -389,28 -420,16 +373,16 @@@ static struct omap_board_mux board_mux[
  /* Display DVI */
  #define PANDA_DVI_TFP410_POWER_DOWN_GPIO	0
  
- static int omap4_panda_enable_dvi(struct omap_dss_device *dssdev)
- {
- 	gpio_set_value(dssdev->reset_gpio, 1);
- 	return 0;
- }
- 
- static void omap4_panda_disable_dvi(struct omap_dss_device *dssdev)
- {
- 	gpio_set_value(dssdev->reset_gpio, 0);
- }
- 
  /* Using generic display panel */
- static struct panel_dvi_platform_data omap4_dvi_panel = {
- 	.platform_enable	= omap4_panda_enable_dvi,
- 	.platform_disable	= omap4_panda_disable_dvi,
- 	.i2c_bus_num = 3,
+ static struct tfp410_platform_data omap4_dvi_panel = {
+ 	.i2c_bus_num		= 3,
+ 	.power_down_gpio	= PANDA_DVI_TFP410_POWER_DOWN_GPIO,
  };
  
 -struct omap_dss_device omap4_panda_dvi_device = {
 +static struct omap_dss_device omap4_panda_dvi_device = {
  	.type			= OMAP_DISPLAY_TYPE_DPI,
  	.name			= "dvi",
- 	.driver_name		= "dvi",
+ 	.driver_name		= "tfp410",
  	.data			= &omap4_dvi_panel,
  	.phy.dpi.data_lines	= 24,
  	.reset_gpio		= PANDA_DVI_TFP410_POWER_DOWN_GPIO,
@@@ -478,13 -485,8 +438,8 @@@ static struct omap_dss_board_info omap4
  	.default_device	= &omap4_panda_dvi_device,
  };
  
 -void __init omap4_panda_display_init(void)
 +static void __init omap4_panda_display_init(void)
  {
- 	int r;
- 
- 	r = omap4_panda_dvi_init();
- 	if (r)
- 		pr_err("error initializing panda DVI\n");
  
  	omap_display_init(&omap4_panda_dss_data);
  
