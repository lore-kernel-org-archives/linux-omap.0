From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] ARM: OMAP2+: fix naming collision of variable
 nr_irqs
Date: Tue, 26 Jun 2012 03:50:36 -0700
Message-ID: <20120626105035.GC31393@atomide.com>
References: <1340620000-27074-1-git-send-email-svenkatr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:54795 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751457Ab2FZKui (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Jun 2012 06:50:38 -0400
Content-Disposition: inline
In-Reply-To: <1340620000-27074-1-git-send-email-svenkatr@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Venkatraman S <svenkatr@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Venkatraman S <svenkatr@ti.com> [120625 03:31]:
> Using nr_irqs as local variable name triggers the sparse warning..
> ./arch/arm/mach-omap2/irq.c:265:6: warning: symbol 'nr_irqs' shadows an earlier one
> ./linux/include/linux/irqnr.h:26:12: originally declared here

Thanks applying both into fixes-non-critical.

Tony
