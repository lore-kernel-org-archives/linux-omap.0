From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL 1/1] omap plat header removal for v3.8 merge window, part4
Date: Mon, 12 Nov 2012 21:57:51 +0000
Message-ID: <201211122157.51602.arnd@arndb.de>
References: <pull-1352312855-617904>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:53538 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752632Ab2KLV55 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Nov 2012 16:57:57 -0500
In-Reply-To: <pull-1352312855-617904>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <ton@atomide.com>
Cc: Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Wednesday 07 November 2012, Tony Lindgren wrote:
> The following changes since commit a0212796b58061a9716178d261f318925c246643:
> 
>   Merge tag 'omap-cleanup-fixes-a-for-3.8' of git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending into omap-for-v3.8/cleanup-headers (2012-10-26 13:18:19 -0700)
> 
> are available in the git repository at:
> 
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.8/cleanup-headers-prepare-multiplatform-v3-signed
> 
> for you to fetch changes up to 6ba54ab4a49bbad736b0254aa6bdf0cb83013815:
> 
>   ARM: OMAP: Remove omap_init_consistent_dma_size() (2012-11-06 16:01:19 -0800)
> 
> ----------------------------------------------------------------
> These changes deal with the issues of relative includes
> introduced by the earlier clean-up and clean up few more
> things for enabling multiplatform support.
> 
> The multiplatform kernel has been booted on omaps on
> top of this branch with the work-in-progress patches
> applied manually.
> 
> We cannot yet enable the multiplatform support though.
> We still need the common clock framework patches, some
> solution for dma-omap.h, and serial-omap.h moved before
> we can enable it.

Pulled into next/headers branch now, sorry for the delay.

	Arnd
