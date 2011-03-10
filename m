From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v5 03/10] OMAP4 : DSS2 : HDMI: Dispc gamma enable
 set/reset function for TV.
Date: Thu, 10 Mar 2011 15:52:28 +0200
Message-ID: <1299765148.2017.186.camel@deskari>
References: <1299753858-12222-1-git-send-email-mythripk@ti.com>
	 <1299753858-12222-2-git-send-email-mythripk@ti.com>
	 <1299753858-12222-3-git-send-email-mythripk@ti.com>
	 <1299753858-12222-4-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53109 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751077Ab1CJNw3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Mar 2011 08:52:29 -0500
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p2ADqTBf003087
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 10 Mar 2011 07:52:29 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep34.itg.ti.com (8.13.7/8.13.7) with ESMTP id p2ADqSns028669
	for <linux-omap@vger.kernel.org>; Thu, 10 Mar 2011 07:52:28 -0600 (CST)
In-Reply-To: <1299753858-12222-4-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "K, Mythri P" <mythripk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, 2011-03-10 at 04:44 -0600, K, Mythri P wrote:
> Adding function to reset/set gamma table bit for TV interface
> currentl only support for disabled is added.

I guess this is missing a period, a capital C, and currently is typoed.

> Signed-off-by: Mythri P K <mythripk@ti.com>
> ---
>  drivers/video/omap2/dss/dispc.c |   13 +++++++++++++
>  drivers/video/omap2/dss/dss.h   |    1 +
>  2 files changed, 14 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
> index b8c576a..9b86f5f 100644
> --- a/drivers/video/omap2/dss/dispc.c
> +++ b/drivers/video/omap2/dss/dispc.c
> @@ -1008,6 +1008,19 @@ void dispc_set_burst_size(enum omap_plane plane,
>  	enable_clocks(0);
>  }
>  
> +void dispc_enable_gamma_table(bool enable)
> +{
> +	/* This is partially implemented to support only
> +	 *  disabling of the gamma table.
> +	 */

This isn't the kernel multiline comment convention.

 Tomi


