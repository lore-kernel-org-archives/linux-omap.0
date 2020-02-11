From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/3] ARM: dts: am437x-gp/epos-evm: drop unused panel
 timings
Date: Tue, 11 Feb 2020 08:05:24 -0800
Message-ID: <20200211160524.GE64767@atomide.com>
References: <20191114093950.4101-3-tomi.valkeinen@ti.com>
 <20191202130459.GH4929@pendragon.ideasonboard.com>
 <20191211165331.GC43123@atomide.com>
 <45dae8f7-2f5e-6948-5a05-dc8a09ace1fa@ti.com>
 <20191212203550.GB4892@pendragon.ideasonboard.com>
 <add3d8af-6977-68e6-fb77-2fa748c4714a@ti.com>
 <b39e52f1-3e73-5f26-6206-0956cf482631@ti.com>
 <20200211110712.GB28355@pendragon.ideasonboard.com>
 <3b4d10c6-7cb2-af53-3a39-31eef441bfdd@ti.com>
 <98da360f-880b-af56-b285-4d9b39f8a342@wizzup.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:54650 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728102AbgBKQF2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Tue, 11 Feb 2020 11:05:28 -0500
Content-Disposition: inline
In-Reply-To: <98da360f-880b-af56-b285-4d9b39f8a342@wizzup.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Merlijn Wajer <merlijn@wizzup.org>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linux-OMAP <linux-omap@vger.kernel.org>, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Jyri Sarha <jsarha@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Aaro Koskinen <aaro.koskinen@iki.fi>

* Merlijn Wajer <merlijn@wizzup.org> [200211 12:54]:
> Hi,
> 
> On 11/02/2020 12:08, Tomi Valkeinen wrote:
> > On 11/02/2020 13:07, Laurent Pinchart wrote:
> > 
> >>> Hopefully soon (in five years? =) we can say that omapdrm supports all
> >>> the boards, and we can deprecate omapfb.
> >>
> >> I'd love to send a patch to remove omapfb, but I'll let you do the
> >> honours :-)
> > 
> > Not before we add DSI support to omapdrm...

Hmm do your mean RFBI? The DSI support we already have :)

> This is probably known, but for devices that would like use PowerVR SGX,
> there sometimes is only userspace available that works with omap(l)fb,
> and not with DRM. The Nokia N900 is such an example.
> 
> There might be a newer release of (closed) userspace coming for the
> aging device(s), but as it stands, I don't think it's possible to do 3D
> with PowerVR SGX on omapdrm currently.
> 
> But I might be wrong...

Yes SGX is a bottleneck currently for omap3 users. And I think
RFBI is blocking n8x0 from moving to omapdrm and finally leaving
drivers/video/fbdev/omap2 behind.

With those blockers fixed, I'd also be happy to just get rid of
drivers/video/fbdev/omap2 as there should be no reason to
keep using it.

Regards,

Tony
