From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH 00/23] Nokia N950 display support
Date: Tue, 8 Mar 2016 20:39:08 +0200
Message-ID: <20160308183908.GA31741@raspberrypi.musicnaut.iki.fi>
References: <1457455195-1938-1-git-send-email-sre@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1457455195-1938-1-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, David Airlie <airlied@linux.ie>, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Tue, Mar 08, 2016 at 05:39:32PM +0100, Sebastian Reichel wrote:
> This series adds support for the Nokia N950 display.
> Since the panel is using DSI command mode, it involves
> adding support for manually updated displays to
> omapdrm.

Works OK, but the picture seems to be upside down? Also shouldn't the
default orientation be landscape?

A.
