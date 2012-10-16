From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 00/14] OMAP-GPMC related cleanup for common zImage
Date: Tue, 16 Oct 2012 11:06:01 -0700
Message-ID: <20121016180600.GA15569@atomide.com>
References: <cover.1349672877.git.afzal@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9F7B0A@DBDE01.ent.ti.com>
 <20121010163840.GA13585@parrot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:54324 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754776Ab2JPSGH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Oct 2012 14:06:07 -0400
Content-Disposition: inline
In-Reply-To: <20121010163840.GA13585@parrot.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ivan Djelic <ivan.djelic@parrot.com>
Cc: "Mohammed, Afzal" <afzal@ti.com>, Artem Bityutskiy <dedekind1@gmail.com>, "Hunter, Jon" <jon-hunter@ti.com>, Paul Walmsley <paul@pwsan.com>, David Woodhouse <dwmw2@infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>

* Ivan Djelic <ivan.djelic@parrot.com> [121010 09:40]:
> 
> I ran several mtd regression tests on a Beagle Board on your gpmc-czimage-v2 tag.
> All BCH error correcting tests passed successfully.
> 
> I occasionally had weird read errors though, especially when reading blank pages:
> the omap driver returned 512-byte sectors containing something like:
> 
> 30ff30ff30ff30ff30ff30ff30ff30ff30ff30ff30ff30ff30ff30ff30ff30ff
> 30ff30ff30ff30ff30ff30ff30ff30ff30ff30ff30ff30ff30ff30ff30ff30ff
> 30ff30ff30ff30ff30ff30ff30ff30ff30ff30ff30ff30ff30ff30ff30ff30ff
> 30ff30ff30ff30ff30ff30ff30ff30ff30ff30ff30ff30ff30ff30ff30ff30ff
> 30ff30ff30ff30ff30ff30ff30ff30ff30ff30ff30ff30ff30ff30ff30ff30ff
> 30ff30ff30ff30ff30ff30ff30ff30ff30ff30ff30ff30ff30ff30ffffffffff
> ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
> ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
> ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
> ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
> ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
> ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
> ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
> ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
> ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
> ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
> 
> instead of:
> 
> ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
> ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
> ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
> ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
> ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
> ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
> ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
> ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
> ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
> ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
> ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
> ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
> ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
> ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
> ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
> ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
> 
> I was able to reproduce the problem also on l2-mtd tip, albeit less often.
> The problem seems to occur quite randomly, it may be a hardware issue on
> my board...

Things like this typically happen in the GPMC timings are not correct.
Maybe add #define DEBUG to top of gpmc.c and compare the timings
before and after Afzal's patches? 

> Anyway, the ECC handling part looks OK to me.

Regards,

Tony
