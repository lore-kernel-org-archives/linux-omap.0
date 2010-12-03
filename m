From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH V2] omap: nand: remove hardware ECC as default
Date: Fri, 03 Dec 2010 16:38:50 +0000
Message-ID: <1291394352.5992.4.camel@i7.infradead.org>
References: <1290177926-3526-1-git-send-email-s-ghorai@ti.com>
	 <20101130180542.GP17222@atomide.com> <1291393325.2365.72.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:41897 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752617Ab0LCQjQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Dec 2010 11:39:16 -0500
In-Reply-To: <1291393325.2365.72.camel@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dedekind1@gmail.com
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, Sukumar Ghorai <s-ghorai@ti.com>

On Fri, 2010-12-03 at 18:22 +0200, Artem Bityutskiy wrote:
> On Tue, 2010-11-30 at 10:05 -0800, Tony Lindgren wrote:
> > * Sukumar Ghorai <s-ghorai@ti.com> [101119 06:36]:
> > > CONFIG_MTD_NAND_OMAP_HWECC defined wrongly in patch submitted for 2.6.36.
> > > This flag enables hw ecc by default. Boards like beagle and pandora uses
> > > sw ecc for write (e.g. binary flushed from u-boot) and read from kernel.
> > > https://patchwork.kernel.org/patch/111036/
> > > 
> > > Signed-off-by: Sukumar Ghorai <s-ghorai@ti.com>
> > 
> > This should go in as a fix for the -rc via MTD list if possible.
> > 
> > Acked-by: Tony Lindgren <tony@atomide.com>
> 
> Tony, I think this is quite simple patch, and you can merge it yourself,
> MTD tree is slow. I hope dwmw2 will not beat me for this, but unless he
> quickly jumps in and confirms he takes care of this patch, just go ahead
> an merge it. I've put dwmw2 to "To:", just in case.

Acked-by: David Woodhouse <David.Woodhouse@intel.com>

Unless you'd prefer me to send it on myself, please feel free to submit
it to Linus directly.

-- 
dwmw2

