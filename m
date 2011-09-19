From: "Saxena, Parth" <parth.saxena@ti.com>
Subject: RE: [PATCH] ti816x: add support for nand on ti8168 evm
Date: Mon, 19 Sep 2011 17:04:40 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739404EC3121B9@dbde02.ent.ti.com>
References: <parth.saxena@ti.com>
	 <1315486982-30109-1-git-send-email-parth.saxena@ti.com>
 <1316408187.24366.52.camel@sauron>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40686 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754664Ab1ISLeu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Sep 2011 07:34:50 -0400
In-Reply-To: <1316408187.24366.52.camel@sauron>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "'dedekind1@gmail.com'" <dedekind1@gmail.com>
Cc: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "Basheer, Mansoor Ahamed" <mansoor.ahamed@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



> -----Original Message-----
> From: Artem Bityutskiy [mailto:dedekind1@gmail.com]
> Sent: Monday, September 19, 2011 10:26 AM
> To: Saxena, Parth
> Cc: linux-mtd@lists.infradead.org; Basheer, Mansoor Ahamed; linux-
> omap@vger.kernel.org
> Subject: Re: [PATCH] ti816x: add support for nand on ti8168 evm
> 
> On Thu, 2011-09-08 at 18:33 +0530, Saxena, Parth wrote:
> > Add partition table for NAND device on TI8168 EVM
> > and initialise the NAND module.
> >
> > Signed-off-by: Saxena, Parth <parth.saxena@ti.com>
> > Signed-off-by: Basheer, Mansoor Ahamed <mansoor.ahamed@ti.com>
> > ---
> >
> > This patch is tested on top of linux-omap/master and
> > Hemant's patches submitted recently.
> >
> > http://www.mail-archive.com/linux-omap@vger.kernel.org/msg53457.html
> > http://www.mail-archive.com/linux-omap@vger.kernel.org/msg54296.html
> >
> >  arch/arm/mach-omap2/board-ti8168evm.c |   39
> +++++++++++++++++++++++++++++++++
> >  1 files changed, 39 insertions(+), 0 deletions(-)
> 
> Please, send this patch to Tony, I think it should go in via the omap
> tree, not via the MTD tree.

[Saxena, Parth] 
Artem,
I will re-post this patch to linux-omap list and Tony. Can I add your name in the 'Acked-by' section?
> 
> --
> Best Regards,
> Artem Bityutskiy

