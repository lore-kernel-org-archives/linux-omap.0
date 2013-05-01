From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 00/10] OMAPDSS: Basic deferred probe support
Date: Wed, 1 May 2013 09:55:08 -0700
Message-ID: <20130501165507.GI28721@atomide.com>
References: <1367230957-32337-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:33987 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751255Ab3EAQzL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 May 2013 12:55:11 -0400
Content-Disposition: inline
In-Reply-To: <1367230957-32337-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, grygorii.strashko@ti.com, chf.fritz@googlemail.com, Archit Taneja <archit@ti.com>

* Tomi Valkeinen <tomi.valkeinen@ti.com> [130429 03:28]:
> Hi,
> 
> omapdss, omapfb and the panel drivers do not currently support deferred probe,
> which is causing the display drivers fail when booting with DT.
> 
> This series adds very basic support for deferred probing, which hopefully fixes
> the issues for omap4 panda and sdp boards with the current kernel.
> 
> Limitations:
> 
> * Deferred probe support for omap_vout and omapdrm is still totally missing.
> * If it so happens that at omapfb probe time one panel has been probed, but
>   another has been deferred, only the probed one will be used.
> * Only DPI, DSI and HDMI outputs have been fixed.
> * Some panel drivers may need modifications to support EPROBE_DEFER
> 
> Patches based on linux-next, i.e. the latest omapdss stuff.

Great, these fix the issues at least for panda booted with DT.

Regards,

Tony
