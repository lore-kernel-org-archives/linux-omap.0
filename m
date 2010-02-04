From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/5] cache-l2x0 and omap4 l2 support
Date: Thu, 4 Feb 2010 08:14:18 -0800
Message-ID: <20100204161417.GQ22747@atomide.com>
References: <EAF47CD23C76F840A9E7FCE10091EFAB02C0B425F9@dbde02.ent.ti.com>
 <20100204144344.GC27344@n2100.arm.linux.org.uk>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C0B42645@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:63772 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933099Ab0BDQOE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Feb 2010 11:14:04 -0500
Content-Disposition: inline
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C0B42645@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Shilimkar, Santosh <santosh.shilimkar@ti.com> [100204 07:59]:
> Tony,
> > -----Original Message-----
> > From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]
> > Sent: Thursday, February 04, 2010 8:14 PM
> > To: Shilimkar, Santosh
> > Cc: Tony Lindgren; Catalin Marinas; linux-arm-kernel@lists.infradead.org; linux-omap@vger.kernel.org
> > Subject: Re: [PATCH 0/5] cache-l2x0 and omap4 l2 support
> > 
> > On Thu, Feb 04, 2010 at 07:52:52PM +0530, Shilimkar, Santosh wrote:
> > > Russell / Tony,
> > >
> > > Here is the series which combines earlier two series because of dependency and
> > > rebased against 2.6.33-rc2. This series also implements Russell's suggested
> > > combined monitor API. Tested on OMAP4430 SDP
> > 
> > If you fix up those two patches, I think it can to into the patch system
> > when some acks have been received.
> 
> Can you check this series and provide your ack. Will you be ok if this series
> gets merged through Russell's patch system ?

Yeah looks good to me for all of them:

Acked-by: Tony Lindgren <tony@atomide.com>
