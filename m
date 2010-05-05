From: "Aguirre, Sergio" <saaguirre@ti.com>
Subject: Old DSS code broken as module (was "RE: [PATCH 11/11] omap2/3/4:
 Disable CONFIG_FB_OMAP in omap3_defconfig")
Date: Wed, 5 May 2010 12:32:44 -0500
Message-ID: <A24693684029E5489D1D202277BE8944552579A3@dlee02.ent.ti.com>
References: <20100430202603.25812.41834.stgit@baageli.muru.com>
 <20100430203411.25812.30019.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47182 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756113Ab0EERcx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 May 2010 13:32:53 -0400
In-Reply-To: <20100430203411.25812.30019.stgit@baageli.muru.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tomi Valkeinen <tomi.valkeinen@nokia.com>

Tony,

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Tony Lindgren
> Sent: Friday, April 30, 2010 3:34 PM
> To: linux-arm-kernel@lists.infradead.org
> Cc: linux-omap@vger.kernel.org
> Subject: [PATCH 11/11] omap2/3/4: Disable CONFIG_FB_OMAP in
> omap3_defconfig
> 
> Looks like CONFIG_FB_OMAP prevents somehow mounting root on MMC
> at least on zoom3 for multi-omap. Disable CONFIG_FB until the
> omap FB code is fixed.
> 
> This allows booting omap3_defconfig on various omaps. Tested on
> 2420-n8x0, 3430-n900, 3630-zoom3 and 4430-blaze. Note that n8x0
> still has issues with starting user space because of TLS and
> VFP.

(Looping Tomi)

Unfortunately, your patch is uncovering an issue with old DSS code to
compile it as module, which I think is caused by this:

A single omapfb.ko is attempted to be created in drivers/video/omap/ folder,
but the included source files (DSS code + lcd drivers), results in multiple
module_init entries added in a single module, and therefore giving errors of
duplicate init_module entries between omapfb_main.c and the lcd_*.c files.

So, either you disable old DSS driver completely, or you have it as
built-in.

Regards,
Sergio

