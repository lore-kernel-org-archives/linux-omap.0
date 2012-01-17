From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: OMAP3 L2/outer cache enabled in kernel (after being disabled
 by uBoot)?
Date: Tue, 17 Jan 2012 12:11:38 +0000
Message-ID: <20120117121138.GC11475@arm.com>
References: <WC20120116100344.4204CC@terrafix.co.uk>
 <CAMQu2gw4H=m1QA+ucORYsO_LZR8Sj57=+jwmrkHu_7sdCzhN8g@mail.gmail.com>
 <20120116105949.GG16726@n2100.arm.linux.org.uk>
 <CAMQu2gyBVOyWSCT39jP6xEtoNKrUCuaj_QTD+1EVhXgVc_H2HA@mail.gmail.com>
 <20120116131329.GA928@n2100.arm.linux.org.uk>
 <CAMQu2gzPGrbBd4_SOM0TFfGH_Y+XYzoh2XjsoPgpzU10tFOpYQ@mail.gmail.com>
 <WC20120117085444.17057E@terrafix.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:58897 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753097Ab2AQMMK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Jan 2012 07:12:10 -0500
Content-Disposition: inline
In-Reply-To: <WC20120117085444.17057E@terrafix.co.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joe Woodward <jw@terrafix.co.uk>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On Tue, Jan 17, 2012 at 08:54:44AM +0000, Joe Woodward wrote:
> So, is the upshot of this that the kernel isn't going to be in a
> position to enable the L2/outer cache on OMAP3 (due to the need for
> hacky/unmaintainable code)?
> 
> Hence the bootloader/uBoot had better leave it enabled...

It could but the Linux decompressor needs to be aware and either flush
the L2 (more difficult as it doesn't have all the device information) or
set the page table attributes to outer non-cacheable (TEX[2:0] = 0b100).
The latter may still not work if there are stale L2 cache lines left by
U-Boot (and that's always possible unless U-Boot also uses outer
non-cacheable memory attributes).

But I would agree with Aneesh - can we not enabled the L2 at a later
point?

-- 
Catalin
