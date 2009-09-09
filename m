From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: RE: Exception while  handling MEM Hole on OMAP3 / ARM Cortex A8
Date: Tue, 8 Sep 2009 21:05:05 -0500
Message-ID: <A24693684029E5489D1D202277BE89444B781B03@dlee02.ent.ti.com>
References: <20090815153357.GF29616@n2100.arm.linux.org.uk>
 <0680EC522D0CC943BC586913CF3768C003790C65ED@dbde02.ent.ti.com>
 <20090815181711.GG29616@n2100.arm.linux.org.uk>
 <20090817173343.GA17323@debian>
 <20090817174718.GU10764@n2100.arm.linux.org.uk>
 <20090817180145.GA17378@debian>
 <20090817180455.GW10764@n2100.arm.linux.org.uk>
 <A24693684029E5489D1D202277BE89444A8201BE@dlee02.ent.ti.com>
 <20090818030148.GA2283@debian>
 <20090907142210.GB23361@n2100.arm.linux.org.uk>,<20090908202302.GE23361@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57668 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752414AbZIICJY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Sep 2009 22:09:24 -0400
In-Reply-To: <20090908202302.GE23361@n2100.arm.linux.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Rabin Vincent <rabin@rab.in>
Cc: "Syed Mohammed, Khasim" <khasim@ti.com>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

From: Russell King - ARM Linux [linux@arm.linux.org.uk]
Sent: Tuesday, September 08, 2009 11:23 PM
> On Mon, Sep 07, 2009 at 03:22:10PM +0100, Russell King - ARM Linux wrote:
> > On Tue, Aug 18, 2009 at 08:31:49AM +0530, Rabin Vincent wrote:
> > > Here's a fixed version:
> >
> > And here's my revised version with these fixes in.  I changed the
> > while loop to a do..while loop instead (since we will always have
> > at least one memory bank, it's pointless doing that test for the
> > first iteration.)
> >
> > Acks and tested-bys would be useful please.
> 
> Haven't heard anything, so I've committed it as is.  It is my intention
> to push it to Linus as is in the next couple of days.

Russell,

I don't have ways of testing this, but I think Khasim's testing will make more sense,
since he reported the bug... anyways, it's probably too late.

Regards,
Sergio