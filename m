From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2 03/10] Revert "drm: omapdrm: Remove manual update
 display support"
Date: Mon, 20 Mar 2017 09:14:05 -0700
Message-ID: <20170320161404.GL20572@atomide.com>
References: <20170304235021.27055-1-sre@kernel.org>
 <20170305004309.28259-1-sre@kernel.org>
 <20170305004309.28259-3-sre@kernel.org>
 <e04edb75-d8bd-5380-f91a-ff425bd91404@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <e04edb75-d8bd-5380-f91a-ff425bd91404@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Sebastian Reichel <sre@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, David Airlie <airlied@linux.ie>, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [170320 04:10]:
> On 05/03/17 02:43, Sebastian Reichel wrote:
> > This reverts commit 5a35876e2830511cb8110667fc426c6a6165a593.
> > 
> > Revert the removal of manual update display support in
> > preparation for DSI command mode panels.
> 
> I think it's much better to just add the manual update support from
> scratch rather than first reverting this old cleanup commit and then
> adding more bits and pieces.

Do you know if the command mode panels support partial refresh?

Just wondering if we want to keep "int x, int y, int w, int h"
around for omap_connector_flush() or whatever it ends up being?

Regards,

Tony
