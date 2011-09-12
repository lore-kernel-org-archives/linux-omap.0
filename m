From: Per Forlin <per.forlin@linaro.org>
Subject: Re: [PATCH 1/2] omap: hsmmc: Normalize dma cleanup operations
Date: Mon, 12 Sep 2011 21:56:52 +0200
Message-ID: <CAJ0pr18PtGWga7n8nm1xs-=wtRjMu=X_wZONAOAgeaLamtEJjg@mail.gmail.com>
References: <y>
	<1314903957-24408-2-git-send-email-svenkatr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:65452 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753792Ab1ILT4x (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Sep 2011 15:56:53 -0400
In-Reply-To: <1314903957-24408-2-git-send-email-svenkatr@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Venkatraman S <svenkatr@ti.com>, Kishore Kadiyala <kishorek.kadiyala@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, cjb@laptop.org

On 1 September 2011 21:05, Venkatraman S <svenkatr@ti.com> wrote:
> Reuse omap_hsmmc_dma_cleanup even for normal dma teardown in
> omap_hsmmc_dma_cb. Consolidate multiple points of dma unmap into a
> single location in post_req function, to prevent double unmapping.
It's optional to use pre_req() and post_req(). The SDIO framework
doesn't utilise these hooks. For instance this wont work together with
SDIO-wlan on the pandaboard.
If pre_req() has been issued it's fine to defer dma_unmap() until
post_req(). If pre_req() is not called the driver should call
dma_unmap() directly.

Regards,
Per
