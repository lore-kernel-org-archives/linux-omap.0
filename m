From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: RE: [OMAPZOOM] ISP: Fix indexing bug in csi2 module.
Date: Thu, 19 Feb 2009 12:09:49 -0600
Message-ID: <A24693684029E5489D1D202277BE894420AA1DC0@dlee02.ent.ti.com>
References: <200902191042.18843.dcurran@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52812 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755558AbZBSSJ5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Feb 2009 13:09:57 -0500
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n1JI9pHH008768
	for <linux-omap@vger.kernel.org>; Thu, 19 Feb 2009 12:09:56 -0600
Received: from dlee75.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id n1JI9pgR026412
	for <linux-omap@vger.kernel.org>; Thu, 19 Feb 2009 12:09:51 -0600 (CST)
In-Reply-To: <200902191042.18843.dcurran@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Curran, Dominic" <dcurran@ti.com>, linux-omap <linux-omap@vger.kernel.org>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>



> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Curran, Dominic
> Sent: Thursday, February 19, 2009 10:42 AM
> To: linux-omap
> Subject: [OMAPZOOM] ISP: Fix indexing bug in csi2 module.
> 
> From: Dominic Curran <dcurran@ti.com>
> Subject: [OMAPZOOM] ISP: Fix indexing bug in csi2 module.
> 
> This patch fixes an indexing bug in the CSI2 module.
> The functions:
>  isp_csi2_timings_update(..)
>  isp_csi2_timings_get(..)
> expect either a 1 or 2 which references the complexio number being
> referenced.
> The bug was that they were being passed a 0 & 1.
> 
> The issue was originally found by HP.
> 
> Signed-off-by: Dominic Curran <dcurran@ti.com>

Acked-by: Sergio Aguirre <saaguirre@ti.com>

> ---
>  drivers/media/video/isp/ispcsi2.c |   16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> Index: omapzoom04/drivers/media/video/isp/ispcsi2.c
> ===================================================================
> --- omapzoom04.orig/drivers/media/video/isp/ispcsi2.c
> +++ omapzoom04/drivers/media/video/isp/ispcsi2.c
> @@ -1526,7 +1526,7 @@ int isp_csi2_timings_config_forcerxmode(
>  	struct isp_csi2_timings_cfg *currtimings;
>  	struct isp_csi2_timings_cfg_update *currtimings_u;
> 
> -	if (io > 2) {
> +	if (io < 1 || io > 2) {
>  		printk(KERN_ERR "CSI2 - Timings config: Invalid IO number\n");
>  		return -EINVAL;
>  	}
> @@ -1552,7 +1552,7 @@ int isp_csi2_timings_config_stopstate_16
>  	struct isp_csi2_timings_cfg *currtimings;
>  	struct isp_csi2_timings_cfg_update *currtimings_u;
> 
> -	if (io > 2) {
> +	if (io < 1 || io > 2) {
>  		printk(KERN_ERR "CSI2 - Timings config: Invalid IO number\n");
>  		return -EINVAL;
>  	}
> @@ -1578,7 +1578,7 @@ int isp_csi2_timings_config_stopstate_4x
>  	struct isp_csi2_timings_cfg *currtimings;
>  	struct isp_csi2_timings_cfg_update *currtimings_u;
> 
> -	if (io > 2) {
> +	if (io < 1 || io > 2) {
>  		printk(KERN_ERR "CSI2 - Timings config: Invalid IO number\n");
>  		return -EINVAL;
>  	}
> @@ -1604,7 +1604,7 @@ int isp_csi2_timings_config_stopstate_cn
>  	struct isp_csi2_timings_cfg *currtimings;
>  	struct isp_csi2_timings_cfg_update *currtimings_u;
> 
> -	if (io > 2) {
> +	if (io < 1 || io > 2) {
>  		printk(KERN_ERR "CSI2 - Timings config: Invalid IO number\n");
>  		return -EINVAL;
>  	}
> @@ -1636,7 +1636,7 @@ int isp_csi2_timings_update(u8 io, bool
>  	struct isp_csi2_timings_cfg_update *currtimings_u;
>  	u32 reg;
> 
> -	if (io > 2) {
> +	if (io < 1 || io > 2) {
>  		printk(KERN_ERR "CSI2 - Timings config: Invalid IO number\n");
>  		return -EINVAL;
>  	}
> @@ -1706,7 +1706,7 @@ int isp_csi2_timings_get(u8 io)
>  	struct isp_csi2_timings_cfg_update *currtimings_u;
>  	u32 reg;
> 
> -	if (io > 2) {
> +	if (io < 1 || io > 2) {
>  		printk(KERN_ERR "CSI2 - Timings config: Invalid IO number\n");
>  		return -EINVAL;
>  	}
> @@ -1758,7 +1758,7 @@ int isp_csi2_timings_update_all(bool for
>  {
>  	int i;
> 
> -	for (i = 0; i < 2; i++)
> +	for (i = 1; i < 3; i++)
>  		isp_csi2_timings_update(i, force_update);
>  	return 0;
>  }
> @@ -1772,7 +1772,7 @@ int isp_csi2_timings_get_all(void)
>  {
>  	int i;
> 
> -	for (i = 0; i < 2; i++)
> +	for (i = 1; i < 3; i++)
>  		isp_csi2_timings_get(i);
>  	return 0;
>  }
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

