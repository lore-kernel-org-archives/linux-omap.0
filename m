From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP4: hwmod data: Remove irq entries from mcspi,
 mmc hwmods
Date: Wed, 12 Jun 2013 10:31:20 -0700
Message-ID: <20130612173120.GO8164@atomide.com>
References: <1370846720-6709-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:31585 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754290Ab3FLRbX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Jun 2013 13:31:23 -0400
Content-Disposition: inline
In-Reply-To: <1370846720-6709-1-git-send-email-r.sricharan@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sricharan R <r.sricharan@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com, rnayak@ti.com, b-cousson@ti.com, paul@pwsan.com, t-kristo@ti.com, ambresh@ti.com

* Sricharan R <r.sricharan@ti.com> [130609 23:51]:
> Commit '3b9b10151c6838af52244cec4af41a938bb5b7ec' cleaned up the
> data file to remove all irq and dma entries for all hwmods, which
> are now populated by DT. But mcspi and mmc irq, dma entries were
> retained since MMC, NFS boot was not working. Since it is root caused
> to be an issue with only DMA entries [1], irq can be safely removed.
> 
> [1] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg90115.html

Thanks applying into omap-for-v3.11/cleanup.

Regards,

Tony
