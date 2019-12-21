From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] drm/omap: gem: Fix tearing with BO_TILED
Date: Sat, 21 Dec 2019 08:41:41 -0800
Message-ID: <20191221164141.GI35479@atomide.com>
References: <20191221005711.47314-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <20191221005711.47314-1-tony@atomide.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Matthijs van Duin <matthijsvanduin@gmail.com>, "H . Nikolaus Schaller" <hns@goldelico.com>, Merlijn Wajer <merlijn@wizzup.org>, Sebastian Reichel <sre@kernel.org>, dri-devel@lists.freedesktop.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [191220 16:57]:
> Looking around what might affect BO_TILED, I noticed Matthijs had this
> change in his earlier pyra tiler patches. The earlier patch "XXX omapdrm:
> force tiled buffers to be pinned and page-aligned" has no commit log
> though, so I'm not sure what other issues this might fix.
..
> Matthijs, do you have some more info to add to the description?

Also, I'm wondering if this change makes sense alone without the pinning
changes for a fix, or if also the pinning changes are needed.

For reference, the original related patch(es) are available at [0] below.

Regards,

Tony

[0] https://github.com/mvduin/linux/commit/70593563f531a7ac4a3f6ebed0fc98ef86742b12
