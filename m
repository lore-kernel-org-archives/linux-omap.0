From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH/RFC 0/4] convert HS-MMC driver to hwmod + runtime PM
Date: Thu, 04 Feb 2010 14:51:42 -0800
Message-ID: <87hbpw1uo1.fsf@deeprootsystems.com>
References: <1265244688-4055-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f182.google.com ([209.85.216.182]:40114 "EHLO
	mail-px0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751411Ab0BDWvp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Feb 2010 17:51:45 -0500
Received: by pxi12 with SMTP id 12so3428111pxi.33
        for <linux-omap@vger.kernel.org>; Thu, 04 Feb 2010 14:51:44 -0800 (PST)
In-Reply-To: <1265244688-4055-1-git-send-email-khilman@deeprootsystems.com> (Kevin Hilman's message of "Wed\,  3 Feb 2010 16\:51\:24 -0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Kevin Hilman <khilman@deeprootsystems.com> writes:

> This series converts the OMAP HS-MMC driver to use omap_hwmod +
> runtime PM API.
>
> Depends on MMC hwmods available in 'pm-wip/hwmods' branch of
> my git tree[1] as well as previously posted runtime PM series:
>
>    [PATCH/RFC 0/2] initial runtime PM layer for OMAP
>
> The easies way to experiment/test is to use my 'pm-wip/mmc' branch
> which has all the dependencies, and is based on omap/for-next'.
> It has been tested by merging with current PM branch.

One more thing for those wanting to test this:

You can start from omap3_pm_defconfig and then CONFIG_PM_RUNTIME needs
to be enabled.

Kevin

> [1] http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-pm.git
>
> Kevin Hilman (3):
>   MMC: OMAP HS-MMC: convert to dev_pm_ops
>   OMAP3EVM: MMC: enable power-saving mode
>   OMAP2/3 MMC: initial conversion to runtime PM
>
> Paul Walmsley (1):
>   OMAP: MMC (core): split device registration by OMAP
>
>  arch/arm/mach-omap1/devices.c         |   45 ++++++-
>  arch/arm/mach-omap2/board-omap3evm.c  |    1 +
>  arch/arm/mach-omap2/devices.c         |  111 ++++++++-------
>  arch/arm/mach-omap2/hsmmc.c           |   12 +-
>  arch/arm/plat-omap/devices.c          |   50 -------
>  arch/arm/plat-omap/include/plat/mmc.h |    5 +
>  drivers/mmc/host/omap_hsmmc.c         |  241 ++++++++++++++++-----------------
>  7 files changed, 233 insertions(+), 232 deletions(-)
