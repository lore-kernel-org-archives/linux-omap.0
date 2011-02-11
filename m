From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v3 0/3] OMAP4: hwmod DSS support
Date: Fri, 11 Feb 2011 14:23:34 +0200
Message-ID: <1297427014.9552.312.camel@deskari>
References: <1296127024-17507-1-git-send-email-sumit.semwal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36056 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753618Ab1BKMXl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Feb 2011 07:23:41 -0500
In-Reply-To: <1296127024-17507-1-git-send-email-sumit.semwal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Sumit Semwal <sumit.semwal@ti.com>
Cc: tomi.valkeinen@nokia.com, paul@pwsan.com, khilman@ti.com, hvaibhav@ti.com, linux-omap@vger.kernel.org, b-cousson@ti.com

Hi,

I can't really comment on the HWMOD parts, but beside the Kconfig
indentation comments this patch set looks good to me.

 Tomi

On Thu, 2011-01-27 at 16:47 +0530, ext Sumit Semwal wrote:
> This patch series enables support for OMAP4 DSS, and adds hwmod support
> for dss, dispc, dsi1, dsi2, hdmi, rfbi and venc hwmods.
> 
> In OMAP4 there are severals IPs that can be reached by differents
> interconnect paths depending of the access initiator (MPU vs. SDMA).
> 
> In the case of the DSS, both L3 direct path and L4 CFG path can be
> used to access all the DSS IPs.
> dss is also considered as an IP as dispc, rfbi, and named as dss_core.
> 
> TODO:
> This patch doesn't handle the opt clocks via hwmod - there will be a separate
> patch series which will take opt clock roles from hwmod, populate them in
> the device structure, so that the driver can ask for relevant opt-clocks.
> 
> Also TBD is the migration to pm_runtime APIs, which need to be adapted a little
> for handling DSS-family of clocks completely.
> 
> Changes from v2:
> ----------------
> 1. Corrected author name in patch 3/3.
> 2. Added some hwmod data in the database, missed during merge of a couple of patches.
> 
> Changes from v1:
> ----------------
> - dss_dss device is renamed as dss_core as per suggestion from Benoit Cousson.
> 
> Patch Base:
> ===========
> Patch-set rebased and tested w/ Zoom3 (OMAP3630) on top of:
> url = git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> branch "master"
> commit	e8883f8057c0f7c9950fa9f20568f37bfa62f34a
> Description: Add linux-next specific files for 20110115
> +
> Patch mentioned in http://www.mail-archive.com/linux-omap@vger.kernel.org/msg42384.html
> [PATCH] OMAP: counter_32k: init clocksource as part of machine timer init
> (This patch is required for OMAP bootup w/ 20110115 linux-next)
> +
> DSS hwmod patch series: http://www.mail-archive.com/linux-omap@vger.kernel.org/msg42914.html
> +
> patch series: OMAP2PLUS: DSS: Generalize clock names
>  (http://www.mail-archive.com/linux-omap@vger.kernel.org/msg43058.html)
> --------------------------------------------------------
> 
> Benoit Cousson (1):
>   OMAP4: hwmod data: add DSS DISPC DSI1,2 RFBI HDMI VENC
> 
> Mayuresh Janorkar (2):
>   OMAP2PLUS: DSS2: Add OMAP4 Kconfig support
>   OMAP4: DSS2: Add hwmod device names for OMAP4.
> 
>  arch/arm/mach-omap2/display.c              |   21 +-
>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  603 ++++++++++++++++++++++++++++
>  drivers/video/omap2/dss/Kconfig            |    6 +-
>  drivers/video/omap2/omapfb/Kconfig         |    6 +-
>  4 files changed, 623 insertions(+), 13 deletions(-)
> 


