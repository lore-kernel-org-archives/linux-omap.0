From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/9] Initial multi-omap support for omap4
Date: Sat, 30 Jan 2010 08:18:13 -0800
Message-ID: <20100130161813.GP23505@atomide.com>
References: <20100130020036.10590.78028.stgit@baageli.muru.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C0A68EB3@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:50344 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751309Ab0A3QRx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 30 Jan 2010 11:17:53 -0500
Content-Disposition: inline
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C0A68EB3@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Shilimkar, Santosh <santosh.shilimkar@ti.com> [100130 03:07]:
> Tony,
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Tony
> > Lindgren
> > Sent: Saturday, January 30, 2010 7:31 AM
> > To: linux-arm-kernel@lists.infradead.org
> > Cc: linux-omap@vger.kernel.org
> > Subject: [PATCH 0/9] Initial multi-omap support for omap4
> > 
> > Hi all,
> > 
> > These patches allow compiling in also omap4 into the multi-omap
> > configuration. As I don't yet have omap4, I've only boot tested
> > these on omap2 and omap3.
> > 
> > Somebody with an omap4 board please boot test these with the
> > omap3_defconfig and see what happens.. You might want to enable
> > DEBUG_LL and EARLY_PRINTK with earlyprintk on the cmdline too.
> Looks like this series have some dependent series because it doesn't
> apply on mainline.

Sorry, forgot to mention that these are against the earlier
multi-omap patches. Basically stuff that's now queued for the
merge window in the omap-for-linus branch.

> So I tested this directly on linux-omap "multi-omap4" branch. It boots sufficiently
> but doesn't proceed after "brd_init". Didn't get much time to debug so attached log

Thanks for testing. Yeah these same are in the multi-omap4
branch also.

Regards,

Tony
