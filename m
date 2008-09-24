From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Clean-up MMC device init (Was:
	[PATCH]Enable 4-bit in HSMMC1 and HSMMC2 platform data)
Date: Wed, 24 Sep 2008 12:02:35 +0300
Message-ID: <20080924090234.GI5222@atomide.com>
References: <20080910235646.GV21163@atomide.com> <20080911084828.GC26078@flint.arm.linux.org.uk> <20080911091309.GD26078@flint.arm.linux.org.uk> <20080911173333.GI21163@atomide.com> <20080911181312.GC4986@flint.arm.linux.org.uk> <20080912004848.GO21163@atomide.com> <20080913095946.GA24437@flint.arm.linux.org.uk> <20080913171134.GB27348@atomide.com> <20080916231356.GB25885@atomide.com> <20080917075759.GM27108@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:62623 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751234AbYIXJCs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Sep 2008 05:02:48 -0400
Content-Disposition: inline
In-Reply-To: <20080917075759.GM27108@flint.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Madhusudhan Chikkature <madhu.cr@ti.com>, linux-omap@vger.kernel.org, Pierre Ossman <drzeus-list@drzeus.cx>, "Jarkko Lavinen (NMP/Helsinki)" <jarkko.lavinen@nokia.com>, Carlos Aguiar <carlos.aguiar@indt.org.br>

* Russell King - ARM Linux <linux@arm.linux.org.uk> [080917 10:58]:
> On Tue, Sep 16, 2008 at 04:13:57PM -0700, Tony Lindgren wrote:
> > > OK
> > 
> > Here's the patch updated. If necessary, the patch could be broken into
> > several parts.
> 
> I've already got a patch doing what I've outlined (and some other stuff)
> I just haven't had time to finish it off to email out yet.

I guess I'll push my MMC init fixes to l-o tree and start working a
set of patches for you. If you have your MMC init patch somewhere,
let me know and I'll merge them with my patch. Sounds like they pretty
much do the same, so merging should be trivial.

Tony
