From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v4 10/12] ARM: OMAP1: board files: deduplicate and clean
 some NAND-related code
Date: Wed, 11 Apr 2012 12:45:01 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1204111243540.29473@utopia.booyaka.com>
References: <20120411003454.27059.37500.stgit@dusk> <20120411003555.27059.96204.stgit@dusk> <201204110912.01216.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:35526 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755819Ab2DKSpD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Apr 2012 14:45:03 -0400
In-Reply-To: <201204110912.01216.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Imre Deak <imre.deak@nokia.com>, Brian Swetland <swetland@google.com>, Kevin Hilman <kjh@hilman.org>, Kevin Hilman <khilman@ti.com>, Greg Lonnon <glonnon@ridgerun.com>

On Wed, 11 Apr 2012, Arnd Bergmann wrote:

> On Wednesday 11 April 2012, Paul Walmsley wrote:
> > +void omap1_nand_cmd_ctl(struct mtd_info *mtd, int cmd, unsigned int ctrl)
> > +{
> > +       struct nand_chip *this = mtd->priv;
> > +       unsigned long mask;
> > +
> > +       if (cmd == NAND_CMD_NONE)
> > +               return;
> > +
> > +       mask = (ctrl & NAND_CLE) ? 0x02 : 0;
> > +       if (ctrl & NAND_ALE)
> > +               mask |= 0x04;
> > +
> > +       mask |= (unsigned long)this->IO_ADDR_W;
> > +
> > +       writeb(cmd, (void __iomem *)mask);
> > +}
> 
> IO_ADDR_W is always a page aligned pointer AFAICT, so you can actually
> remove both casts and make it more readable at the same time by writing
> the last two lines as
> 
> 	writeb(cmd, this->IO_ADDR_W + mask);

Thanks, patch updated.


- Paul
