From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH] OMAP4: McBSP: Clear rx_irq at probe time
Date: Tue, 17 May 2011 15:29:54 +0300
Message-ID: <20110517152954.477365e6.jhnikula@gmail.com>
References: <1305628420-10592-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:49656 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754135Ab1EQM2m (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 May 2011 08:28:42 -0400
Received: by eyx24 with SMTP id 24so118677eyx.19
        for <linux-omap@vger.kernel.org>; Tue, 17 May 2011 05:28:41 -0700 (PDT)
In-Reply-To: <1305628420-10592-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>

On Tue, 17 May 2011 13:33:40 +0300
Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:

> On OMAP4 we have one interrupt line per McBSP port.
> At proble time tx, and rx irq value will be -ENXIO,
> and only the tx irq will get corrected.
> In omap_mcbsp_request if the rx_irq is not 0 we proceed,
> and try to request the interrupt, which will fail on
> OMAP4 (rx_irq == -6).
> To avoid this error, clear the rx_irq at probe time
> on OMAP4.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  arch/arm/plat-omap/mcbsp.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
Acked-by: Jarkko Nikula <jhnikula@gmail.com>
