From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 0/7 v4] OMAP3: clean up ASM sleep code
Date: Fri, 17 Dec 2010 10:35:47 +0530
Message-ID: <f3afb9340d4f1d0c8d2936d9faea79c8@mail.gmail.com>
References: <1292521858-3810-1-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:56417 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1749667Ab0LQFFt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 17 Dec 2010 00:05:49 -0500
Received: by mail-gw0-f42.google.com with SMTP id 20so235609gwb.15
        for <linux-omap@vger.kernel.org>; Thu, 16 Dec 2010 21:05:48 -0800 (PST)
In-Reply-To: <1292521858-3810-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jean.pihet@newoldbits.com, linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, linux-arm-kernel@lists.infradead.org, Jean Pihet-XID <j-pihet@ti.com>

Jean,

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of jean.pihet@newoldbits.com
> Sent: Thursday, December 16, 2010 11:21 PM
> To: linux-omap@vger.kernel.org
> Cc: khilman@deeprootsystems.com; linux-arm-kernel@lists.infradead.org;
> Jean Pihet
> Subject: [PATCH 0/7 v4] OMAP3: clean up ASM sleep code
>
> From: Jean Pihet <j-pihet@ti.com>
>
> This patch only contains clean-ups and cosmetic changes,
> no functional change.
>
> Clean-up of the ASM sleep code, for better readability and
> easier maintenance.
>
> Applies on top of Nishant's latest idle path errata fixes step 2,
> cf. http://marc.info/?l=linux-omap&m=129139584919242&w=2
>
Thanks for cleanup. Have few minor comments on these patches.

> Jean Pihet (7):
>   OMAP2+: use global values for the SRAM PA addresses
>   OMAP3: remove hardcoded values from the ASM sleep code
>   OMAP3: re-organize the ASM sleep code
>   OMAP3: rework of the ASM sleep code execution paths
>   OMAP3: add comments for low power code errata
>   OMAP3: ASM sleep code format rework
>   OMAP3: remove unused code from the ASM sleep code
>
>  arch/arm/mach-omap2/control.c   |   10 +-
>  arch/arm/mach-omap2/control.h   |    2 +
>  arch/arm/mach-omap2/pm.h        |    1 -
>  arch/arm/mach-omap2/pm34xx.c    |    4 +-
>  arch/arm/mach-omap2/sdrc.h      |    7 +
>  arch/arm/mach-omap2/sleep34xx.S |  714
+++++++++++++++++++++-------------
> -----
>  arch/arm/plat-omap/sram.c       |    7 +-
>  7 files changed, 401 insertions(+), 344 deletions(-)
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
