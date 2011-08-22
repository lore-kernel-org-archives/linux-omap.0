From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCHv2 5/5] OMAP: HWMOD: Unify DSS resets for all OMAPs
Date: Mon, 22 Aug 2011 10:00:53 +0300
Message-ID: <1313996453.2168.9.camel@deskari>
References: <1312794914-22894-1-git-send-email-tomi.valkeinen@ti.com>
	 <1312794914-22894-6-git-send-email-tomi.valkeinen@ti.com>
	 <alpine.DEB.2.00.1108192327470.24016@utopia.booyaka.com>
	 <alpine.DEB.2.00.1108200018590.24016@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:51470 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750806Ab1HVHA7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Aug 2011 03:00:59 -0400
Received: by mail-bw0-f48.google.com with SMTP id t2so3405039bka.7
        for <linux-omap@vger.kernel.org>; Mon, 22 Aug 2011 00:00:57 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1108200018590.24016@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, b-cousson@ti.com, archit@ti.com

Hi Paul,

On Sat, 2011-08-20 at 00:26 -0600, Paul Walmsley wrote:
> On Fri, 19 Aug 2011, Paul Walmsley wrote:
> 
> > This one doesn't build when !CONFIG_OMAP2_DSS - the following is the 
> > updated patch.
> 
> Looks like my previous update missed a warning.  This also moves the 
> omap_dss_reset() prototype from arch/arm/mach-omap2/common-board-devices.h 
> to arch/arm/plat-omap/include/plat/common.h.

Related to this, there's also omap_display_init() function in display.c,
called by the board files, which I would like to move elsewhere from
include/video/omapdss.h.

I was thinking of moving it to
arch/arm/mach-omap2/common-board-devices.h but should I move it to
arch/arm/plat-omap/include/plat/common.h so that it's in the same place
with omap_dss_reset() (also from display.c)?

 Tomi


