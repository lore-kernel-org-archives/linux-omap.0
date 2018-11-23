From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv5 4/6] drm/omap: fix incorrect union usage
Date: Fri, 23 Nov 2018 09:33:10 -0800
Message-ID: <20181123173310.GI53235@atomide.com>
References: <20181121160916.22017-1-sebastian.reichel@collabora.com>
 <20181121160916.22017-5-sebastian.reichel@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181121160916.22017-5-sebastian.reichel@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Sebastian Reichel <sre@kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Pavel Machek <pavel@ucw.cz>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "H. Nikolaus Schaller" <hns@goldelico.com>, dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@collabora.com
List-Id: linux-omap@vger.kernel.org

* Sebastian Reichel <sebastian.reichel@collabora.com> [181121 16:09]:
> The DSI encoder sets dssdev->ops->dsi.set_config, which is stored at the
> same offset as dssdev->ops->hdmi.set_hdmi_mode. The code in omap_encoder
> only checks if dssdev->ops->hdmi.set_hdmi_mode is NULL. Due to the way
> union works, it won't be NULL if dsi.set_config is set. This means
> dsi_set_config will be called with config=hdmi_mode=false=NULL parameter
> resulting in a NULL dereference. Also the dereference happens while
> console is locked, so kernel hangs without any debug output without
> "fb.lockless_register_fb=1" parameter.
> 
> This restructures the code, so that the HDMI mode is only configured
> for HDMI output types. The new function also has a safe-guard directly
> before accessing the union, that can be optimized away by the compiler
> when the function is inlined and HDMI type has already been checked.
> 
> Fixes: 83910ad3f51fb ("drm/omap: Move most omap_dss_driver operations to omap_dss_device_ops")
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Works for me:

Tested-by: Tony Lindgren <tony@atomide.com>
