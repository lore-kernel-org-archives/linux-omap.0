From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [Patch v4] OMAP: sDMA driver: descriptor autoloading feature
Date: Mon, 4 Jan 2010 14:30:55 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C02E9905@dbde02.ent.ti.com>
References: <618f0c910912110701p771dcf6fg655bb0a7b9bdc96d@mail.gmail.com>
	 <20091228214846.GP3512@atomide.com>
	 <618f0c911001032303p5d103f3et6271a71e1e5fbc96@mail.gmail.com>
	 <EAF47CD23C76F840A9E7FCE10091EFAB02C02E97E9@dbde02.ent.ti.com>
 <618f0c911001040048h573b2137v4577b8e00b0121a3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34316 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752439Ab0ADJBS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Jan 2010 04:01:18 -0500
In-Reply-To: <618f0c911001040048h573b2137v4577b8e00b0121a3@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "S, Venkatraman" <svenkatr@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

> >>
> >> I am about to start working on omap_hsmmc to use the descriptor load
> >> feature. If the DMA changes are acceptable, I can post the driver
> >> patch as well.
> >
> > I don't think doing this for hsmmc makes any sense considering, the IC in which DMA descriptor
> > is available( OMAP3630 and OMAP4), the HSMMC controller is already equipped with its dedicated
> > DMA controller (ADMA)
> >
> > Regards,
> > Santosh
> > --
> 
> AFAIK, 3630 does not have ADMA feature.
> In OMAP4, ADMA support is available for MMC controllers 1 and 2 only;
> the other 3 controllers still use sDMA.
You are correct. It surely help those cases.

Regards,
Santosh
