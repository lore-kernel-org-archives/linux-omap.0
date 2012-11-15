From: Christopher Harvey <charvey@matrox.com>
Subject: Re: [PATCH v3] mtd: omap: nand: Remove 0xFF's that prefixed 16bit
 NAND addresses
Date: Thu, 15 Nov 2012 10:38:14 -0500
Message-ID: <20121115153814.GL2508@harvey-pc.matrox.com>
References: <20121029195127.GA32749@harvey-pc.matrox.com>
 <1352977329.2221.29.camel@sauron.fi.intel.com>
 <20121115144800.GI2508@harvey-pc.matrox.com>
 <1352992724.2221.61.camel@sauron.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mtxmxout1.matrox.com ([138.11.2.91]:58327 "EHLO
	mtxmxout1.matrox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767939Ab2KOPiS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Nov 2012 10:38:18 -0500
Content-Disposition: inline
In-Reply-To: <1352992724.2221.61.camel@sauron.fi.intel.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Artem Bityutskiy <dedekind1@gmail.com>
Cc: linux-mtd@lists.infradead.org, Ivan Djelic <ivan.djelic@parrot.com>, linux-omap@vger.kernel.org

On Thu, Nov 15, 2012 at 05:18:44PM +0200, Artem Bityutskiy wrote:
> On Thu, 2012-11-15 at 09:48 -0500, Christopher Harvey wrote:
> > On Thu, Nov 15, 2012 at 01:02:09PM +0200, Artem Bityutskiy wrote:
> > > On Mon, 2012-10-29 at 15:51 -0400, Christopher Harvey wrote:
> > > > In 16bit NAND mode the GPMC would send the address 0xNN as 0xFFNN
> > > > instead of 0x00NN on the bus. The 0xFFs were actually uninitialized
> > > > bits that were left unset in the GPMC command output register. The
> > > > reason they weren't initialized in 16bit mode is that if the same code
> > > > that writes to this register was used in 8bit mode then 2 commands
> > > > would be output in 8bit mode. One for the low byte, and an extra 0x0
> > > > command for the high byte. This commit uses writew if we're using
> > > > 16bit NAND. This commit also changes the high byte in the command
> > > > output register, but they are ignored by NAND chips anyway.
> > > > 
> > > > Most chips seem fine with the extra 0xFFs, but the ONFI spec says
> > > > otherwise.
> > > > 
> > > > Signed-off-by: Christopher Harvey <charvey@matrox.com>
> > > 
> > > Pushed to l2-mtd.git, thanks!
> > 
> > !!! Did anybody get around to testing this? I thought this patch had
> >     been abandoned. Will testing get done on an omap chip now that it
> >     is in a tree?
> > 
> > I should have prefixed it with RFC.
> 
> I assume _you_ tested it, and Ivan was happy. But if it is untested, I
> am dropping it.
> 

I'm running a slight variation of it on another version of the
kernel. I'm glad you're dropping it though...I have a reputation to
maintain as well as a kernel. ;)

-C

