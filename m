From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2] OMAP: DSS2: FEATURES: DSI PLL parameter cleanup
Date: Tue, 15 Mar 2011 12:41:10 +0530
Message-ID: <1300173070.1946.20.camel@lappyti>
References: <1300163303-31662-1-git-send-email-archit@ti.com>
	 <1300163303-31662-3-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45691 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751917Ab1COHLP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Mar 2011 03:11:15 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p2F7BBua027384
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 15 Mar 2011 02:11:14 -0500
In-Reply-To: <1300163303-31662-3-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Taneja, Archit" <archit@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, 2011-03-14 at 23:28 -0500, Taneja, Archit wrote:
> The DSI PLL parameters (regm, regn, regm_dispc, regm_dsi, fint) have different
> fields and also different Max values on OMAP3 and OMAP4. Use dss features to
> calculate the register fields and min/max values based on current OMAP revision.
> 
> Signed-off-by: Archit Taneja <archit@ti.com>
> ---
> v2:
> use dss_feat_get_param_max()/min() instead of calculating range from field's
> start and end.
> 
> Note: Applies over:
> 
> http://gitorious.org/linux-omap-dss2/linux/commits/master
> 
> and the patches submitted on linux-omap:
> OMAP2PLUS: DSS2: FEATURES: Fix usage of dss_reg_field and dss_clk_source_name
> OMAP: DSS2: FEATURES: Functions to return min and max values of parameters
> 
>  drivers/video/omap2/dss/dsi.c          |   69 +++++++++++++++++---------
>  drivers/video/omap2/dss/dss_features.c |   84 +++++++++++++++++++++----------
>  drivers/video/omap2/dss/dss_features.h |   10 ++++
>  3 files changed, 113 insertions(+), 50 deletions(-)

Thanks, applied.

 Tomi


