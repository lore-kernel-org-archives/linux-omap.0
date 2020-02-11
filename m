From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 2/3] ARM: dts: am437x-gp/epos-evm: drop unused panel
 timings
Date: Tue, 11 Feb 2020 13:10:07 +0200
Message-ID: <20200211111007.GC28355@pendragon.ideasonboard.com>
References: <20191114093950.4101-1-tomi.valkeinen@ti.com>
 <20191114093950.4101-3-tomi.valkeinen@ti.com>
 <20191202130459.GH4929@pendragon.ideasonboard.com>
 <20191211165331.GC43123@atomide.com>
 <45dae8f7-2f5e-6948-5a05-dc8a09ace1fa@ti.com>
 <20191212203550.GB4892@pendragon.ideasonboard.com>
 <add3d8af-6977-68e6-fb77-2fa748c4714a@ti.com>
 <b39e52f1-3e73-5f26-6206-0956cf482631@ti.com>
 <20200211110712.GB28355@pendragon.ideasonboard.com>
 <3b4d10c6-7cb2-af53-3a39-31eef441bfdd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([213.167.242.64]:46616 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727558AbgBKLKX (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Tue, 11 Feb 2020 06:10:23 -0500
Content-Disposition: inline
In-Reply-To: <3b4d10c6-7cb2-af53-3a39-31eef441bfdd@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux-OMAP <linux-omap@vger.kernel.org>, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Jyri Sarha <jsarha@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>

On Tue, Feb 11, 2020 at 01:08:12PM +0200, Tomi Valkeinen wrote:
> On 11/02/2020 13:07, Laurent Pinchart wrote:
> 
> >> Hopefully soon (in five years? =) we can say that omapdrm supports all
> >> the boards, and we can deprecate omapfb.
> > 
> > I'd love to send a patch to remove omapfb, but I'll let you do the
> > honours :-)
> 
> Not before we add DSI support to omapdrm...

Details, details ;-)

Seriously speaking, Sebastian's patches are on my todo list.

-- 
Regards,

Laurent Pinchart
