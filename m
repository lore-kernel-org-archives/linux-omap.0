From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 4/5] ARM: scu: Move register defines to header file
Date: Mon, 7 Feb 2011 15:51:04 +0530
Message-ID: <9a00af58d2fc4d1792c382d02068c865@mail.gmail.com>
References: <20110125121655.GD13300@n2100.arm.linux.org.uk>
 <4534e82bf14eeea9f96769df760df5ae@mail.gmail.com> <20110125125656.GG13300@n2100.arm.linux.org.uk>
 <20110125130422.GH13300@n2100.arm.linux.org.uk> <20110125130611.GA15663@n2100.arm.linux.org.uk>
 <627ff975140c8e4afbad281105b29d35@mail.gmail.com> <20110204104113.GD15004@n2100.arm.linux.org.uk>
 <c703383234131695d040a1e5b8a79413@mail.gmail.com> <20110204113053.GF15004@n2100.arm.linux.org.uk>
 <247f9ef444eeb8ca59de74837a3e9c62@mail.gmail.com> <20110207101829.GA32431@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:35351 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751120Ab1BGKV2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Feb 2011 05:21:28 -0500
Received: by iye19 with SMTP id 19so4889642iye.32
        for <linux-omap@vger.kernel.org>; Mon, 07 Feb 2011 02:21:07 -0800 (PST)
In-Reply-To: <20110207101829.GA32431@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: catalin.marinas@arm.com, linus.ml.walleij@gmail.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ccross@android.com

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]
> Sent: Monday, February 07, 2011 3:48 PM
> To: Santosh Shilimkar
> Cc: catalin.marinas@arm.com; linus.ml.walleij@gmail.com; linux-
> omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> ccross@android.com
> Subject: Re: [PATCH 4/5] ARM: scu: Move register defines to header
> file
>
[....]

> > > +int scu_power_mode(void __iomem *scu_base, unsigned int mode)
> > > +{
> > > +	unsigned int val;
> > > +	int cpu = smp_processor_id();
> > > +	int shift;
> > shift is unused with this version now so I am removing it.
>
> Yes, I noticed that - it's gone in the version I merged into my
> tree.
Ok.
Did you also merged twd patch of yours ?
