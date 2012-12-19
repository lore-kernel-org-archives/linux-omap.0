From: Peter Meerwald <pmeerw@pmeerw.net>
Subject: Re: downscaling YUV fails
Date: Wed, 19 Dec 2012 13:15:31 +0100 (CET)
Message-ID: <alpine.DEB.2.01.1212191311230.16226@pmeerw.net>
References: <alpine.DEB.2.01.1212191025480.16226@pmeerw.net> <50D193FD.4070401@ti.com> <alpine.DEB.2.01.1212191132250.16226@pmeerw.net> <50D1A2BC.4040605@ti.com> <50D1A34B.8030308@ti.com> <50D1AA85.1000207@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:55416 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750858Ab2LSMPc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 Dec 2012 07:15:32 -0500
In-Reply-To: <50D1AA85.1000207@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org


> One thing I'm guessing is that DMA fetching with predecimation isn't really
> optimised for omap3, if the pixel clock in Peter's setup is high, the DISPC
> DMA might not be able to fetch pixels fast enough in predecimation case. That
> sort of supports the possibility of a skewed image seen.

> Do you see any SYNC_LOST or UNDERFLOW prints when this happens?

not that I am aware of

the issue is fully reproducible here; there seem to be two extra pixels 
per line

p.

-- 

Peter Meerwald
+43-664-2444418 (mobile)
