From: Jingoo Han <jg1.han@samsung.com>
Subject: Re: [PATCH 0/6] OMAPDSS: remove cpu_is_* calls
Date: Thu, 04 Oct 2012 10:33:38 +0900
Message-ID: <005d01cda1d0$47a249e0$d6e6dda0$%han@samsung.com>
References: <1348828527-13309-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:35719 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755194Ab2JDBeH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Oct 2012 21:34:07 -0400
In-reply-to: <1348828527-13309-1-git-send-email-tomi.valkeinen@ti.com>
Content-language: ko
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: 'Tomi Valkeinen' <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, 'Archit Taneja' <a0393947@ti.com>, 'Chandrabhanu Mahapatra' <cmahapatra@ti.com>, =?UTF-8?Q?'Rapha=C3=ABl_Ass=C3=A9nat'?= <raph@8d.com>, 'Tony Lindgren' <tony@atomide.com>, 'Jingoo Han' <jg1.han@samsung.com>

On Friday, September 28, 2012 7:35 PM Tomi Valkeinen wrote
> 
> Hi,
> 
> This series adds an omapdss_version enum that is passed via platform data to
> omapdss driver. This version identifier is then used instead of cpu_is_*()
> calls.

Hi Tomi,

As you mentioned, cpu_is_*() is not preferable in driver.
Actually, I thought so, when I saw the OMAPDSS driver a few months ago.
Anyway, it looks good. :)

Best regards,
Jingoo Han

> 
> After these, omapdss no longer contains any plat/ or mach/ includes. omapfb,
> vrfb and vram still do, though.
> 
>  Tomi
> 
> Tomi Valkeinen (6):
>   OMAPDSS: add omapdss_version
>   OMAPDSS: use omapdss_version in dss_features.c
>   OMAPDSS: DISPC: use omapdss_version
>   OMAPDSS: DSS: use omapdss_version
>   OMAPDSS: HDMI: use omapdss_version
>   OMAPDSS: remove <plat/cpu.h> includes
> 
>  arch/arm/mach-omap2/display.c          |   38 +++++++++++++++++++
>  drivers/video/omap2/dss/core.c         |    2 +-
>  drivers/video/omap2/dss/dispc.c        |   41 +++++++++++++-------
>  drivers/video/omap2/dss/dss.c          |   39 +++++++++++++------
>  drivers/video/omap2/dss/dss_features.c |   64 ++++++++++++++++++++++----------
>  drivers/video/omap2/dss/dss_features.h |    5 ++-
>  drivers/video/omap2/dss/hdmi.c         |    3 +-
>  include/video/omapdss.h                |   14 +++++++
>  8 files changed, 157 insertions(+), 49 deletions(-)
> 
> --
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

