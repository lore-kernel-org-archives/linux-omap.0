From: Ivan Djelic <ivan.djelic@parrot.com>
Subject: Re: [PATCH 0/3] GPMC NAND isr using standard API
Date: Sat, 19 May 2012 14:50:18 +0200
Message-ID: <20120519125018.GA2407@parrot.com>
References: <cover.1337090835.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from co202.xi-lite.net ([149.6.83.202]:44167 "EHLO co202.xi-lite.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755894Ab2ESMuz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 19 May 2012 08:50:55 -0400
Content-Disposition: inline
In-Reply-To: <cover.1337090835.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Afzal Mohammed <afzal@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "artem.bityutskiy@linux.intel.com" <artem.bityutskiy@linux.intel.com>, "dedekind1@gmail.com" <dedekind1@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>

On Tue, May 15, 2012 at 03:38:09PM +0100, Afzal Mohammed wrote:
> Hi Tony, Artem,
> 
> This series creates a fictitious GPMC interrupt chip and provide the
> clients with interrupts that could be handled using standard APIs.
> This helps in removing the requirement of driver of peripheral
> connected to GPMC having the knowledge about GPMC. The only user is
> OMAP NAND driver, it has also been modified to use interrupts provided
> by imaginary GPMC chip.
> 
> This series has a dependency on [2], while [2] has a trivial
> dependency on [1].
> 
> With this series plus [1,2], GPMC driver conversion which is going to
> happen shortly will not create noticable effect outside of
> arch/arm/*omap*/.
> 
> If this series along with [1,2] can be taken in for 3.5, ripples felt
> by MTD drivers upon GPMC driver conversion would be minimal.

Hi Afzal,

I tried to take your series of patches, but I had issues with the
first [1] (I did not try the others): it depends on the following patch,
which is not in the l2-mtd-2.6 tree:

http://www.mail-archive.com/linux-omap@vger.kernel.org/msg68258.html

and it does not apply anyway to l2-mtd-2.6 because of (at least) the
following patches:

http://lists.infradead.org/pipermail/linux-mtd/2012-April/040631.html
http://lists.infradead.org/pipermail/linux-mtd/2012-April/040724.html

So, do you think you could rebase your series on l2-mtd-2.6 ?
And maybe merge the 3 series into a single one, if they have circular
dependencies ?

Thanks,

--
Ivan

[1] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg68581.html
[2] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg68652.html
