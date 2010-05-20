From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 1/4] fbdev: add a MIPI DSI header
Date: Thu, 20 May 2010 11:02:55 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1005201058250.26000@axis700.grange>
References: <Pine.LNX.4.64.1005071054510.4777@axis700.grange>
 <Pine.LNX.4.64.1005071102440.4777@axis700.grange>
 <1274255350.2307.159.camel@tubuntu.research.nokia.com>
 <Pine.LNX.4.64.1005190955500.3099@axis700.grange>
 <1274257308.2307.168.camel@tubuntu.research.nokia.com>
 <Pine.LNX.4.64.1005200939030.26000@axis700.grange>
 <1274344369.4246.28.camel@tubuntu.research.nokia.com> <20100520085405.GA14584@gandalf>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20100520085405.GA14584@gandalf>
Sender: linux-sh-owner@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Syrjala Ville (Nokia-D/Helsinki)" <ville.syrjala@nokia.com>
List-Id: linux-omap@vger.kernel.org

On Thu, 20 May 2010, Felipe Balbi wrote:

> On Thu, May 20, 2010 at 11:32:49AM +0300, Tomi Valkeinen wrote:
> > On Thu, 2010-05-20 at 10:07 +0200, ext Guennadi Liakhovetski wrote:
> > 
> > > Yes, right, I should have said "they are related";) How about calling the 
> > > header mipi_display.h? This would then unite DSI, DCS, DBI and DPI? 
> > > Creating a separate header for each of these standards seems like an 
> > > overkill to me. We could then put MIPI CSI and CPI standards in an 
> > > include/media/mipi_camera.h. Not sure where to put various other MIPI 
> > > standards, I guess, we'll have to think about it as a need arises.
> > 
> > mipi_display.h sounds good to me.
> 
> if there are extra mipi standards which should be taken care of, why
> not include/linux/mipi/[display.h camera.h other1.h other2.h...] ?

I thought about this too, but I prefer to separate them thematically: 
put display standards under video/, camera under media/ etc. This way 
including these headers from respective drivers and platform code would 
look more naturally, IMHO.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
