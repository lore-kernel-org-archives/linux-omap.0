From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL 9/10] omap devicetree updates for v3.5 merge window
Date: Thu, 10 May 2012 11:50:07 -0700
Message-ID: <20120510185006.GI21851@atomide.com>
References: <pull-1336675159-747052>
 <E1SSYIv-0006IZ-NG@merlin.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:42520 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760449Ab2EJSuK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 May 2012 14:50:10 -0400
Content-Disposition: inline
In-Reply-To: <E1SSYIv-0006IZ-NG@merlin.infradead.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Tony Lindgren <tony@atomide.com> [120510 11:49]:
> The following changes since commit b3431f5ba402a98a89b78a9408b4972d8870df4d:
> 
>   arm/dts: OMAP3: Add mmc controller nodes and board data (2012-03-14 21:54:57 +0100)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-dt-for-v3.5
> 
> for you to fetch changes up to 40364b9f5a4d167d97bb6a76cd239ca8cfff056a:
> 
>   arm/dts: omap4-panda: Add LEDs support (2012-05-09 17:18:03 -0700)
> 
> ----------------------------------------------------------------
> Minor DT updates based on the dt-missed-3.4 branch
> 
> ----------------------------------------------------------------

For this one there's a minor merge conflict, here's a suggested
resolve.

Regards,

Tony

--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@@ -743,12 -721,14 +743,15 @@@ static int __init omap2_init_devices(vo
  	 * in alphabetical order so they're easier to sort through.
  	 */
  	omap_init_audio();
- 	omap_init_mcpdm();
- 	omap_init_dmic();
  	omap_init_camera();
 +	omap_init_hdmi_audio();
  	omap_init_mbox();
- 	omap_init_mcspi();
+ 	/* If dtb is there, the devices will be created dynamically */
+ 	if (!of_have_populated_dt()) {
+ 		omap_init_dmic();
+ 		omap_init_mcpdm();
+ 		omap_init_mcspi();
+ 	}
  	omap_init_pmu();
  	omap_hdq_init();
  	omap_init_sti();
