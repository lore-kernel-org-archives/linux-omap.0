From: archit taneja <archit@ti.com>
Subject: Re: [PATCH 4/4] OMAP: DSS2: Check for SDI HW before accessing SDI
 registers
Date: Tue, 1 Mar 2011 12:19:13 +0530
Message-ID: <4D6C96E9.20206@ti.com>
References: <1298554461-9879-1-git-send-email-tomi.valkeinen@ti.com> <1298554461-9879-4-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60780 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755080Ab1CAGqZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Mar 2011 01:46:25 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p216kMTj021697
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 1 Mar 2011 00:46:24 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p216kL4w019230
	for <linux-omap@vger.kernel.org>; Tue, 1 Mar 2011 12:16:21 +0530 (IST)
In-Reply-To: <1298554461-9879-4-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Thursday 24 February 2011 07:04 PM, Valkeinen, Tomi wrote:
> Only OMAP 3430 hardware has SDI support. The availability of SDI HW can
> be found out by checking if the LCD channel supports SDI displays.
>
> This patch checks for SDI HW support before accessing SDI registers,
> which fixes a crash on OMAP4 when SDI SW support is compiled in.
>
> Signed-off-by: Tomi Valkeinen<tomi.valkeinen@ti.com>
> ---
>   drivers/video/omap2/dss/display.c |   10 ++++++++++
>   drivers/video/omap2/dss/dss.c     |   29 ++++++++++++++++++-----------
>   2 files changed, 28 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/video/omap2/dss/display.c b/drivers/video/omap2/dss/display.c
> index 3f4fa0b..58459f4 100644
> --- a/drivers/video/omap2/dss/display.c
> +++ b/drivers/video/omap2/dss/display.c
> @@ -30,6 +30,7 @@
>
>   #include<plat/display.h>
>   #include "dss.h"
> +#include "dss_features.h"
>
>   static LIST_HEAD(display_list);
>
> @@ -392,6 +393,15 @@ void dss_init_device(struct platform_device *pdev,
>   	struct device_attribute *attr;
>   	int i;
>   	int r;
> +	enum omap_display_type supported;
> +
> +	supported = dss_feat_get_supported_displays(dssdev->channel);
> +
> +	if (!(supported&  dssdev->type)) {
> +		DSSERR("Unsupported display interface for display '%s'.\n",
> +				dssdev->name);
> +		return;
> +	}

This would make it necessary to specify the channel in the board file, 
especially digit. I think this patch should also add the channel 
parameters for all board files which add a tv display.

<snip>

Archit
