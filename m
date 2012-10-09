From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCHv2 2/3] OMAP: move arch/arm/plat-omap/include/plat/vrfb.h
Date: Tue, 9 Oct 2012 12:54:39 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EB3A082@DBDE01.ent.ti.com>
References: <1349785827-27055-1-git-send-email-tomi.valkeinen@ti.com>
 <1349785827-27055-3-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52581 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753676Ab2JIMyp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Oct 2012 08:54:45 -0400
In-Reply-To: <1349785827-27055-3-git-send-email-tomi.valkeinen@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: "Taneja, Archit" <archit@ti.com>

On Tue, Oct 09, 2012 at 18:00:25, Valkeinen, Tomi wrote:
> Now that vrfb driver is not omap dependent anymore, we can move vrfb.h
> from arch/arm/plat-omap/include/plat to include/video/omapvrfb.h.
> 

Which baseline you are using? I tried it with linux-omap/master, patch[1/3] is failing -

patching file arch/arm/plat-omap/include/plat/vrfb.h
patching file drivers/media/video/omap/omap_vout.c
Hunk #1 FAILED at 45.
1 out of 1 hunk FAILED -- saving rejects to file drivers/media/video/omap/omap_vout.c.rej
patching file drivers/media/video/omap/omap_vout_vrfb.c
Hunk #1 FAILED at 17.
1 out of 1 hunk FAILED -- saving rejects to file drivers/media/video/omap/omap_vout_vrfb.c.rej
patching file drivers/media/video/omap/omap_voutdef.h
Hunk #1 FAILED at 12.
1 out of 1 hunk FAILED -- saving rejects to file drivers/media/video/omap/omap_voutdef.h.rej
patching file drivers/video/omap2/omapfb/omapfb-ioctl.c
patching file drivers/video/omap2/omapfb/omapfb-main.c
Hunk #1 succeeded at 33 with fuzz 2 (offset 1 line).
patching file drivers/video/omap2/omapfb/omapfb-sysfs.c
patching file drivers/video/omap2/vrfb.c
patching file include/video/omapvrfb.h



Note that, the directory structure has been changed in the mainline,
Now V4L2 OMAP Display driver is in "drivers/media/platform/omap/"

You have to rebase the patches and resend it.

Thanks,
Vaibhav

> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Vaibhav Hiremath <hvaibhav@ti.com>
> ---
>  arch/arm/plat-omap/include/plat/vrfb.h    |   66 -----------------------------
>  drivers/media/video/omap/omap_vout.c      |    2 +-
>  drivers/media/video/omap/omap_vout_vrfb.c |    2 +-
>  drivers/media/video/omap/omap_voutdef.h   |    2 +-
>  drivers/video/omap2/omapfb/omapfb-ioctl.c |    2 +-
>  drivers/video/omap2/omapfb/omapfb-main.c  |    2 +-
>  drivers/video/omap2/omapfb/omapfb-sysfs.c |    2 +-
>  drivers/video/omap2/vrfb.c                |    2 +-
>  include/video/omapvrfb.h                  |   66 +++++++++++++++++++++++++++++
>  9 files changed, 73 insertions(+), 73 deletions(-)
>  delete mode 100644 arch/arm/plat-omap/include/plat/vrfb.h
>  create mode 100644 include/video/omapvrfb.h
> 
> diff --git a/arch/arm/plat-omap/include/plat/vrfb.h b/arch/arm/plat-omap/include/plat/vrfb.h
> deleted file mode 100644
> index dafbb77..0000000
> --- a/arch/arm/plat-omap/include/plat/vrfb.h
> +++ /dev/null
> @@ -1,66 +0,0 @@
> -/*
> - * VRFB Rotation Engine
> - *
> - * Copyright (C) 2009 Nokia Corporation
> - * Author: Tomi Valkeinen <tomi.valkeinen@nokia.com>
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License along
> - * with this program; if not, write to the Free Software Foundation, Inc.,
> - * 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
> - */
> -
> -#ifndef __OMAP_VRFB_H__
> -#define __OMAP_VRFB_H__
> -
> -#define OMAP_VRFB_LINE_LEN 2048
> -
> -struct vrfb {
> -	u8 context;
> -	void __iomem *vaddr[4];
> -	unsigned long paddr[4];
> -	u16 xres;
> -	u16 yres;
> -	u16 xoffset;
> -	u16 yoffset;
> -	u8 bytespp;
> -	bool yuv_mode;
> -};
> -
> -#if defined(CONFIG_OMAP2_VRFB) || defined(CONFIG_OMAP2_VRFB_MODULE)
> -extern int omap_vrfb_request_ctx(struct vrfb *vrfb);
> -extern void omap_vrfb_release_ctx(struct vrfb *vrfb);
> -extern void omap_vrfb_adjust_size(u16 *width, u16 *height,
> -		u8 bytespp);
> -extern u32 omap_vrfb_min_phys_size(u16 width, u16 height, u8 bytespp);
> -extern u16 omap_vrfb_max_height(u32 phys_size, u16 width, u8 bytespp);
> -extern void omap_vrfb_setup(struct vrfb *vrfb, unsigned long paddr,
> -		u16 width, u16 height,
> -		unsigned bytespp, bool yuv_mode);
> -extern int omap_vrfb_map_angle(struct vrfb *vrfb, u16 height, u8 rot);
> -extern void omap_vrfb_restore_context(void);
> -
> -#else
> -static inline int omap_vrfb_request_ctx(struct vrfb *vrfb) { return 0; }
> -static inline void omap_vrfb_release_ctx(struct vrfb *vrfb) {}
> -static inline void omap_vrfb_adjust_size(u16 *width, u16 *height,
> -		u8 bytespp) {}
> -static inline u32 omap_vrfb_min_phys_size(u16 width, u16 height, u8 bytespp)
> -		{ return 0; }
> -static inline u16 omap_vrfb_max_height(u32 phys_size, u16 width, u8 bytespp)
> -		{ return 0; }
> -static inline void omap_vrfb_setup(struct vrfb *vrfb, unsigned long paddr,
> -		u16 width, u16 height, unsigned bytespp, bool yuv_mode) {}
> -static inline int omap_vrfb_map_angle(struct vrfb *vrfb, u16 height, u8 rot)
> -		{ return 0; }
> -static inline void omap_vrfb_restore_context(void) {}
> -#endif
> -#endif /* __VRFB_H */
> diff --git a/drivers/media/video/omap/omap_vout.c b/drivers/media/video/omap/omap_vout.c
> index f721fd2..940f39f 100644
> --- a/drivers/media/video/omap/omap_vout.c
> +++ b/drivers/media/video/omap/omap_vout.c
> @@ -45,7 +45,7 @@
>  #include <media/v4l2-ioctl.h>
>  
>  #include <plat/dma.h>
> -#include <plat/vrfb.h>
> +#include <video/omapvrfb.h>
>  #include <video/omapdss.h>
>  
>  #include "omap_voutlib.h"
> diff --git a/drivers/media/video/omap/omap_vout_vrfb.c b/drivers/media/video/omap/omap_vout_vrfb.c
> index 4be26abf6c..6c37f92 100644
> --- a/drivers/media/video/omap/omap_vout_vrfb.c
> +++ b/drivers/media/video/omap/omap_vout_vrfb.c
> @@ -17,7 +17,7 @@
>  #include <media/v4l2-device.h>
>  
>  #include <plat/dma.h>
> -#include <plat/vrfb.h>
> +#include <video/omapvrfb.h>
>  
>  #include "omap_voutdef.h"
>  #include "omap_voutlib.h"
> diff --git a/drivers/media/video/omap/omap_voutdef.h b/drivers/media/video/omap/omap_voutdef.h
> index 27a95d2..9ccfe1f 100644
> --- a/drivers/media/video/omap/omap_voutdef.h
> +++ b/drivers/media/video/omap/omap_voutdef.h
> @@ -12,7 +12,7 @@
>  #define OMAP_VOUTDEF_H
>  
>  #include <video/omapdss.h>
> -#include <plat/vrfb.h>
> +#include <video/omapvrfb.h>
>  
>  #define YUYV_BPP        2
>  #define RGB565_BPP      2
> diff --git a/drivers/video/omap2/omapfb/omapfb-ioctl.c b/drivers/video/omap2/omapfb/omapfb-ioctl.c
> index 606b89f..55a39be 100644
> --- a/drivers/video/omap2/omapfb/omapfb-ioctl.c
> +++ b/drivers/video/omap2/omapfb/omapfb-ioctl.c
> @@ -30,7 +30,7 @@
>  #include <linux/export.h>
>  
>  #include <video/omapdss.h>
> -#include <plat/vrfb.h>
> +#include <video/omapvrfb.h>
>  #include <plat/vram.h>
>  
>  #include "omapfb.h"
> diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/omap2/omapfb/omapfb-main.c
> index b103793..742a66b 100644
> --- a/drivers/video/omap2/omapfb/omapfb-main.c
> +++ b/drivers/video/omap2/omapfb/omapfb-main.c
> @@ -32,7 +32,7 @@
>  
>  #include <video/omapdss.h>
>  #include <plat/vram.h>
> -#include <plat/vrfb.h>
> +#include <video/omapvrfb.h>
>  
>  #include "omapfb.h"
>  
> diff --git a/drivers/video/omap2/omapfb/omapfb-sysfs.c b/drivers/video/omap2/omapfb/omapfb-sysfs.c
> index e8d8cc7..17aa174 100644
> --- a/drivers/video/omap2/omapfb/omapfb-sysfs.c
> +++ b/drivers/video/omap2/omapfb/omapfb-sysfs.c
> @@ -30,7 +30,7 @@
>  #include <linux/omapfb.h>
>  
>  #include <video/omapdss.h>
> -#include <plat/vrfb.h>
> +#include <video/omapvrfb.h>
>  
>  #include "omapfb.h"
>  
> diff --git a/drivers/video/omap2/vrfb.c b/drivers/video/omap2/vrfb.c
> index fda45cc..e4a0450 100644
> --- a/drivers/video/omap2/vrfb.c
> +++ b/drivers/video/omap2/vrfb.c
> @@ -28,7 +28,7 @@
>  #include <linux/mutex.h>
>  #include <linux/platform_device.h>
>  
> -#include <plat/vrfb.h>
> +#include <video/omapvrfb.h>
>  
>  #ifdef DEBUG
>  #define DBG(format, ...) pr_debug("VRFB: " format, ## __VA_ARGS__)
> diff --git a/include/video/omapvrfb.h b/include/video/omapvrfb.h
> new file mode 100644
> index 0000000..dafbb77
> --- /dev/null
> +++ b/include/video/omapvrfb.h
> @@ -0,0 +1,66 @@
> +/*
> + * VRFB Rotation Engine
> + *
> + * Copyright (C) 2009 Nokia Corporation
> + * Author: Tomi Valkeinen <tomi.valkeinen@nokia.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, write to the Free Software Foundation, Inc.,
> + * 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
> + */
> +
> +#ifndef __OMAP_VRFB_H__
> +#define __OMAP_VRFB_H__
> +
> +#define OMAP_VRFB_LINE_LEN 2048
> +
> +struct vrfb {
> +	u8 context;
> +	void __iomem *vaddr[4];
> +	unsigned long paddr[4];
> +	u16 xres;
> +	u16 yres;
> +	u16 xoffset;
> +	u16 yoffset;
> +	u8 bytespp;
> +	bool yuv_mode;
> +};
> +
> +#if defined(CONFIG_OMAP2_VRFB) || defined(CONFIG_OMAP2_VRFB_MODULE)
> +extern int omap_vrfb_request_ctx(struct vrfb *vrfb);
> +extern void omap_vrfb_release_ctx(struct vrfb *vrfb);
> +extern void omap_vrfb_adjust_size(u16 *width, u16 *height,
> +		u8 bytespp);
> +extern u32 omap_vrfb_min_phys_size(u16 width, u16 height, u8 bytespp);
> +extern u16 omap_vrfb_max_height(u32 phys_size, u16 width, u8 bytespp);
> +extern void omap_vrfb_setup(struct vrfb *vrfb, unsigned long paddr,
> +		u16 width, u16 height,
> +		unsigned bytespp, bool yuv_mode);
> +extern int omap_vrfb_map_angle(struct vrfb *vrfb, u16 height, u8 rot);
> +extern void omap_vrfb_restore_context(void);
> +
> +#else
> +static inline int omap_vrfb_request_ctx(struct vrfb *vrfb) { return 0; }
> +static inline void omap_vrfb_release_ctx(struct vrfb *vrfb) {}
> +static inline void omap_vrfb_adjust_size(u16 *width, u16 *height,
> +		u8 bytespp) {}
> +static inline u32 omap_vrfb_min_phys_size(u16 width, u16 height, u8 bytespp)
> +		{ return 0; }
> +static inline u16 omap_vrfb_max_height(u32 phys_size, u16 width, u8 bytespp)
> +		{ return 0; }
> +static inline void omap_vrfb_setup(struct vrfb *vrfb, unsigned long paddr,
> +		u16 width, u16 height, unsigned bytespp, bool yuv_mode) {}
> +static inline int omap_vrfb_map_angle(struct vrfb *vrfb, u16 height, u8 rot)
> +		{ return 0; }
> +static inline void omap_vrfb_restore_context(void) {}
> +#endif
> +#endif /* __VRFB_H */
> -- 
> 1.7.9.5
> 
> 

