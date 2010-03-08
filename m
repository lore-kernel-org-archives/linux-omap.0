From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 0/3] OMAP3: PM: OMAP3630 support for smartreflex driver
Date: Mon, 08 Mar 2010 09:36:26 -0800
Message-ID: <87eijuvhph.fsf@deeprootsystems.com>
References: <1268068851-30022-1-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f198.google.com ([209.85.221.198]:45622 "EHLO
	mail-qy0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753194Ab0CHRgb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Mar 2010 12:36:31 -0500
Received: by qyk36 with SMTP id 36so4454443qyk.19
        for <linux-omap@vger.kernel.org>; Mon, 08 Mar 2010 09:36:30 -0800 (PST)
In-Reply-To: <1268068851-30022-1-git-send-email-thara@ti.com> (Thara Gopinath's message of "Mon\,  8 Mar 2010 22\:50\:48 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, nm@ti.com, vishwanath.bs@ti.com, sawant@ti.com, b-cousson@ti.com

Thara Gopinath <thara@ti.com> writes:

> This patch series adds support for the updated 45nm smrtrelfex IP
> supported in OMAP3630 and OMAP4 in the smartreflex driver and
> adds support to enable smartreflex autocompensation for OMAP3630
> using test nvalues.
>
> This patch series is based on the following patch series/patches
> for proper functionality.
> 	http://marc.info/?l=linux-omap&m=126700378625593&w=2
> 	http://patchwork.kernel.org/patch/77739/
>
> This patch series has been tested on OMAP3630 SDP board with
> CONFIG_OMAP_SMARTREFLEX_TESTING option enabled in the menuconfig.
>
> This patch series has been based on Kevin's PM tree
> origin/pm-wip-opp branch 

It appears to also depend on the previous SR rework series.  It
doesn't apply directly to pm-wip-opp.

> and on adea81232e8fc82334bca3707efa23dc854f29fc commit id.

This commit is a rather old version of pm-wip-opp, please refresh
against current.

Kevin




> Thara Gopinath (3):
>   OMAP3: PM: Bug fix in Smartreflex driver.
>   OMAP3: PM: Smartreflex IP update changes for OMAP3630
>   OMAP3: PM: Adding OMAP3630 support in smartreflex driver
>
>  arch/arm/mach-omap2/omap_hwmod_34xx.h     |   49 ++++-
>  arch/arm/mach-omap2/smartreflex.c         |  354 +++++++++++++++++++++++-----
>  arch/arm/mach-omap2/smartreflex.h         |   51 ++++-
>  arch/arm/mach-omap2/voltage.c             |  167 +++++++++++---
>  arch/arm/mach-omap2/voltage.h             |   32 ++-
>  arch/arm/plat-omap/include/plat/control.h |    8 +
>  6 files changed, 542 insertions(+), 119 deletions(-)
