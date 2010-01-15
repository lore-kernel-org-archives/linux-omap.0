From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH] OMAP3630:DSS2:Enable Pre-Multiplied Alpha Support
Date: Fri, 15 Jan 2010 12:29:53 +0200
Message-ID: <1263551393.2087.249.camel@tubuntu.research.nokia.com>
References: <E0D41E29EB0DAC4E9F3FF173962E9E94026AD3FF3B@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:21491 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752368Ab0AOK2g (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Jan 2010 05:28:36 -0500
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E94026AD3FF3B@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Y, Kishore" <kishore.y@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Mon, 2009-12-21 at 16:06 +0100, ext Y, Kishore wrote:
> From 2f873819a4b9eb0bd658db1e59408d8f0aeb14b6 Mon Sep 17 00:00:00 2001
> From: Sudeep Basavaraj <sudeep.basavaraj@ti.com>
> Date: Mon, 14 Dec 2009 18:54:51 +0530
> Subject: [PATCH] OMAP3630:DSS2:Enable Pre-Multiplied Alpha Support
> 
> Enables dss to process color formats with pre-mulitplied alpha values.
> With this we can have alpha values defined for each pixel
> and hence can have different blending values for each pixel.

What does pre-multiplied alpha mean? The TRM didn't really open it up...
Don't we already have per pixel alpha when using ARGB/RGBA?

This patch seems to always set the bit on, never set it off. Is that the
purpose?

 Tomi


> Signed-off-by: Sudeep Basavaraj <sudeep.basavaraj@ti.com>
> Signed-off-by: Kishore Y <kishore.y@ti.com>
> ---
>  drivers/video/omap2/dss/dispc.c |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
> index 6dabf4b..5f7819b 100644
> --- a/drivers/video/omap2/dss/dispc.c
> +++ b/drivers/video/omap2/dss/dispc.c
> @@ -913,6 +913,11 @@ static void _dispc_set_vid_color_conv(enum omap_plane plane, bool enable)
>  	dispc_write_reg(dispc_reg_att[plane], val);
>  }
>  
> +static void _dispc_set_alpha_blend_attrs(enum omap_plane plane, bool enable)
> +{
> +	REG_FLD_MOD(dispc_reg_att[plane], enable ? 1 : 0, 28, 28);
> +}
> +
>  void dispc_enable_replication(enum omap_plane plane, bool enable)
>  {
>  	int bit;
> @@ -1689,6 +1694,9 @@ static int _dispc_setup_plane(enum omap_plane plane,
>  
>  	_dispc_set_rotation_attrs(plane, rotation, mirror, color_mode);
>  
> +	if (cpu_is_omap3630() && (plane != OMAP_DSS_VIDEO1))
> +		_dispc_set_alpha_blend_attrs(plane, 1);
> +
>  	if (plane != OMAP_DSS_VIDEO1)
>  		_dispc_setup_global_alpha(plane, global_alpha);
>  


