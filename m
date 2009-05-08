From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/3] Getting omap3 frambuffer to work in mainline
Date: Fri, 8 May 2009 12:22:56 -0700
Message-ID: <20090508192255.GM5593@atomide.com>
References: <20090508191632.29249.92190.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:51385 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756770AbZEHTW6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 May 2009 15:22:58 -0400
Received: from c-67-160-239-110.hsd1.ca.comcast.net ([67.160.239.110] helo=localhost.localdomain)
	by mho-01-ewr.mailhop.org with esmtpa (Exim 4.68)
	(envelope-from <tony@atomide.com>)
	id 1M2Ves-000Cq8-5j
	for linux-omap@vger.kernel.org; Fri, 08 May 2009 19:22:58 +0000
Content-Disposition: inline
In-Reply-To: <20090508191632.29249.92190.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [090508 12:21]:
> Hi all,
> 
> Here are few patches to make omap3 framebuffer to work in the
> mainline kernel. I've just updated the clocks handling and
> added two missing LCD files. Still waiting for Imre to send
> all the other fixes..
> 
> Stanley, can you give it a try on your LDP?
> 
> Anybody want to try to produce a similar patch for Beagle
> for this series?

Forgot to mention that I quickly tested this on SDP, and
the penguin shows up ok.
 
> Regards,
> 
> Tony
> 
> ---
> 
> Stanley Miao (1):
>       OMAP_LDP: Support LCD display as a FB device on ZOOM MDK
> 
> Tony Lindgren (2):
>       ARM: OMAP3: Add more devices for omap3430sdp
>       ARM: OMAP2/3: Change omapfb to use clkdev for dispc and rfbi
> 
> 
>  arch/arm/configs/omap_3430sdp_defconfig |   10 ++
>  arch/arm/configs/omap_ldp_defconfig     |   63 +++++++++-
>  arch/arm/mach-omap2/board-2430sdp.c     |    6 +
>  arch/arm/mach-omap2/board-ldp.c         |   11 ++
>  arch/arm/mach-omap2/clock24xx.c         |    8 +
>  arch/arm/mach-omap2/clock34xx.c         |   10 +-
>  drivers/video/omap/Kconfig              |    4 +
>  drivers/video/omap/Makefile             |    5 +
>  drivers/video/omap/dispc.c              |   11 +-
>  drivers/video/omap/lcd_2430sdp.c        |  199 +++++++++++++++++++++++++++++++
>  drivers/video/omap/lcd_ldp.c            |  200 +++++++++++++++++++++++++++++++
>  drivers/video/omap/rfbi.c               |    4 -
>  12 files changed, 512 insertions(+), 19 deletions(-)
>  create mode 100644 drivers/video/omap/lcd_2430sdp.c
>  create mode 100644 drivers/video/omap/lcd_ldp.c
> 
> -- 
> Signature
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
