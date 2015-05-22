From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL 2.1/2] fixed up omap1 sparse irq support for v4.2
Date: Fri, 22 May 2015 16:36:24 +0200
Message-ID: <39338069.RMptS8vVnc@wuerfel>
References: <20150521225938.GY10274@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:60100 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756709AbbEVOgz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 May 2015 10:36:55 -0400
In-Reply-To: <20150521225938.GY10274@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, arm@kernel.org, linux-omap@vger.kernel.org

On Thursday 21 May 2015 15:59:38 Tony Lindgren wrote:
> Here's this pull request updated for the randconfig errors found
> by Arnd.
> 
> The following changes since commit 030bbdbf4c833bc69f502eae58498bc5572db736:
> 
>   Linux 4.1-rc3 (2015-05-10 15:12:29 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.2/omap1-v2
> 
> for you to fetch changes up to 7bf15c4360b384e34d685616a77a8abf7dd8aea5:
> 
>   ARM: OMAP1: Fix section mismatch warnings for omap_cfg_reg (2015-05-21 14:50:23 -0700)
> 
> ----------------------------------------------------------------
> Add support for CONFIG_SPARSE_IRQ for omap1. This takes us a bit closer
> to making omap1 support multiarch. After this series we still need to
> make omap1 use the common clock framework and fix up the drivers to not
> rely on includes from mach and plat directories.

Pulled into next/soc
 
> Note that this branch depends on a GPIO driver fix in v4.1-rc3
> d2d05c65c40e ("gpio: omap: Fix regression for MPUIO interrupts").

The branch is already based on 4.1-rc3, so we should be fine.

Thanks,

	Arnd
