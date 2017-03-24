From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2 10/10] ARM: dts: n950: add display support
Date: Fri, 24 Mar 2017 07:29:39 -0700
Message-ID: <20170324142939.GY10760@atomide.com>
References: <20170304235021.27055-1-sre@kernel.org>
 <20170305004309.28259-1-sre@kernel.org>
 <20170305004309.28259-10-sre@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170305004309.28259-10-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, David Airlie <airlied@linux.ie>, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Sebastian Reichel <sre@kernel.org> [170304 16:45]:
> Add basic panel support for the Nokia N950. It must be tweaked a
> little bit later, since the panel was built into the device
> upside-down. Also the first 5 and the last 5 pixels are covered
> by plastic.

This one seems safe to apply separately to shrink the pending
patches a bit. Please confirm if that's the case and I'll apply
this one.

Regards,

Tony
