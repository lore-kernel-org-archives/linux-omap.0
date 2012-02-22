From: Matt Porter <mporter@ti.com>
Subject: Re: [PATCH 0/2] omap: fix omap2plus defaults for am35xx parts
Date: Wed, 22 Feb 2012 12:15:11 -0500
Message-ID: <20120222171511.GC20411@beef>
References: <1328818586-7104-1-git-send-email-mporter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:52006 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753762Ab2BVRPI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Feb 2012 12:15:08 -0500
Received: by ggnh1 with SMTP id h1so174316ggn.19
        for <linux-omap@vger.kernel.org>; Wed, 22 Feb 2012 09:15:07 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1328818586-7104-1-git-send-email-mporter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>

On Thu, Feb 09, 2012 at 03:16:24PM -0500, Matt Porter wrote:
> This series enables all current am35xx boards and the on-chip Ethernet
> driver in omap2plus_defconfig. It will help users of these boards to
> have a working defconfig out of the box.
> 
> Matt Porter (2):
>   omap: enable davinci_emac in omap2plus_defconfig for am35xx
>   omap: build am3517crane board support by default
> 
>  arch/arm/configs/omap2plus_defconfig |    1 +
>  arch/arm/mach-omap2/Kconfig          |    1 +
>  2 files changed, 2 insertions(+), 0 deletions(-)

Can these be queued for 3.4? It would be great to have
omap2plus_defconfig build craneboard support by default to help catch
any future regressions.

-Matt
