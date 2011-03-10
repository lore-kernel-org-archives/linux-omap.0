From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v5 07/10] OMAP4 : DSS2 : HDMI: Add makefile and kconfig
 changes to enable HDMI in OMAP4
Date: Thu, 10 Mar 2011 15:59:56 +0200
Message-ID: <1299765596.2017.193.camel@deskari>
References: <1299753858-12222-1-git-send-email-mythripk@ti.com>
	 <1299753858-12222-2-git-send-email-mythripk@ti.com>
	 <1299753858-12222-3-git-send-email-mythripk@ti.com>
	 <1299753858-12222-4-git-send-email-mythripk@ti.com>
	 <1299753858-12222-5-git-send-email-mythripk@ti.com>
	 <1299753858-12222-6-git-send-email-mythripk@ti.com>
	 <1299753858-12222-7-git-send-email-mythripk@ti.com>
	 <1299753858-12222-8-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53473 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751847Ab1CJN75 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Mar 2011 08:59:57 -0500
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p2ADxvHc007690
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 10 Mar 2011 07:59:57 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep35.itg.ti.com (8.13.7/8.13.7) with ESMTP id p2ADxv2n002113
	for <linux-omap@vger.kernel.org>; Thu, 10 Mar 2011 07:59:57 -0600 (CST)
In-Reply-To: <1299753858-12222-8-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "K, Mythri P" <mythripk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, 2011-03-10 at 04:44 -0600, K, Mythri P wrote:
> Signed-off-by: Mythri P K <mythripk@ti.com>
> ---
>  drivers/video/omap2/dss/Kconfig  |    8 ++++++++
>  drivers/video/omap2/dss/Makefile |    2 ++
>  2 files changed, 10 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/video/omap2/dss/Kconfig b/drivers/video/omap2/dss/Kconfig
> index db01473..bfc5da0 100644
> --- a/drivers/video/omap2/dss/Kconfig
> +++ b/drivers/video/omap2/dss/Kconfig
> @@ -60,6 +60,14 @@ config OMAP2_DSS_VENC
>  	help
>  	  OMAP Video Encoder support for S-Video and composite TV-out.
>  
> +config OMAP4_DSS_HDMI
> +	bool "HDMI support"
> +	depends on ARCH_OMAP4
> +        default y
> +	help
> +	  HDMI Interface. This adds the High Definition Multimedia Interface.
> +	  See http://www.hdmi.org/ for HDMI specification.
> +

Patch is missing description. The default line also seems to be indented
differently than the others.

  Tomi


