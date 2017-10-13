From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv1 00/14] omapdrm: DSI command mode panel support
Date: Fri, 13 Oct 2017 10:12:08 -0700
Message-ID: <20171013171207.GO4394@atomide.com>
References: <20170724173311.27170-1-sebastian.reichel@collabora.co.uk>
 <20170929132649.63dy7mzjgknaevoa@earth>
 <b66ec006-e998-b8c6-8ef1-5bf19208c100@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b66ec006-e998-b8c6-8ef1-5bf19208c100@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.co.uk>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [171012 01:46]:
> On 29/09/17 16:26, Sebastian Reichel wrote:
> > Hi Tomi & Laurent,
> > 
> > ping?
> 
> I've been having quick glances at this every now and then, but I'm not
> sure what to do with the series.
> 
> We have one work item that more or less overrides everything but
> critical fixes: moving to common DRM encoder/panel drivers. Anything
> that makes that work more difficult should be postponed.
> 
> Especially patch 6 in this series most likely falls into that category,
> and might require a very different implementation with common DRM
> drivers. Also everything in panel-dsi-cm needs to be ported to a common
> DRM panel driver when can use them.
> 
> So my gut feeling is that it's best to keep this out for now, and rework
> it after Laurent gets the common DRM drivers working with omapdrm.

Laurent, got any other comments?

Maybe some of patches can be already applied to shrink down this
set a bit?

Regards,

Tony
