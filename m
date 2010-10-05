From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH 08/10] OMAP: split plat-omap/common.c
Date: Mon, 4 Oct 2010 22:55:33 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1010042253210.13816@utopia.booyaka.com>
References: <20101001213119.1408.65395.stgit@twilight.localdomain> <20101001213532.1408.55832.stgit@twilight.localdomain> <EAF47CD23C76F840A9E7FCE10091EFAB030CDFE3C6@dbde02.ent.ti.com> <20101004065624.GD2559@legolas.emea.dhcp.ti.com>
 <20101004070040.GE2559@legolas.emea.dhcp.ti.com> <EAF47CD23C76F840A9E7FCE10091EFAB030CDFE4D9@dbde02.ent.ti.com> <alpine.DEB.2.00.1010041327040.13816@utopia.booyaka.com> <EAF47CD23C76F840A9E7FCE10091EFAB030CDFEA07@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:39156 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752529Ab0JEEzf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Oct 2010 00:55:35 -0400
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB030CDFEA07@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, khilman@deeprootsystems.com, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, 5 Oct 2010, Shilimkar, Santosh wrote:

> > -----Original Message-----
> > From: Paul Walmsley [mailto:paul@pwsan.com]
> > Sent: Tuesday, October 05, 2010 1:02 AM
> > 
> > It's great that this is getting cleaned up but it's too late for 2.6.37.
> > We stop taking new code after -rc6 comes out so we can try to get all of
> > the changes integrated with each other and fix any bugs.
> >
> The patch was lying on the list for quite some time but didn't get much
> attention before.

According to my archives, it looks like Kevin did quite a bit of review on 
it and requested that it be converted to use omap_hwmod, after which there 
was no response.  If it was converted to use hwmod and pm_runtime, it 
probably could have gone in with the other hwmod conversions in the .37 
merge window.

> > The best thing for you and Felipe to do is to convert the driver to use
> > hwmod data and pm_runtime and test on more platforms, then post it to the
> > list after 2.6.37 comes out.
> Probably this make sense.  


- Paul
