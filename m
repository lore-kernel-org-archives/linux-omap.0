From: Ivan Djelic <ivan.djelic@parrot.com>
Subject: Re: [PATCH] mtd: nand: omap: add support for hardware BCH ecc
Date: Fri, 20 Apr 2012 13:22:52 +0200
Message-ID: <20120420112252.GA12151@parrot.com>
References: <1334915328-10673-1-git-send-email-ivan.djelic@parrot.com>
 <CANOLnOOjrZEbPByOD3EQTZ3vn2ZO0SMdyYo1oME_NLRyYciXUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from co202.xi-lite.net ([149.6.83.202]:45029 "EHLO co202.xi-lite.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754999Ab2DTLX4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Apr 2012 07:23:56 -0400
Content-Disposition: inline
In-Reply-To: <CANOLnOOjrZEbPByOD3EQTZ3vn2ZO0SMdyYo1oME_NLRyYciXUQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, Jan Weitzel <J.Weitzel@phytec.de>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, Apr 20, 2012 at 12:12:27PM +0100, Grazvydas Ignotas wrote:
> On Fri, Apr 20, 2012 at 12:48 PM, Ivan Djelic <ivan.djelic@parrot.com> wrote:
> > Hello,
> > This patch provides hardware NAND BCH ecc support for OMAP3 boards.
> > It depends on the following patches:
> >
> > new GPMC BCH api (linux-omap):
> > http://lists.infradead.org/pipermail/linux-mtd/2012-April/040757.html
> >
> > race condition fix in OMAP mtd driver:
> > http://lists.infradead.org/pipermail/linux-mtd/2012-April/040724.html
> 
> I don't have this one in my mailbox (looked up through the archives),
> so commenting about it here. What about just dropping omap_wait()
> instead? I think gpmc_nand_read(.. GPMC_NAND_DATA) is equivalent to
> ordinary data read, knowing that omap_wait() looks like a duplicate of
> generic nand_wait(), just without LED support.

Yes, I agree; I also comtemplated getting rid of omap_wait(), but I needed this
quick fix out of the way to submit my BCH patch. But you're right, and there
are plenty other things to improve in omap2.c (look at omap_compare_ecc() for
a good example).
BR,
--
Ivan
