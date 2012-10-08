From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] OMAP: move arch/arm/plat-omap/include/plat/vrfb.h
Date: Mon, 8 Oct 2012 10:26:32 -0700
Message-ID: <20121008172632.GJ3874@atomide.com>
References: <1349699429-12736-1-git-send-email-tomi.valkeinen@ti.com>
 <1349699429-12736-2-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:40302 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753010Ab2JHR0e (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Oct 2012 13:26:34 -0400
Content-Disposition: inline
In-Reply-To: <1349699429-12736-2-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>, Vaibhav Hiremath <hvaibhav@ti.com>

* Tomi Valkeinen <tomi.valkeinen@ti.com> [121008 05:32]:
> Now that vrfb driver is not omap dependent anymore, we can move vrfb.h
> from arch/arm/plat-omap/include/plat to include/video/omapvrfb.h.

Once the request_mem_region in patch 1/2 are handled:

Acked-by: Tony Lindgren <tony@atomide.com>

Also, can you please do a minimal immutable branch on -rc1 that
we both can use? I need these into my cleanup branch for v3.8
merge window.

Regards,

Tony
