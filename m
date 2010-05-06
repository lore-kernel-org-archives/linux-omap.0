From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: Old DSS code broken as module (was "RE: [PATCH 11/11]
 omap2/3/4: Disable CONFIG_FB_OMAP in omap3_defconfig")
Date: Thu, 06 May 2010 11:07:57 +0300
Message-ID: <1273133277.1978.136.camel@tubuntu.research.nokia.com>
References: <20100430202603.25812.41834.stgit@baageli.muru.com>
	 <20100430203411.25812.30019.stgit@baageli.muru.com>
	 <A24693684029E5489D1D202277BE8944552579A3@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:29965 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753927Ab0EFII1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 May 2010 04:08:27 -0400
In-Reply-To: <A24693684029E5489D1D202277BE8944552579A3@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Aguirre, Sergio" <saaguirre@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, 2010-05-05 at 19:32 +0200, ext Aguirre, Sergio wrote:
> Tony,
> 
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > owner@vger.kernel.org] On Behalf Of Tony Lindgren
> > Sent: Friday, April 30, 2010 3:34 PM
> > To: linux-arm-kernel@lists.infradead.org
> > Cc: linux-omap@vger.kernel.org
> > Subject: [PATCH 11/11] omap2/3/4: Disable CONFIG_FB_OMAP in
> > omap3_defconfig
> > 
> > Looks like CONFIG_FB_OMAP prevents somehow mounting root on MMC
> > at least on zoom3 for multi-omap. Disable CONFIG_FB until the
> > omap FB code is fixed.
> > 
> > This allows booting omap3_defconfig on various omaps. Tested on
> > 2420-n8x0, 3430-n900, 3630-zoom3 and 4430-blaze. Note that n8x0
> > still has issues with starting user space because of TLS and
> > VFP.
> 
> (Looping Tomi)
> 
> Unfortunately, your patch is uncovering an issue with old DSS code to
> compile it as module, which I think is caused by this:
> 
> A single omapfb.ko is attempted to be created in drivers/video/omap/ folder,
> but the included source files (DSS code + lcd drivers), results in multiple
> module_init entries added in a single module, and therefore giving errors of
> duplicate init_module entries between omapfb_main.c and the lcd_*.c files.
> 
> So, either you disable old DSS driver completely, or you have it as
> built-in.

Ah, yes. I'm not sure if the older omapfb was ever really designed to be
used as module... If this is the problem, then my suggestion is to
either use it built-in, or use the new DSS2 which works well as modules.

I guess the option to compile the older omapfb as a module should be
removed? Or if some brave soul wants to start fixing omapfb, that's ok
too =).

 Tomi


