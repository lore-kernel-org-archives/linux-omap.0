From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [GIT PULL] ARM: OMAP2+: OMAP DRA7xx display-related hwmod data
 changes for v4.1
Date: Tue, 7 Apr 2015 16:33:35 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1504071630050.19540@utopia.booyaka.com>
References: <alpine.DEB.2.02.1504031953150.19540@utopia.booyaka.com> <20150403230833.GB18048@atomide.com> <5523C971.1030904@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:55321 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753726AbbDGQdg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Apr 2015 12:33:36 -0400
In-Reply-To: <5523C971.1030904@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, arm@kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, 7 Apr 2015, Tomi Valkeinen wrote:

> Hi,
> 
> No, don't pull this, it doesn't work.
> 
> Paul, the hwmod patch cannot be picked from the DRA7 DSS series. We have
> the problem with the DES HDCP clock, without that clock we will see
> WARNINGs when booting if the "set DSS submodule parent hwmods" is applied.
> 
> We do see some errors when booting even with the current mainline,
> caused by not having that clock enabled:
> 
> [    0.194524] omap_hwmod: dss_core: _wait_target_disable failed
> [    0.194540] omap_hwmod: dss_core: _wait_target_ready failed: -16
> [    0.194554] omap_hwmod: dss_core: cannot be enabled for reset (3)
> [    0.197143] omap_hwmod: dss_dispc: _wait_target_ready failed: -16
> [    0.197156] omap_hwmod: dss_dispc: cannot be enabled for reset (3)
> [    0.199745] omap_hwmod: dss_hdmi: _wait_target_ready failed: -16
> [    0.199759] omap_hwmod: dss_hdmi: cannot be enabled for reset (3)
> 
> But that's still much less spam than the above plus ~4 WARNs.
> 
> I'd rather merge the DRA7 DSS patches in one go, to avoid issues related
> to the HDPC clock.

OK, sorry for the misunderstanding.


- Paul
