From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH v2 2/2] OMAP: DSS2: Use dss_features framework on DSS2
 code
Date: Thu, 09 Sep 2010 13:29:09 +0300
Message-ID: <1284028149.13006.58.camel@tubuntu.research.nokia.com>
References: <1283944659-3824-1-git-send-email-archit@ti.com>
	 <1283944659-3824-3-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:34883 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754486Ab0IIKaD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Sep 2010 06:30:03 -0400
In-Reply-To: <1283944659-3824-3-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Archit Taneja <archit@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, 2010-09-08 at 13:17 +0200, ext Archit Taneja wrote:
> calls init functions of dss_features during dss_probe, and the following
> features are made omapxxxx independent:
>   - number of managers, overlays
>   - supported color modes for each overlay
>   - supported displays for each manager
>   - global aplha, and restriction of global alpha for video1 pipeline
>   - The register field ranges : FIRHINC, FIRVINC, FIFOHIGHTHRESHOLD
>     FIFOLOWTHRESHOLD and FIFOSIZE
> 
> Signed-off-by: Archit Taneja <archit@ti.com>


> diff --git a/drivers/video/omap2/dss/Makefile b/drivers/video/omap2/dss/Makefile
> index d71b5d9..7db17b5
> --- a/drivers/video/omap2/dss/Makefile
> +++ b/drivers/video/omap2/dss/Makefile
> @@ -1,5 +1,5 @@
>  obj-$(CONFIG_OMAP2_DSS) += omapdss.o
> -omapdss-y := core.o dss.o dispc.o display.o manager.o overlay.o
> +omapdss-y := core.o dss.o dss_features.o dispc.o display.o manager.o overlay.o

I think this change should be in the previous patch.

 Tomi


