From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 2/3] ARM: OMAP3: HWMOD: add SYSC_HAS_ENAWAKEUP for
 dispc
Date: Wed, 25 Jan 2012 12:02:54 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1201251202400.5324@utopia.booyaka.com>
References: <1327320930-14550-1-git-send-email-tomi.valkeinen@ti.com> <1327320930-14550-3-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:40516 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751499Ab2AYTCy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Jan 2012 14:02:54 -0500
In-Reply-To: <1327320930-14550-3-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, archit@ti.com, neilb@suse.de, jean.pihet@newoldbits.com, khilman@ti.com, jw@terrafix.co.uk

On Mon, 23 Jan 2012, Tomi Valkeinen wrote:

> dispc's sysc_flags is missing SYSC_HAS_ENAWAKEUP flag. This seems to
> cause SYNC_LOST errors from the DSS when the power management is
> enabled.
> 
> This patch adds the missing SYSC_HAS_ENAWAKEUP flag. Note that there are
> other flags missing also (clock activity, DSI's sysc flags), but as they
> are not critical, they will be fixed in the next merge window.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

Thanks, queued for 3.3-rc.


- Paul
