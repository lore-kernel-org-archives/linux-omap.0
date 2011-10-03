From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 30/30] ARM: omap2: select ARM_AMBA for OMAP3_EMU
Date: Mon, 3 Oct 2011 11:28:10 -0700
Message-ID: <20111003182810.GF6324@atomide.com>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de>
 <1317566760-25681-31-git-send-email-arnd@arndb.de>
 <4E8948C5.6080301@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:34147 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932264Ab1JCS2N (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Oct 2011 14:28:13 -0400
Content-Disposition: inline
In-Reply-To: <4E8948C5.6080301@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

* Santosh Shilimkar <santosh.shilimkar@ti.com> [111002 21:58]:
> On Sunday 02 October 2011 08:16 PM, Arnd Bergmann wrote:
> > OMAP3_EMU needs OC_ETM, which needs ARM_AMBA. Since the latter
> > dependency is getting turned from a 'select' into a 'depends',
> > omap has to select ARM_AMBA itself in order to have a correct
> > dependency chain. Alternatively, we could change OMAP3_EMU
> > to have a 'depends on OC_ETM' instead of selecting it.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Acked-by: Tony Lindgren <tony@atomide.com>
