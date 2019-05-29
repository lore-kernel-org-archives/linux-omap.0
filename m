From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv6 0/4] omapdrm: DSI command mode panel support
Date: Wed, 29 May 2019 01:10:38 -0700
Message-ID: <20190529081038.GP5447@atomide.com>
References: <20190523200756.25314-1-sebastian.reichel@collabora.com>
 <60c45d23-de2f-d94a-c3d7-146a2bee538f@ti.com>
 <20190527112122.GJ5447@atomide.com>
 <e507c415-38de-86fe-9265-4b0aed0d7224@ti.com>
 <20190528093952.GM5447@atomide.com>
 <14c6c702-844b-756d-2d97-44e8f5a169df@ti.com>
 <20190528101847.GN5447@atomide.com>
 <ac487765-01a3-2c82-d86e-db00451563a9@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <ac487765-01a3-2c82-d86e-db00451563a9@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>, Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "H. Nikolaus Schaller" <hns@goldelico.com>, dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@collabora.com, Keerthy <j-keerthy@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>
List-Id: linux-omap@vger.kernel.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [190529 07:06]:
> On 28/05/2019 13:18, Tony Lindgren wrote:
> 
> > > My board is x15 rev A3, attached to AM5 EVM. I've also attached my kernel
> > > config.
> > 
> > Strange that this is not affecting other x15? I think timer12 would
> > be blocked on HS devices though?
> 
> Seems that the kernel config affects. omap2plus_defconfig boots ok.

OK, this line in your oops:

Unable to handle kernel paging request at virtual address 5a5a5a5a

Probably means we hit some slab poison with DEBUG_SLAB set.
Looks like your config boots fine with DEBUG_SLAB disabled
for me.

As this only happens for timer12, I wonder if we're again
hitting some uncompress issue with corrupted dtb. Changing
u-boot ftdaddr higher up might possibly make it go away.
Or else there's a bug elsewhere :)

Regards,

Tony
