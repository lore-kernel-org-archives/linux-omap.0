From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 27/30] ARM: omap: select L2X0 cache on omap4
Date: Mon, 3 Oct 2011 11:27:06 -0700
Message-ID: <20111003182705.GD6324@atomide.com>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de>
 <1317566760-25681-28-git-send-email-arnd@arndb.de>
 <4E89481C.4070405@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:32098 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932429Ab1JCS1K (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Oct 2011 14:27:10 -0400
Content-Disposition: inline
In-Reply-To: <4E89481C.4070405@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

* Santosh Shilimkar <santosh.shilimkar@ti.com> [111002 21:55]:
> On Sunday 02 October 2011 08:15 PM, Arnd Bergmann wrote:
> > The cache controller needs to be enabled for the
> > cortex-a9 specific errata that are also selected
> > to work.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>	

Acked-by: Tony Lindgren <tony@atomide.com>
