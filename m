From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH 0/3] OMAP: DSS2: Add Zorder Support on OMAP4
Date: Fri, 23 Jul 2010 12:07:57 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044ED62FBF@dbde02.ent.ti.com>
References: <1279541407-17711-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:32953 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751554Ab0GWGiI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Jul 2010 02:38:08 -0400
In-Reply-To: <1279541407-17711-1-git-send-email-archit@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Taneja, Archit" <archit@ti.com>, "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Semwal, Sumit" <sumit.semwal@ti.com>


> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Archit Taneja
> Sent: Monday, July 19, 2010 5:40 PM
> To: tomi.valkeinen@nokia.com
> Cc: linux-omap@vger.kernel.org; Semwal, Sumit
> Subject: [PATCH 0/3] OMAP: DSS2: Add Zorder Support on OMAP4
> 
> From: Sumit Semwal <sumit.semwal@ti.com>
> 
> This patch series adds Zorder Support on OMAP4, this feature
> allows deciding the visibility order of the overlays based on
> the Zorder value given to a sysfs attribute of the overlay object.
> 
> Since this feature is not supported on OMAP3 and OMAP2, the sysfs
> attibutes always return Zorder as 0 and do not write to dispc registers
> for non OMAP4 architectures.
> 
> This patch series applies over the submitted series:
> 
> https://patchwork.kernel.org/patch/112648/
> 
> Sumit Semwal (3):
>   OMAP: DSS2: Zorder enum in display.h
>   OMAP: DSS2: Zorder functions for DISPC
>   OMAP: DSS2: Zorder sysfs attributes, out of bound checks and
> initialization
[Hiremath, Vaibhav] Archit,

Here also I think we can merge all of these patches into single patch, something like,

OMAP: DSS2: Add support for Zorder feature (applicable for OMAP4 & more)

OR, worst case you can split it into 2 patches, something like,

OMAP: DSS2: Add support for Zorder feature (applicable for OMAP4 & more)
OMAP: DSS2: Add set/enable SYFS interface for Zorder feature

Thanks,
Vaibhav
> ---
>  arch/arm/plat-omap/include/plat/display.h |    8 ++++
>  drivers/video/omap2/dss/dispc.c           |   23 +++++++++++++
>  drivers/video/omap2/dss/dss.h             |    3 ++
>  drivers/video/omap2/dss/manager.c         |    4 ++
>  drivers/video/omap2/dss/overlay.c         |   51
> +++++++++++++++++++++++++++++
>  5 files changed, 89 insertions(+), 0 deletions(-)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
