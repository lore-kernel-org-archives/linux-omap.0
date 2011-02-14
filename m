From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 5/5] omap4: Remove 'FIXME: omap44xx_sram_init not
 implemented'
Date: Mon, 14 Feb 2011 13:09:33 -0800
Message-ID: <20110214210933.GK20795@atomide.com>
References: <1297510187-31547-1-git-send-email-santosh.shilimkar@ti.com>
 <1297510187-31547-6-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:56761 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752333Ab1BNVJh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Feb 2011 16:09:37 -0500
Content-Disposition: inline
In-Reply-To: <1297510187-31547-6-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org

* Santosh Shilimkar <santosh.shilimkar@ti.com> [110212 03:28]:
> The omap44xx_sram_init() implements functionality to push some
> code on SRAM whenever the code can't be executed from external
> memory. The low power and DVFS code can be executed from
> external DDR itself thanks to OMAP4  memory controller hardware
> support. So on OMAP4, sram_push kind of functionality isn't needed.
> 
> Hence remove the FIXME warning added for implementing sram push
> feature on OMAP4.

Will take this one too.

Tony
