From: Peter Meerwald <pmeerw@pmeerw.net>
Subject: Re: downscaling YUV fails
Date: Wed, 19 Dec 2012 11:51:07 +0100 (CET)
Message-ID: <alpine.DEB.2.01.1212191132250.16226@pmeerw.net>
References: <alpine.DEB.2.01.1212191025480.16226@pmeerw.net> <50D193FD.4070401@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:53151 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751018Ab2LSKvI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 Dec 2012 05:51:08 -0500
In-Reply-To: <50D193FD.4070401@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

Hello,

> In the case we set it to 4, the DISPC_FCLK is fast enough to do the required
> downscaling, but in the case when it's set to 0, it might need to pre decimate
> rather than try to scale.

this is my understanding as well

> > I think there is a bug downscaling YUV data when resorting to
> > pre-decimation; setting CONFIG_OMAP2_DSS_MIN_FCK_PER_PCK is a workaround
> > -- any ideas how this can be fixed?

> Pre-decimation should work for YUV formats also. Could you share DISPC reg
> dumps when this happens:
> 
> mount -t debugfs debugfs /sys/kernel/debug
> cat /sys/kernel/debug/omapdss/dispc

please find the files http://pmeerw.net/ok.dispc (with FCK_PER_PCK=4) and 
http://pmeerw.net/fail.dispc (FCK_PER_PCK=0)

thanks, p.

-- 

Peter Meerwald
+43-664-2444418 (mobile)
