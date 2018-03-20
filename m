From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2 0/8] omapdrm: DSI command mode panel support
Date: Tue, 20 Mar 2018 07:31:34 -0700
Message-ID: <20180320143134.GZ5799@atomide.com>
References: <20180208183035.8461-1-sebastian.reichel@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180208183035.8461-1-sebastian.reichel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Sebastian Reichel <sre@kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Hans de Goede <hdegoede@redhat.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@collabora.com
List-Id: linux-omap@vger.kernel.org

Tomi,

* Sebastian Reichel <sebastian.reichel@collabora.co.uk> [180208 10:31]:
> Hi,
> 
> These are the remaining patches from my previous patchset to get
> Droid 4 (omap4) display working. The patches have been rebased to
> current master branch from Torvalds (581e400ff935). Since N950
> (omap3) is broken even with the workaround I moved it to the end,
> so that it can be skipped.

Seems like the first three patches of these could be applied
for v4.17 separate from the rotation and omap3 related issues?

Regards,

Tony
