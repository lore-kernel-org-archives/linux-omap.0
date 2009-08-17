From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Exception while  handling MEM Hole on OMAP3 / ARM Cortex A8
Date: Mon, 17 Aug 2009 18:47:18 +0100
Message-ID: <20090817174718.GU10764@n2100.arm.linux.org.uk>
References: <20090807220016.GG31543@n2100.arm.linux.org.uk> <0680EC522D0CC943BC586913CF3768C003790C5B3A@dbde02.ent.ti.com> <20090808170300.GA23481@n2100.arm.linux.org.uk> <0680EC522D0CC943BC586913CF3768C003790C64CF@dbde02.ent.ti.com> <20090813173327.GA14872@n2100.arm.linux.org.uk> <0680EC522D0CC943BC586913CF3768C003790C6586@dbde02.ent.ti.com> <20090815153357.GF29616@n2100.arm.linux.org.uk> <0680EC522D0CC943BC586913CF3768C003790C65ED@dbde02.ent.ti.com> <20090815181711.GG29616@n2100.arm.linux.org.uk> <20090817173343.GA17323@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:60962 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757819AbZHQRsT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Aug 2009 13:48:19 -0400
Content-Disposition: inline
In-Reply-To: <20090817173343.GA17323@debian>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rabin Vincent <rabin@rab.in>
Cc: "Syed Mohammed, Khasim" <khasim@ti.com>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, Aug 17, 2009 at 11:03:44PM +0530, Rabin Vincent wrote:
> On Sat, Aug 15, 2009 at 07:17:11PM +0100, Russell King - ARM Linux wrote:
> > +#ifndef CONFIG_SPARSEMEM
> > +int pfn_valid(unsigned long pfn)
> > +{
> > +	struct meminfo *mi = &meminfo;
> > +	unsigned int mid, left = 0, right = mi->nr_banks;
> > +
> > +	while ((mid = (right - left) / 2) > 0) {
> > +		struct membank *bank = &mi->bank[mid];
> > +
> > +		if (pfn < bank_pfn_start(bank))
> > +			right = mid;
> > +		else if (pfn >= bank_pfn_end(bank))
> > +			left = mid + 1;
> > +		else
> > +			return 1;
> > +	}
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL(pfn_valid);
> > +#endif
> 
> The above function will ignore the first bank.  I don't think that was
> intended.

Why do you say that?

Let's start with 4 membank entries - 0 1 2 3.

0 covers 0-10, 1 covers 20-30, 2 covers 40-50 and 3 covers 60-70.

Let's run through the steps looking for 5:

Initally, left = 0, right = 4, so mid=2.  5 < 40?  Yes, so right becomes 2.

left = 0, right = 2, so mid=1.  5 < 20?  Yes, so right becomes 1.

left = 0, right = 1, so mid=0.  5 < 0?  No.  5 >= 10?  No.  so return 1.

This doesn't look to me like it ignores the first bank.  I think you're
wrong.  Please provide me with your proof ASAP because right now it's
pending for Linus.
