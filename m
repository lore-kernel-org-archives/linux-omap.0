From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH v2 1/2] ARM: McBSP: Fix request for irq in OMAP4
Date: Wed, 12 May 2010 11:09:39 +0300
Message-ID: <20100512110939.88693cfc.jhnikula@gmail.com>
References: <1273108546-2507-1-git-send-email-jorge.candelaria@ti.com>
	<1273108546-2507-2-git-send-email-jorge.candelaria@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f216.google.com ([209.85.219.216]:37385 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753596Ab0ELIII (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 May 2010 04:08:08 -0400
Received: by ewy8 with SMTP id 8so1696554ewy.28
        for <linux-omap@vger.kernel.org>; Wed, 12 May 2010 01:08:06 -0700 (PDT)
In-Reply-To: <1273108546-2507-2-git-send-email-jorge.candelaria@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jorge Eduardo Candelaria <jorge.candelaria@ti.com>
Cc: linux-omap@vger.kernel.org

On Wed,  5 May 2010 20:15:45 -0500
Jorge Eduardo Candelaria <jorge.candelaria@ti.com> wrote:

> In OMAP4, there is only one irq line for TX and RX paths. Use
> the correct irq line to avoid errors at runtime.
> 
> Also, request irq line only once (instead of requesting for TX
> and RX).
> 
> Signed-off-by: Jorge Eduardo Candelaria <jorge.candelaria@ti.com>
> ---
>  arch/arm/mach-omap2/mcbsp.c |   12 ++++--------
>  arch/arm/plat-omap/mcbsp.c  |   20 ++++++++++++--------
>  2 files changed, 16 insertions(+), 16 deletions(-)
> 
Acked-by: Jarkko Nikula <jhnikula@gmail.com>
