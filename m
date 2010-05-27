From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH pm-wip/uart 0/4] misc. fixes for IDLEST and OMAP24xx support
Date: Thu, 27 May 2010 14:06:36 -0700
Message-ID: <87ocg1gilf.fsf@deeprootsystems.com>
References: <1274915115-28355-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f176.google.com ([209.85.222.176]:53489 "EHLO
	mail-pz0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932175Ab0E0VGj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 May 2010 17:06:39 -0400
Received: by pzk6 with SMTP id 6so311528pzk.1
        for <linux-omap@vger.kernel.org>; Thu, 27 May 2010 14:06:39 -0700 (PDT)
In-Reply-To: <1274915115-28355-1-git-send-email-khilman@deeprootsystems.com> (Kevin Hilman's message of "Wed\, 26 May 2010 16\:05\:11 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Kevin Hilman <khilman@deeprootsystems.com> writes:

> This series on top of my pm-wip/uart branch fixes up various issues
> with UART hwmods for 24xx as well as IDLEST issues after Benoit's
> fixes/cleanup series.
>
> Tested on OMAP3 (omap3evm) and OMAP2 (n810/2420).
>
> Note that for OMAP2, this recently posted patch is required as well:
>
>   [PATCH] OMAP24xx: CM: fix mask used for checking IDLEST status
>
> These ares posted as FYI, and will be folded into the original hwmod
> data for OMAP2+ UARTs.
>
> Kevin
>
>
> Kevin Hilman (4):
>   OMAP3: hwmod: UART: add module offs
>   OMAP2/3: hwmod: L3 and L4 CORE/PER/WKUP hwmods don't have IDLEST
>   OMAP2420: hwmod: UART3 needs prcm_reg_id = 2
>   24xx: need .module_offs = CORE_MOD

FYI.

This series has been folded into the original UART hwmod conversion
patch in an updated pm-wip/uart branch.

Kevin
