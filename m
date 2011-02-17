From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 2/6] ARM: pm: add generic CPU suspend/resume support
Date: Thu, 17 Feb 2011 23:36:05 +0000
Message-ID: <20110217233605.GB4110@n2100.arm.linux.org.uk>
References: <20110211161626.GA31356@n2100.arm.linux.org.uk> <E1Pnvgw-0002yZ-M0@rmk-PC.arm.linux.org.uk> <AANLkTinL0HgSsFmoxyiBuRA6JiWKsHTLW4wFnVDJf_1w@mail.gmail.com> <20110215110453.GB11199@n2100.arm.linux.org.uk> <AANLkTik_c4D7CPO9j9ZYUSuR45ggJ8Y953VLQCg4tkkr@mail.gmail.com> <1297939312.7096.32.camel@e102568-lin.cambridge.arm.com> <AANLkTincWLyqdtAoS4gxvhGZGRdzRAiQ41Pn8QSG-id=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:40959 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753961Ab1BQXgV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Feb 2011 18:36:21 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTincWLyqdtAoS4gxvhGZGRdzRAiQ41Pn8QSG-id=@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Colin Cross <ccross@google.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-omap@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel@lists.infradead.org

On Thu, Feb 17, 2011 at 12:05:59PM -0800, Colin Cross wrote:
> On Thu, Feb 17, 2011 at 2:41 AM, Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
> > I think that on resume you invalidate L1 in the reset vector before
> > jumping to cpu_resume, correct ?
>
> I manually invalidate the L1 Dcache, but not the Icache.

Well...
ARMv5 and older invalidates the L1 Dcache.
ARMv6 cleans and invalidates the L1 Dcache.
ARMv7 does nothing with the L1 Dcache.

That's rather inconsistent, but that's what people are doing with their
current suspend/resume paths.  We really ought to have this well-defined.

I don't see any reason why there should be any dirty data in the Dcache,
so I think the safe thing we should be doing in every case is a L1 Dcache
invalidate on resume.

That's a separate change though.
