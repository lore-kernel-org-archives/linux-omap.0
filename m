From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/7] ARM: OMAP2+: Fix zoom LCD backlight if TWL_CORE is
 not selected
Date: Fri, 24 Feb 2012 08:25:14 -0800
Message-ID: <20120224162514.GK18185@atomide.com>
References: <20120224005324.16794.73852.stgit@kaulin.local>
 <20120224005411.16794.720.stgit@kaulin.local>
 <4F477A56.9000005@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:48795 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752235Ab2BXQZR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Feb 2012 11:25:17 -0500
Content-Disposition: inline
In-Reply-To: <4F477A56.9000005@ru.mvista.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Sergei Shtylyov <sshtylyov@ru.mvista.com> [120224 03:23]:
> 
> On 24-02-2012 4:54, Tony Lindgren wrote:
> >--- a/arch/arm/mach-omap2/board-zoom-display.c
> >+++ b/arch/arm/mach-omap2/board-zoom-display.c
> >@@ -53,8 +53,11 @@ static void zoom_panel_disable_lcd(struct omap_dss_device *dssdev)
> >  #define TWL_LED_PWMON	0x0
> >  #define TWL_LED_PWMOFF	0x1
> >
> >+
> >  static int zoom_set_bl_intensity(struct omap_dss_device *dssdev, int level)
> >  {
> >+
> 
>    Empty lines not needed.

Thanks removing those.

Tony
