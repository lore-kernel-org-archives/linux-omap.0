From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP3: disable idle early in the suspend sequence
Date: Tue, 07 Dec 2010 17:11:51 -0800
Message-ID: <87ipz5hxuw.fsf@deeprootsystems.com>
References: <1290422697-2300-1-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:51371 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755595Ab0LHBL5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Dec 2010 20:11:57 -0500
Received: by pwj3 with SMTP id 3so159139pwj.19
        for <linux-omap@vger.kernel.org>; Tue, 07 Dec 2010 17:11:57 -0800 (PST)
In-Reply-To: <1290422697-2300-1-git-send-email-j-pihet@ti.com> (Jean Pihet's
	message of "Mon, 22 Nov 2010 11:44:57 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Jean Pihet <j-pihet@ti.com>

Hi Jean,

Jean Pihet <jean.pihet@newoldbits.com> writes:

> Some bad interaction between the idle and the suspend paths has been
> noticed: the idle code is called during the suspend enter and exit
> sequences. This could cause corruption or lock-up of resources.
>
> The solution is to move the call to disable_hlt at the very beginning
> of the suspend sequence (in omap3_pm_begin instead of omap3_pm_prepare),
> and the call to enable_hlt at the very end of the suspend sequence
> (in omap3_pm_end instead of omap3_pm_finish).
>
> Tested with RET and OFF on Beagle and OMAP3EVM.
>
> Signed-off-by: Jean Pihet <j-pihet@ti.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> ---
>  arch/arm/mach-omap2/pm34xx.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)

Can you update this to do similar for OMAP2 and OMAP4?

Thanks,

Kevin
