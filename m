From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH] video: fbdev: omap2: remove rfbi
Date: Fri, 27 Apr 2018 21:12:43 +0300
Message-ID: <20180427181243.o7ro63l6z7yatey7@darkstar.musicnaut.iki.fi>
References: <CGME20180427150914eucas1p14dd8df4a215014ddac990b0ccdb1805c@eucas1p1.samsung.com>
 <2238944.jilJcacc6d@amdc3058>
 <20180427174714.bdvvlljk3txwu2bo@darkstar.musicnaut.iki.fi>
 <2055912.iuafLNK0IC@amdc3058>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2055912.iuafLNK0IC@amdc3058>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

Hi,

On Fri, Apr 27, 2018 at 07:58:28PM +0200, Bartlomiej Zolnierkiewicz wrote:
> On Friday, April 27, 2018 08:47:14 PM Aaro Koskinen wrote:
> > On Fri, Apr 27, 2018 at 05:09:14PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > > omapfb equivalent of drm's commit aa61321d4c08 ("drm/omap: remove rfbi"):
> > > 
> > > The RFBI driver has not worked nor compiled for many years. There are
> > > very few boards out there that use RFBI, and no one has stepped up to
> > > fix it.
> > >
> > > So let's remove the RFBI code that doesn't even compile.
> > 
> > NACK. I'm just about to start fixing this and hoping to get display
> > working on N8x0 boards.
> > 
> > See the other thread: https://marc.info/?l=linux-omap&m=152469100217934&w=2
> 
> You should be targeting omapdrm driver instead, fbdev subsystem is closed
> for the new hardware support.

AFAIK, based on N950 display support discussion, it's impossible to get
anything new into omapdrm for a long time. And based on Tomi's comments,
restoring RFBI support with omapfb should be a minor thing.

A.
