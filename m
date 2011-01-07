From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 0/3] OMAP4: DSS OMAP4 hwmod support
Date: Fri, 07 Jan 2011 15:02:21 -0800
Message-ID: <87wrmgjp1e.fsf@ti.com>
References: <1294249444-11951-1-git-send-email-sumit.semwal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:48966 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755338Ab1AGXCZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jan 2011 18:02:25 -0500
Received: by pxi17 with SMTP id 17so2007645pxi.39
        for <linux-omap@vger.kernel.org>; Fri, 07 Jan 2011 15:02:24 -0800 (PST)
In-Reply-To: <1294249444-11951-1-git-send-email-sumit.semwal@ti.com> (Sumit
	Semwal's message of "Wed, 5 Jan 2011 23:14:01 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sumit Semwal <sumit.semwal@ti.com>
Cc: tomi.valkeinen@nokia.com, paul@pwsan.com, hvaibhav@ti.com, linux-omap@vger.kernel.org

Sumit Semwal <sumit.semwal@ti.com> writes:

> This patch series enables support for OMAP4 DSS, and adds hwmod support
> for dss, dispc, dsi1, dsi2, hdmi, rfbi and venc hwmods.

This series is confusing as the 3 patches here do not do all the things
described here.

It also doesn't apply to the master branch (e.g. PATCH 3/3 modifies
display.c, which doesn't exist until your other series.)

Please take care when writing these cover letters to be sure they are
accurate, otherwise reviewers/maintainers can't help but be confused
about what is going on.

Kevin


> In OMAP4 there are severals IPs that can be reached by differents
> interconnect paths depending of the access initiator (MPU vs. SDMA).
>
> In the case of the DSS, both L3 direct path and L4 CFG path can be
> used to access all the DSS IPs.
> dss is also considered as an IP as dispc, rfbi, and named as dss_dss.
>
> TODO:
> This patch doesn't handle the opt clocks via hwmod - there will be a separate
> patch series which will take opt clock roles from hwmod, populate them in
> the device structure, so that the driver can ask for relevant opt-clocks.
>
> Also TBD is the migration to pm_runtime APIs, which need to be adapted a little
> for handling DSS-family of clocks completely.
>
> Patch Base:
> ===========
> url = git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git
> branch "master"
> Commit id: fa3b4e23ec20cfc944db7cc2b30b0d82c20e4472
> Description:  cbus: Fix retu_rtc_do_reset
> +
> hwmod patches under discussion: http://www.mail-archive.com/linux-omap@vger.kernel.org/msg41534.html
> +
> patch series: OMAP2PLUS: DSS: Generalize clock names
> --------------------------------------------------------
>
> Benoit Cousson (1):
>   OMAP4: hwmod data: add DSS DISPC DSI1,2 RFBI HDMI VENC
>
> Mayuresh Janorkar (1):
>   OMAP2PLUS: DSS2: Add OMAP4 support
>
> Sumit Semwal (1):
>   OMAP4: DSS2: Add hwmod device names for OMAP4.
>
>  arch/arm/mach-omap2/display.c              |   23 +-
>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  588 ++++++++++++++++++++++++++++
>  drivers/video/omap2/dss/Kconfig            |    6 +-
>  drivers/video/omap2/omapfb/Kconfig         |    6 +-
>  4 files changed, 609 insertions(+), 14 deletions(-)
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
