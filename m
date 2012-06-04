From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] omap: dma: Clear status registers on enable/disable
 irq.
Date: Sun, 3 Jun 2012 23:13:57 -0700
Message-ID: <20120604061357.GV12766@atomide.com>
References: <1337117708-27215-1-git-send-email-oleg.matcovschi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:46033 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751219Ab2FDGOB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Jun 2012 02:14:01 -0400
Content-Disposition: inline
In-Reply-To: <1337117708-27215-1-git-send-email-oleg.matcovschi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Oleg Matcovschi <oleg.matcovschi@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk, jarkko.nikula@bitmer.com, jkrzyszt@tis.inet.pl

* Oleg Matcovschi <oleg.matcovschi@ti.com> [120515 14:40]:
> Use omap_disable_channel_irq() function instead of directly accessing CICR.
> The omap_disable_chanel_irq() function clears pending interrupts
> and disables interrupt on channel.
> Functions omap2_enable_irq_lch()/omap2_disable_irq_lch() clear interrupt
> status register.

Looking at this again, I'll apply this into cleanup-dma instead of fixes.

If it fixes something that I can't see, please reply with a description
what it fixes and I'll move it into fixes.

Regards,

Tony
