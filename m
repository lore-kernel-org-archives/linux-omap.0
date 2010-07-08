From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/9 v3] omap: generic: introduce a single check_revision
Date: Thu, 8 Jul 2010 15:21:57 +0300
Message-ID: <20100708122157.GI1920@atomide.com>
References: <1278590256.3787.14.camel@Nokia-N900>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:53781 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754969Ab0GHMWI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Jul 2010 08:22:08 -0400
Content-Disposition: inline
In-Reply-To: <1278590256.3787.14.camel@Nokia-N900>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, linux-omap <linux-omap@vger.kernel.org>, Angelo Arrifano <miknix@gmail.com>, "Zebediah C. McClure" <zmc@lurian.net>, Alistair Buxton <a.j.buxton@gmail.com>, Grazvydas Ignotas <notasas@gmail.com>, Paul Walmsley <paul@pwsan.com>, "Premi, Sanjeev" <premi@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Guruswamy, Senthilvadivu" <svadivu@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>, "ValkeinenTomi (Nokia-MS/Helsinki)" <Tomi.Valkeinen@nokia.com>, "Koskinen Aaro (Nokia-MS/Helsinki)" <aaro.koskinen@nokia.com>, "Pandita, Vikram" <vikram.pandita@ti.com>, "S, Vishwanath" <vishwa.s@ti.com>

* Menon, Nishanth <nm@ti.com> [100708 14:49]:
> 
> ----- Original message -----
> > Hi,
> > 
> > On Wed, Jul 07, 2010 at 07:24:16PM +0200, ext Nishanth Menon wrote:
> > > I am not sure.. if you would like drivers to be modprobabe, there may
> > be
> > > quirks that you'd want to enable based on cpu_is_omapxxx checks. so it
> > > probably does not make sense to __initdata the revision/feature
> > variables.
> > 
> > can't you pass the quirks via pdata, then ?
> 
> If pdata is passed based on board: Imagine 3630 and uart quirk. Why share errata xyz over pdata for every board using 3630? Quirks are cpu specific and not really domain of board..  

We should be able to handle the quirks by passing some
flag or function pointer from platform data.

The drivers should be arch independent, using cpu_is_omapxxxx
tests anywhere under drivers/* is wrong and should be
fixed.

Regards,

Tony
