From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/2] OMAP3 timer: switch Beagle clockevents source to
	GPTIMER12
Date: Wed, 13 Aug 2008 16:36:14 +0300
Message-ID: <20080813133612.GA27446@atomide.com>
References: <20080811233109.3046.54050.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:56070 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750956AbYHMNeP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Aug 2008 09:34:15 -0400
Content-Disposition: inline
In-Reply-To: <20080811233109.3046.54050.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org

* Paul Walmsley <paul@pwsan.com> [080812 02:38]:
> This patch series allows the clockevents source GPTIMER to be selectable via
> Kconfig, and changes the Beagle Kbuild config to use GPTIMER12 instead of
> GPTIMER1.  The theory here is that GPTIMER12 has its own internal 32kHz 
> secure oscillator, and does not depend on the external 32kHz clock source,
> which we suspect may be noisy.

Pushing these today.

Tony

> 
> 
> ---
> 
> size:
>   text    data     bss     dec     hex filename
> 3265520  145472  105480 3516472  35a838 vmlinux.beagle.orig
> 3265568  145472  105480 3516520  35a868 vmlinux.beagle
> 
>  arch/arm/configs/omap3_beagle_defconfig |    5 +++--
>  arch/arm/mach-omap2/Kconfig             |   16 ++++++++++++++++
>  arch/arm/mach-omap2/timer-gp.c          |    5 ++++-
>  3 files changed, 23 insertions(+), 3 deletions(-)
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
