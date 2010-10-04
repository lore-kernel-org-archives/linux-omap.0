From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 08/10] OMAP: split plat-omap/common.c
Date: Mon, 4 Oct 2010 11:21:23 -0700
Message-ID: <20101004182122.GY3117@atomide.com>
References: <20101001213119.1408.65395.stgit@twilight.localdomain>
 <20101001213532.1408.55832.stgit@twilight.localdomain>
 <EAF47CD23C76F840A9E7FCE10091EFAB030CDFE3C6@dbde02.ent.ti.com>
 <20101004065624.GD2559@legolas.emea.dhcp.ti.com>
 <20101004070040.GE2559@legolas.emea.dhcp.ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB030CDFE4D9@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:49335 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755022Ab0JDSV1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Oct 2010 14:21:27 -0400
Content-Disposition: inline
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB030CDFE4D9@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Shilimkar, Santosh <santosh.shilimkar@ti.com> [101004 00:20]:
> > >
> > >[1] git://gitorious.org/usb/usb.git clksource
> > 
> > I made a few changes to make checkpatch.pl --strict happy. Attached
> > 
> Good !!
> This patch addresses splitting as well as multi-omap builds and probably
> also a better candidate in case we need to convert sync timer to hwmod
> driver.
> 
> Paul, what's your take?

I think we need to first merge Paul's series to fix the omap1
compile issue and the ASoC module compile issue.

The other changes should be trivial to rebase on top of that.

Regards,

Tony
