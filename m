From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 0/2] hwmod fixes for MMC module reset on init
Date: Thu, 16 Jul 2009 10:08:00 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0907161007170.23461@utopia.booyaka.com>
References: <1247012257-19407-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:51538 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932526AbZGPQIB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Jul 2009 12:08:01 -0400
In-Reply-To: <1247012257-19407-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

Hi Kevin,

On Tue, 7 Jul 2009, Kevin Hilman wrote:

> I've started to integrate the new hwmod/omapdev into the PM branch for
> the next release.
> 
> With the new MMC hwmod added, hwmod should do a full reset and idle of
> the MMC modules on init, so I decided to remove the patch from the PM
> branch which does the same.
> 
> To my surprise, the MMC blocks were preventing retention without the
> original patch.  In debugging hwmod, I found a couple problems.   One
> with the MMC sys[cs]_off values themselves, and another in that
> the reset code was not waiting for RESETDONE.
> 
> Kevin Hilman (2):
>   OMAP2/3: HS-MMC: correct hwmod offsets for SYSCONFIG/SYSSTATUS
>   OMAP2/3/4: omap_hwmod: fix reset bug
> 
>  arch/arm/mach-omap2/omap_hwmod.c      |    2 +-
>  arch/arm/mach-omap2/omap_hwmod_2430.h |    4 ++--
>  arch/arm/mach-omap2/omap_hwmod_34xx.h |    4 ++--
>  3 files changed, 5 insertions(+), 5 deletions(-)

thanks very much for these patches; they've both been incorporated.

- Paul
