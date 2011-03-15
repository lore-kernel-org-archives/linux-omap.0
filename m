From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAP: DSS2: FEATURES: Functions to return min and max
 values of parameters
Date: Tue, 15 Mar 2011 12:39:32 +0530
Message-ID: <1300172972.1946.19.camel@lappyti>
References: <1300163303-31662-1-git-send-email-archit@ti.com>
	 <1300163303-31662-2-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53974 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754169Ab1COHJi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Mar 2011 03:09:38 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p2F79ZiL010908
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 15 Mar 2011 02:09:37 -0500
In-Reply-To: <1300163303-31662-2-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Taneja, Archit" <archit@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, 2011-03-14 at 23:28 -0500, Taneja, Archit wrote:
> Create 2 functions dss_feat_get_param_min() and dss_feat_get_param_max() which
> return the minimum and maximum value of a parameter. Introduce a enum in
> dss_features called dss_range_param which contains parameters whose ranges we
> are interested in.
> 
> Replace this with dss_feat_get_max_dss_fck() which is specific to the parameter
> DSS_FCK.
> 
> Signed-off-by: Archit Taneja <archit@ti.com>
> ---
> Note: Applies over:
> 
> http://gitorious.org/linux-omap-dss2/linux/commits/master
> 
> and the patch submitted on linux-omap:
> OMAP2PLUS: DSS2: FEATURES: Fix usage of dss_reg_field and dss_clk_source_name
> 
>  drivers/video/omap2/dss/dsi.c          |    2 +-
>  drivers/video/omap2/dss/dss.c          |    2 +-
>  drivers/video/omap2/dss/dss_features.c |   36 ++++++++++++++++++++++++-------
>  drivers/video/omap2/dss/dss_features.h |    7 +++++-
>  4 files changed, 36 insertions(+), 11 deletions(-)

Thanks, looks good.

For future, usually in patches like this it would be good to explain in
the description the reason why this is made (well, it would be good
always to explain "why"). The patch alone doesn't really make sense,
only when the patch about DSI PLL parameters is applied it makes sense.

 Tomi


