From: "Janorkar, Mayuresh" <mayur@ti.com>
Subject: RE: [PATCH 0/8] OMAP: DSS2: Miscellaneous patches
Date: Wed, 11 May 2011 09:15:55 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB033DBC0B9D@dbde02.ent.ti.com>
References: <1305044656-31512-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52480 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753906Ab1EKDqG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 May 2011 23:46:06 -0400
In-Reply-To: <1305044656-31512-1-git-send-email-tomi.valkeinen@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>



> -----Original Message-----
> From: linux-fbdev-owner@vger.kernel.org [mailto:linux-fbdev-
> owner@vger.kernel.org] On Behalf Of Valkeinen, Tomi
> Sent: Tuesday, May 10, 2011 9:54 PM
> To: linux-omap@vger.kernel.org; linux-fbdev@vger.kernel.org
> Cc: Valkeinen, Tomi
> Subject: [PATCH 0/8] OMAP: DSS2: Miscellaneous patches
> 
> Here are some smallish fixes and cleanups I made while porting N800's
> display
> driver to DSS2.
> 
>  Tomi
> 
> Tomi Valkeinen (8):
>   OMAP: DSS2: Add missing dummy functions
>   OMAPFB: fix wrong clock aliases and device name
>   OMAP: DSS2: RFBI: add rfbi_bus_lock
>   OMAP: DSS2: RFIB: clock enable/disable changes
RFIB a typo?

>   OMAP: DSS2: RFBI: add omap_rfbi_configure
>   OMAP: DSS2: RFIB: cleanup
Same here

>   OMAP: DSS2: OMAPFB: remove dead code
>   OMAP: DSS2: OMAPFB: Reduce stack usage
> 
>  arch/arm/plat-omap/include/plat/display.h |    4 +
>  drivers/video/omap/dispc.c                |    4 +-
>  drivers/video/omap/omapfb_main.c          |    2 +-
>  drivers/video/omap/rfbi.c                 |    2 +-

If the series touches drivers/video/omap then the title should be "DSS and DSS2" using only DSS2 is misleading.


>  drivers/video/omap2/dss/dss.h             |   28 ++++-
>  drivers/video/omap2/dss/rfbi.c            |  174 +++++-------------------
> -----
>  drivers/video/omap2/omapfb/omapfb-main.c  |   78 +++++--------
>  7 files changed, 86 insertions(+), 206 deletions(-)
> 
> --
> 1.7.4.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
