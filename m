From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] fixes for tidspbridge 2.6.37-rc1
Date: Tue, 9 Nov 2010 17:29:17 +0100
Message-ID: <201011091729.17679.arnd@arndb.de>
References: <AANLkTinZF-47WQyF5k1Nv64NjfMNSQ-+oE0eGycR24NM@mail.gmail.com> <AANLkTikB0zhN13u5OtRwviOv-rFDW-vFTmq0t7ALuO7N@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:57336 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752104Ab0KIQ32 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Nov 2010 11:29:28 -0500
In-Reply-To: <AANLkTikB0zhN13u5OtRwviOv-rFDW-vFTmq0t7ALuO7N@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: Greg KH <greg@kroah.com>, linux-omap@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Omar Ramirez Luna <omar.ramirez@ti.com>, Fernando Guzman Lugo <fernando.lugo@ti.com>, Tony Lindgren <tony@atomide.com>

On Tuesday 09 November 2010, Felipe Contreras wrote:
> Felipe Contreras (14):
>       Revert "staging: tidspbridge - update Kconfig to select IOMMU module"
>       Revert "staging: tidspbridge - remove dmm custom module"
>       Revert "staging: tidspbridge - deprecate reserve/unreserve_memory funtions"
>       Revert "staging: tidspbridge - remove reserved memory clean up"
>       Revert "staging: tidspbridge: remove dw_dmmu_base from cfg_hostres struct"
>       Revert "staging: tidspbridge - move all iommu related code to a new file"
>       Revert "staging: tidspbridge - remove hw directory"
>       Revert "staging: tidspbridge - fix mmufault support"
>       Revert "staging: tidspbridge - remove custom mmu code from tiomap3430.c"
>       Revert "staging: tidspbridge - rename bridge_brd_mem_map/unmap to a proper name"
>       Revert "staging: tidspbridge - move shared memory iommu maps to tiomap3430.c"
>       Revert "staging: tidspbridge: replace iommu custom for opensource implementation"

That adds quite a lot of crap back in that was removed by Fernando earlier:

 44 files changed, 3733 insertions(+), 847 deletions(-)

It may have been premature to merge the patches as you say, but now that
they are in, I'd vote for giving Fernando a chance to fix up any damage
that was done in the process rather than just reverting all the useful
changes.

	Arnd
