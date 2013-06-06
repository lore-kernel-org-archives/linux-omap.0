From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 13/14] ARM: AM33XX: hwmod data: irq, dma and addr info
 clean up
Date: Thu, 6 Jun 2013 04:00:39 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1306060355320.15042@utopia.booyaka.com>
References: <1369845494-30231-1-git-send-email-santosh.shilimkar@ti.com> <1369845494-30231-14-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:37883 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750698Ab3FFEAk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Jun 2013 00:00:40 -0400
In-Reply-To: <1369845494-30231-14-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: tony@atomide.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Vaibhav Hiremath <hvaibhav@ti.com>, Sricharan R <r.sricharan@ti.com>

On Wed, 29 May 2013, Santosh Shilimkar wrote:

> From: Vaibhav Hiremath <hvaibhav@ti.com>
> 
> AM33XX only supports DT boot mode and with addition of
> extracting module resources like, irq, dma and address space
> from DT block, so now we can remove duplicate information from
> hwmod data file.

OK, guess I'll take your word for it that it all works.  The
BeagleBone-white with appended DTB hasn't booted here since v3.7.
And the BeagleBone-black with discrete DTB doesn't boot at all with
current mainline, only with the TI vendor kernel & DTB...

Acked-by: Paul Walmsley <paul@pwsan.com>

- Paul
