From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH 00/23] Nokia N950 display support
Date: Wed, 9 Mar 2016 23:02:01 +0200
Message-ID: <20160309210201.GA5534@raspberrypi.musicnaut.iki.fi>
References: <1457455195-1938-1-git-send-email-sre@kernel.org>
 <20160308183908.GA31741@raspberrypi.musicnaut.iki.fi>
 <20160308204510.GA31069@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160308204510.GA31069@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, David Airlie <airlied@linux.ie>, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Tue, Mar 08, 2016 at 09:45:11PM +0100, Sebastian Reichel wrote:
> On Tue, Mar 08, 2016 at 08:39:08PM +0200, Aaro Koskinen wrote:
> > On Tue, Mar 08, 2016 at 05:39:32PM +0100, Sebastian Reichel wrote:
> > > This series adds support for the Nokia N950 display.
> > > Since the panel is using DSI command mode, it involves
> > > adding support for manually updated displays to
> > > omapdrm.
> > 
> > Works OK, but the picture seems to be upside down?
> 
> vertical, upside down is the native panel orientation.
> 
> > Also shouldn't the default orientation be landscape?
> 
> The N950 vendor kernel contains some code adding DSI
> rotation support with half-frame update mechnism to
> avoid tearing. It's quite complex and as far as I
> understand it also error-prone. Tomi knows more about
> that.

Ok, my comment was actually about fbcon (which doesn't need driver support
for rotation). But I guess there is no way to tell it what the default
should be, instead user needs to pass the correct rotation manually...

Anyway, for this series:

Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>

A.
