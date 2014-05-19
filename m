From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v4 1/4] mtd: nand: omap: add support for BCH16_ECC - GPMC
 driver updates
Date: Mon, 19 May 2014 15:35:23 -0700
Message-ID: <20140519223523.GK11945@atomide.com>
References: <1400486082-4345-1-git-send-email-pekon@ti.com>
 <1400486082-4345-2-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:28919 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751259AbaESWfb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 May 2014 18:35:31 -0400
Content-Disposition: inline
In-Reply-To: <1400486082-4345-2-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pekon Gupta <pekon@ti.com>
Cc: Brian Norris <computersforpeace@gmail.com>, linux-mtd <linux-mtd@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Stefan Roese <sr@denx.de>, Felipe Balbi <balbi@ti.com>

* Pekon Gupta <pekon@ti.com> [140519 00:55]:
> This patch add support for BCH16_ECC in GPMC (controller) driver:
> - extends configuration space to include BCH16 registers
> - extends parsing of DT binding for selecting BCH16 ecc-scheme
> 
> Signed-off-by: Pekon Gupta <pekon@ti.com>

This patch seems OK to merge via the MTD tree, so for the
arch/arm/*omap* changes:

Acked-by: Tony Lindgren <tony@atomide.com>
