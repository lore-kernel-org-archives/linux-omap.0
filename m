From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v4 1/2] DTS: GTA04: improve panel compatibility string
Date: Tue, 19 Dec 2017 06:37:33 -0800
Message-ID: <20171219143733.GL3875@atomide.com>
References: <cover.1512114082.git.hns@goldelico.com>
 <280160905017f67c91b96bf38ea9b6094ec277c3.1512114082.git.hns@goldelico.com>
 <20171211152203.GH24344@atomide.com>
 <e52a086f-6748-0e5e-f9b5-d4532c34d215@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <e52a086f-6748-0e5e-f9b5-d4532c34d215@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: "H. Nikolaus Schaller" <hns@goldelico.com>, Thierry Reding <thierry.reding@gmail.com>, David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Russell King <linux@armlinux.org.uk>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Julia Lawall <Julia.Lawall@lip6.fr>, Sean Paul <seanpaul@chromium.org>, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org, letux-kernel@openphoenux.org, kernel@pyra-handheld.com
List-Id: linux-omap@vger.kernel.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [171219 10:51]:
> On 11/12/17 17:22, Tony Lindgren wrote:
> > * H. Nikolaus Schaller <hns@goldelico.com> [171201 07:44]:
> > > Official vendor string is now "tpo" and not "toppoly".
> > > 
> > > Requires patch "omapdrm: panel: fix compatible vendor string for td028ttec1"
> > > so that the driver understands both.
> > 
> > Tomi, so what's the plan with the dependency patch, is that for v4.16
> > or for the v4.15-rc cycle?
> 
> The dependency patch for this one is queued for v4.16 (I just sent a pull
> request today). I could pick this one up (if you give an ack) if I send
> another DRM pull request, but I probably don't have anything else to send so
> most likely I won't pick this up for v4.16.

OK thanks I'll queue both of these for v4.16 then.

> The patch 2/2 in the series doesn't have dependencies and can be applied as
> a fix for 4.15, or for 4.16.
> 
> Neither of these are critical, as things work fine without these patches.

OK thanks for confirming that.

Regards,

Tony
