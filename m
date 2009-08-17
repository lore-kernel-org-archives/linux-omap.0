From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Exception while  handling MEM Hole on OMAP3 / ARM Cortex A8
Date: Mon, 17 Aug 2009 17:50:54 +0100
Message-ID: <20090817165054.GR10764@n2100.arm.linux.org.uk>
References: <0680EC522D0CC943BC586913CF3768C00378FF3971@dbde02.ent.ti.com> <20090807220016.GG31543@n2100.arm.linux.org.uk> <0680EC522D0CC943BC586913CF3768C003790C5B3A@dbde02.ent.ti.com> <20090808170300.GA23481@n2100.arm.linux.org.uk> <0680EC522D0CC943BC586913CF3768C003790C64CF@dbde02.ent.ti.com> <20090813173327.GA14872@n2100.arm.linux.org.uk> <0680EC522D0CC943BC586913CF3768C003790C6586@dbde02.ent.ti.com> <20090815153357.GF29616@n2100.arm.linux.org.uk> <20090815181711.GG29616@n2100.arm.linux.org.uk> <0680EC522D0CC943BC586913CF3768C003790C67DC@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:49621 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754144AbZHQQvF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Aug 2009 12:51:05 -0400
Content-Disposition: inline
In-Reply-To: <0680EC522D0CC943BC586913CF3768C003790C67DC@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Syed Mohammed, Khasim" <khasim@ti.com>
Cc: "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, Aug 17, 2009 at 04:40:27PM +0530, Syed Mohammed, Khasim wrote:
> This patch seem to be working, I don't see any dump like before.

Great.

> Can you please advice on how to get this patch into kernel? I mean,
> will you be handling it or we need to re-submit them with your signed off?

Yes, I'll be sending it.  However, I believe the patch I sent contains
one error:

> > +static int __init meminfo_cmp(const void *_a, const void *_b)
> > +{
> > +	const struct membank *a = _a, *b = _b;
> > +	long cmp = bank_pfn_start(b) - bank_pfn_start(a);

I think this should be bank_pfn_start(a) - bank_pfn_start(b).  When you
tested this unmodified patch, did the "Memory:" line list the memory
bank sizes in reverse order?
