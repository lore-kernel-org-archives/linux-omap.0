From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 0/3] Add support for OMAP35x processors (v3)
Date: Tue, 13 Jan 2009 11:41:12 -0800
Message-ID: <87hc43j8o7.fsf@deeprootsystems.com>
References: <1231617620-18667-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:46453 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751785AbZAMTlY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Jan 2009 14:41:24 -0500
Received: by ug-out-1314.google.com with SMTP id 39so307356ugf.37
        for <linux-omap@vger.kernel.org>; Tue, 13 Jan 2009 11:41:21 -0800 (PST)
In-Reply-To: <1231617620-18667-1-git-send-email-premi@ti.com> (Sanjeev Premi's message of "Sun\, 11 Jan 2009 01\:30\:20 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sanjeev Premi <premi@ti.com>
Cc: linux-omap@vger.kernel.org

Sanjeev Premi <premi@ti.com> writes:

> These patches provide support for the OMAP35x processors.
>
> This is essentially a re-submit after series of discusions
> earlier in the list. It had always been getting pushed in
> my to-do list :(
> See: http://marc.info/?l=linux-omap&m=122029900603111&w=2
>
> Based on the comments received, this patch includes following:
>   1) Updates to Kconfig
>      (Includes the changes suggested by Aguirre Rodriguez)
>   2) Runtime check for OMAP35x
>   3) Updates to omap3_evm_defconfig
>
> If the changes look good, I can make updates to Beagle,
> Overo and Pandora boards as well.
>
> Best regards,
> Sanjeev

Sanjeev,

Is the HEAD of linux-omap working for you on omap3evm?  I just got my
EVM and am getting it going but it doesn't boot without
CONFIG_DEBUG_LL, and with that enabled, as soon as the normal serial
driver is enabled, the serial console goes crazy with garbage output.

I'm about to push a new PM branch and wanted to do some testing on the
EVM.

Kevin

> Sanjeev Premi (3):
>   Add support for OMAP35x processors
>   Runitme check for OMAP35x
>   Updates for OMAP3EVM
>
>  arch/arm/configs/omap3_evm_defconfig     |    5 ++
>  arch/arm/mach-omap2/Kconfig              |   65 ++++++++++++++++++++--
>  arch/arm/mach-omap2/board-omap3evm.c     |    2 +-
>  arch/arm/plat-omap/common.c              |   68 +++++++++++++++++++++++
>  arch/arm/plat-omap/include/mach/common.h |    1 +
>  arch/arm/plat-omap/include/mach/cpu.h    |   88 +++++++++++++++++++++++++++++-
>  6 files changed, 220 insertions(+), 9 deletions(-)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
