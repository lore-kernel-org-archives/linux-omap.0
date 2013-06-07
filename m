From: Archit Taneja <archit@ti.com>
Subject: Re: [PATCH 19/32] OMAPDSS: add videomode conversion support
Date: Fri, 7 Jun 2013 12:36:47 +0530
Message-ID: <51B18687.6000602@ti.com>
References: <1369906493-27538-1-git-send-email-tomi.valkeinen@ti.com> <1369906493-27538-20-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39006 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750871Ab3FGHIC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 7 Jun 2013 03:08:02 -0400
In-Reply-To: <1369906493-27538-20-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org

On Thursday 30 May 2013 03:04 PM, Tomi Valkeinen wrote:
> Add helper functions to convert between omapdss specific video timings
> and the common videomode.
>
> Eventually omapdss will be changed to use only the common video timings,
> and these helper functions will make the transition easier.

So we now use omap_video_timings, videomode, drm_display_mode, and 
fb_var_screeninfo, fun! :)

Archit

