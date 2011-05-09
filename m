From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAP2: avoid descending into disabled framebuffer dirs
Date: Mon, 09 May 2011 16:06:13 +0000
Message-ID: <1304957173.2215.27.camel@deskari>
References: <1304952024-28296-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:33434 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752602Ab1EIQGS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 May 2011 12:06:18 -0400
In-Reply-To: <1304952024-28296-1-git-send-email-vapier@gentoo.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Frysinger <vapier@gentoo.org>
Cc: linux-fbdev@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, linux-omap@vger.kernel.org

On Mon, 2011-05-09 at 10:40 -0400, Mike Frysinger wrote:
> Rather than always add the omap2 dirs to the build list (and thus
> force everyone to generate a useless built-in.o), bind the dirs to
> their relevant kconfig symbol.
> 
> Signed-off-by: Mike Frysinger <vapier@gentoo.org>
> ---
>  drivers/video/omap2/Makefile |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/omap2/Makefile b/drivers/video/omap2/Makefile
> index d853d05..5ddef12 100644
> --- a/drivers/video/omap2/Makefile
> +++ b/drivers/video/omap2/Makefile
> @@ -1,6 +1,6 @@
>  obj-$(CONFIG_OMAP2_VRAM) += vram.o
>  obj-$(CONFIG_OMAP2_VRFB) += vrfb.o
>  
> -obj-y += dss/
> -obj-y += omapfb/
> +obj-$(CONFIG_OMAP2_DSS) += dss/
> +obj-$(CONFIG_FB_OMAP2) += omapfb/
>  obj-y += displays/

Looks fine to me, applying to DSS tree. Thanks!

 Tomi


