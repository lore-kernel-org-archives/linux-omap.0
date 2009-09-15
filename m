From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Exception while  handling MEM Hole on OMAP3 / ARM Cortex A8
Date: Tue, 15 Sep 2009 13:32:56 +0200
Message-ID: <20090915113256.GB1328@ucw.cz>
References: <20090815153357.GF29616@n2100.arm.linux.org.uk> <0680EC522D0CC943BC586913CF3768C003790C65ED@dbde02.ent.ti.com> <20090815181711.GG29616@n2100.arm.linux.org.uk> <20090817173343.GA17323@debian> <20090817174718.GU10764@n2100.arm.linux.org.uk> <20090817180145.GA17378@debian> <20090817180455.GW10764@n2100.arm.linux.org.uk> <A24693684029E5489D1D202277BE89444A8201BE@dlee02.ent.ti.com> <20090818030148.GA2283@debian> <20090907142210.GB23361@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:49260 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753164AbZIOLdA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Sep 2009 07:33:00 -0400
Content-Disposition: inline
In-Reply-To: <20090907142210.GB23361@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Rabin Vincent <rabin@rab.in>, "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>, "Syed Mohammed, Khasim" <khasim@ti.com>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon 2009-09-07 15:22:10, Russell King - ARM Linux wrote:
> On Tue, Aug 18, 2009 at 08:31:49AM +0530, Rabin Vincent wrote:
> > Here's a fixed version:
> 
> And here's my revised version with these fixes in.  I changed the
> while loop to a do..while loop instead (since we will always have
> at least one memory bank, it's pointless doing that test for the
> first iteration.)
> 
> Acks and tested-bys would be useful please.
> 

> +static int __init meminfo_cmp(const void *_a, const void *_b)
> +{
> +	const struct membank *a = _a, *b = _b;
> +	long cmp = bank_pfn_start(a) - bank_pfn_start(b);
> +	return cmp < 0 ? -1 : cmp > 0 ? 1 : 0;
> +}

I believe you can just return cmp here.

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
