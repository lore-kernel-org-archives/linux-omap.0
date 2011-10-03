From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 13/30] ARM: omap2+: fix omap_hdq_init compilation
Date: Mon, 3 Oct 2011 11:06:24 -0700
Message-ID: <20111003180624.GX6324@atomide.com>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de>
 <1317566760-25681-14-git-send-email-arnd@arndb.de>
 <4E8943EA.5060205@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:53852 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757156Ab1JCSG2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Oct 2011 14:06:28 -0400
Content-Disposition: inline
In-Reply-To: <4E8943EA.5060205@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Santosh Shilimkar <santosh.shilimkar@ti.com> [111002 21:37]:
> On Sunday 02 October 2011 08:15 PM, Arnd Bergmann wrote:
> > The definition of the device must depend on the hardware
> > we run on, not on the kernel configuration.
> > 
> > arch/arm/mach-omap2/devices.c:624:13: error: 'OMAP_HDQ_BASE' undeclared here (not in a function)
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Acked-by: Tony Lindgren <tony@atomide.com>
