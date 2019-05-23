From: Joe Perches <joe@perches.com>
Subject: Re: [PATCHv6 1/4] drm/omap: use DRM_DEBUG_DRIVER instead of CORE
Date: Thu, 23 May 2019 13:19:15 -0700
Message-ID: <f1fa87acecc7cb5329d28d42f7327742aceb04db.camel@perches.com>
References: <20190523200756.25314-1-sebastian.reichel@collabora.com>
         <20190523200756.25314-2-sebastian.reichel@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190523200756.25314-2-sebastian.reichel@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.com>, Sebastian Reichel <sre@kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: "H. Nikolaus Schaller" <hns@goldelico.com>, dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@collabora.com
List-Id: linux-omap@vger.kernel.org

On Thu, 2019-05-23 at 22:07 +0200, Sebastian Reichel wrote:
> This macro is only used by omapdrm, which should print
> debug messages using the DRIVER category instead of the
> default CORE category.
[]
> diff --git a/drivers/gpu/drm/omapdrm/omap_drv.h b/drivers/gpu/drm/omapdrm/omap_drv.h
[]
> @@ -37,8 +37,8 @@
>  #include "omap_irq.h"
>  #include "omap_plane.h"
>  
> -#define DBG(fmt, ...) DRM_DEBUG(fmt"\n", ##__VA_ARGS__)
> -#define VERB(fmt, ...) if (0) DRM_DEBUG(fmt, ##__VA_ARGS__) /* verbose debug */
> +#define DBG(fmt, ...) DRM_DEBUG_DRIVER(fmt"\n", ##__VA_ARGS__)
> +#define VERB(fmt, ...) if (0) DRM_DEBUG_DRIVER(fmt, ##__VA_ARGS__) /* verbose debug */

Trivia:

Strictly, this should use do { if (0) etc... } while (0)

Also, none of the VERB uses have a terminating newline
so ideally, this should be:

#define VERB(fmt, ...) do { if (0) DRM_DEBUG_DRIVER(fmt "\n", ##__VA_ARGS__); } while (0) /* verbose debug */

And VERB isn't a particularly intelligible macro name.
Maybe VDBG instead.
