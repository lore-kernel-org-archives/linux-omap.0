From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 7/7] OMAP3: powerdomain data: add voltage domains
Date: Tue, 22 Mar 2011 16:15:56 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1103221615340.11798@utopia.booyaka.com>
References: <1300493932-17362-1-git-send-email-khilman@ti.com> <1300493932-17362-8-git-send-email-khilman@ti.com> <alpine.DEB.2.00.1103221324461.11798@utopia.booyaka.com> <4D89100F.1000909@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:58056 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753417Ab1CVWP5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Mar 2011 18:15:57 -0400
In-Reply-To: <4D89100F.1000909@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "Hilman, Kevin" <khilman@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, 22 Mar 2011, Cousson, Benoit wrote:

> On 3/22/2011 8:30 PM, Paul Walmsley wrote:
> > On Fri, 18 Mar 2011, Kevin Hilman wrote:
> > 
> > > Add voltage domain name to indicate which voltagedomain each
> > > powerdomain is in.  A missing voltage domain name means that that
> > > powerdomain is not in one of the currently scalable voltage domains.
> > 
> > Before you add these, you might want to change the voltagedomain names for
> > OMAP3.  I don't think it's correct to refer to the VDD1 voltagedomain as
> > "mpu" since it includes both the MPU and IVA.  Probably best to use simply
> > "vdd1" and "vdd2" since that is the historical usage.
> 
> Yes, but it was confusing, hence the change on OMAP4.
> "core" is fine and better that vdd2, maybe "mpu_iva" will be better for vdd1.
> Moreover, it will be consistent will all the OMAP4+ chips.

Calling it "mpu_iva" is fine with me also.

> > >   static struct powerdomain dpll1_pwrdm = {
> > 
> > These DPLL powerdomains should have voltagedomains also.  DPLL1 is in
> > VDD1, I believe.  I think the rest are in VDD2.
> 
> DPLL1 (MPU) & DPLL2 (IVA) are inside vdd1, DPLL3, 4 & 5 are inside the core
> (vdd2)

Indeed.

- Paul
