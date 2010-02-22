From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/9] omap3/4: uart: fix full-fifo write abort
Date: Mon, 22 Feb 2010 15:07:12 -0800
Message-ID: <20100222230712.GB18786@atomide.com>
References: <1266483554-15044-1-git-send-email-santosh.shilimkar@ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C417FA42@dbde02.ent.ti.com>
 <20100222213932.GW18786@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:51389 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754457Ab0BVXGR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Feb 2010 18:06:17 -0500
Content-Disposition: inline
In-Reply-To: <20100222213932.GW18786@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Woodruff, Richard" <r-woodruff2@ti.com>, "Ghorai, Sukumar" <s-ghorai@ti.com>

* Tony Lindgren <tony@atomide.com> [100222 13:35]:
> * Shilimkar, Santosh <santosh.shilimkar@ti.com> [100218 21:22]:
> > Bye the way just to add bit more clarity, this patch addresses TX
> > hardware restriction in the new UART IP used on omap3630 and omap4430.
> > First part of the fix for RX is already in mainline,
> > Commit: "ce13d4716a276f4331d78ba28a5093a63822ab95"
> > 
> > More details on this thread are here.
> > http://www.mail-archive.com/linux-omap@vger.kernel.org/msg19447.html
> 
> Thanks, I've updated the comments for this patch with the link above
> and added the whole series into omap for-next.

Except patches 8 and 9 as they break compile for mach-omap1
and need to be updated.

Regards,

Tony
