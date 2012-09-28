From: Archit Taneja <a0393947@ti.com>
Subject: Re: [PATCH 1/6] OMAPDSS: add omapdss_version
Date: Fri, 28 Sep 2012 16:30:21 +0530
Message-ID: <50658345.5050403@ti.com>
References: <1348828527-13309-1-git-send-email-tomi.valkeinen@ti.com> <1348828527-13309-2-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33206 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752908Ab2I1LAo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Sep 2012 07:00:44 -0400
In-Reply-To: <1348828527-13309-2-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Chandrabhanu Mahapatra <cmahapatra@ti.com>, =?ISO-8859-1?Q?Rapha=EBl_Ass=E9nat?= <raph@8d.com>, Tony Lindgren <tony@atomide.com>

On Friday 28 September 2012 04:05 PM, Tomi Valkeinen wrote:
> Add new enum, omapdss_version, that is used to tell which DSS hardware
> version the SoC has. This enum is initialized during platform init, and
> passed in the platform data to omapdss driver.
>
> Note that the versions are not "continuous", that is, you cannot check
> if the version is less or greater than something, but you need to check
> for exact version match. In other words, this is invalid:
>
> /* test if DSS is 3630 or earlier */
> if (ver <= OMAPDSS_VER_OMAP3630)
> 	...
>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>   arch/arm/mach-omap2/display.c |   38 ++++++++++++++++++++++++++++++++++++++
>   include/video/omapdss.h       |   14 ++++++++++++++
>   2 files changed, 52 insertions(+)
>
> diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
> index ee40739..33555da 100644
> --- a/arch/arm/mach-omap2/display.c
> +++ b/arch/arm/mach-omap2/display.c
> @@ -284,6 +284,35 @@ err:
>   	return ERR_PTR(r);
>   }
>
> +static enum omapdss_version omap_display_get_version(void)

We could add a __init for this function?

Archit

