From: Tony Lindgren <tony@atomide.com>
Subject: omapdrm regression in v4.17-rc series
Date: Wed, 23 May 2018 15:03:20 -0700
Message-ID: <20180523220320.GX98604@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, ivo.g.dimitrov.75@gmail.com, abcloriens@gmail.com, sre@kernel.org, martijn@brixit.nl, filip.matijevic.pz@gmail.com, Thorsten Leemhuis <regressions@leemhuis.info>, clayton@craftyguy.net, patrikbachan@gmail.com, serge@hallyn.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
List-Id: linux-omap@vger.kernel.org

Hi all,

I bisected the n900 LCD issue to commit 24aac6011f70 ("drm: omapdrm:
sdi: Allocate the sdi private data structure dynamically"). Reverting
this patch makes LCD work for me again on n900.

Any ideas?

Regards,

Tony
