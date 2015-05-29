From: Tony Lindgren <tony@atomide.com>
Subject: Re: runtime check for omap-aes bus access permission (was: Re:
 3.13-rc3 (commit 7ce93f3) breaks Nokia N900 DT boot)
Date: Fri, 29 May 2015 08:50:31 -0700
Message-ID: <20150529155030.GO30984@atomide.com>
References: <201502111339.54480@pali>
 <CAALWOA_ngoSKjB=ZQ264Va37bBK7v41Ei45SyoYLiMdanTKnxQ@mail.gmail.com>
 <201502112128.44852@pali>
 <CAGo_u6oZxi7O6re30L2-wVyxTeahhyMb4qVcrE3tSCV9sBvrnw@mail.gmail.com>
 <20150528073740.GD16509@pali>
 <20150528160113.GH30984@atomide.com>
 <CAALWOA8Pfc_zbN9MoHwR=njPBpFU56WObYMbGv9N7ktzy+RSeQ@mail.gmail.com>
 <20150528222412.GM30984@atomide.com>
 <CAALWOA9qJHUST0JQxA6MBohMfbTYAP9+NbSXGYHZY4Xa3nSFvw@mail.gmail.com>
 <CAALWOA82=QmTpCeiceOFQOjqXKdSBjB3Z+jL-mi0vYF=QaL4sA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:54635 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751298AbbE2Pud (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 May 2015 11:50:33 -0400
Content-Disposition: inline
In-Reply-To: <CAALWOA82=QmTpCeiceOFQOjqXKdSBjB3Z+jL-mi0vYF=QaL4sA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Matthijs van Duin <matthijsvanduin@gmail.com>
Cc: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sebastian Reichel <sre@ring0.de>, linux-omap <linux-omap@vger.kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>, lkml <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>

* Matthijs van Duin <matthijsvanduin@gmail.com> [150528 18:37]:
> On 29 May 2015 at 02:58, Matthijs van Duin <matthijsvanduin@gmail.com> wrote:
> > It is only guaranteed to happen immediately (before the next
> > instruction is executed) if the error occurs before the posting-point
> > of the write. However, in that case the error is reported in-band to
> > the cpu, resulting in a (synchronous) bus error which takes precedence
> > over the out-of-band error irq (if any is signalled).
> 
> OK, all this was actually assuming linux uses device-type mappings for
> device mappings, which was also the impression I got from
> build_mem_type_table() in arch/arm/mm/mmu.c (although it's a bit of a
> maze). A quick test however seems to imply otherwise:
> 
> ~# ./bogus-dev-write
> Bus error
> 
> So... linux actually uses strongly-ordered mappings? I really didn't
> expect that, given the performance implications (especially on a
> strictly in-order cpu like the Cortex-A8 which will really just sit
> there picking its nose until the write completes) and I think I recall
> having seen an OCP barrier being used somewhere in driver code...

I believe some TI kernels use strongly-ordered mappings, mainline
kernel does not. Which kernel version are you using?
 
> Well, in that case everything I said is technically still true, except
> the posting point is the peripheral itself. That also means the
> interconnect error reporting mechanism is not really useful for
> probing since you'll get a bus error before any error irq is
> delivered.

Hmm if that's the case then yes we can't use the error irq. However,
what I've seen so far is that we only get the bus error if the
l3_* drivers are configured. I guess some more testing is needed.
 
> So I'd say you're back at having to trap that bus error using the
> exception handling mechanism, which I still suspect shouldn't be hard
> to do.

And in that case it makes sense to do that in the bootloader to
avoid adding any custom early boot code to Linux kernel.
 
> Or perhaps you could probe the device using a DMA access and combine
> that with the interconnect error reporting irq... ;-)

Heh too many dependencies :)

Tony
