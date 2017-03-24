From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2 10/10] ARM: dts: n950: add display support
Date: Fri, 24 Mar 2017 08:12:02 -0700
Message-ID: <20170324151202.GZ10760@atomide.com>
References: <20170304235021.27055-1-sre@kernel.org>
 <20170305004309.28259-1-sre@kernel.org>
 <20170305004309.28259-10-sre@kernel.org>
 <20170324142939.GY10760@atomide.com>
 <fe873378-a93f-5829-215c-fb4a3cc3f514@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <fe873378-a93f-5829-215c-fb4a3cc3f514@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Sebastian Reichel <sre@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, David Airlie <airlied@linux.ie>, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [170324 08:01]:
> On 24/03/17 16:29, Tony Lindgren wrote:
> > * Sebastian Reichel <sre@kernel.org> [170304 16:45]:
> >> Add basic panel support for the Nokia N950. It must be tweaked a
> >> little bit later, since the panel was built into the device
> >> upside-down. Also the first 5 and the last 5 pixels are covered
> >> by plastic.
> > 
> > This one seems safe to apply separately to shrink the pending
> > patches a bit. Please confirm if that's the case and I'll apply
> > this one.
> 
> No, I think there are too many open questions to apply this one. And we
> need to move to common DRM drivers at some point (hopefully soon) so the
> bindings must be aligned with those if and when possible.

Hmm so what are the open questions and do you have in mind for
the panel bindings?

Naturally we still need to support the current bindings too.

Regards,

Tony
