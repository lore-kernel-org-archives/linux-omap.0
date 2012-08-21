From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: gpmc generic retime function (subject was RE: [PATCH v5 3/3]
 ARM: OMAP2+: onenand: prepare for gpmc driver migration)
Date: Tue, 21 Aug 2012 11:14:07 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E9B854C@DBDE01.ent.ti.com>
References: <C8443D0743D26F4388EA172BF4E2A7A93E9A35E1@DBDE01.ent.ti.com>
 <20120705105535.GB1122@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9A39DF@DBDE01.ent.ti.com>
 <20120706120533.GU1122@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9A622E@DBDE01.ent.ti.com>
 <20120710094538.GT1122@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9A64D0@DBDE01.ent.ti.com>
 <20120710131734.GV1122@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9A669D@DBDE01.ent.ti.com>
 <4FFC6330.1040409@ti.com> <20120711064724.GA1122@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9B150D@DBDE01.ent.ti.com>
 <502E5D0A.2030109@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51261 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751643Ab2HULON convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Aug 2012 07:14:13 -0400
In-Reply-To: <502E5D0A.2030109@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hunter, Jon" <jon-hunter@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Jon,

On Fri, Aug 17, 2012 at 20:32:34, Hunter, Jon wrote:

> > And we have been able to create such a function. Below is an implementation
> > that has been made for handling asynchronous timings. It has been tested for
> > OneNAND & SMSC on OMAP3EVM (rev G & C) with [1-4]. OneNAND was tested using
> > [5] (OMAP3EVM OneNAND works in async mode) & SMSC using [6] (mainline does
> > not have a timing calculation for smsc911x)
> 
> Are you able to verify that the timing calculated by this function are
> identical? May be some more details on exactly how you tested this would
> be good.

Yes, it was verified.

A new driver preparation series has been posted,
	http://marc.info/?l=linux-omap&m=134554573104116&w=2
that includes generic timing calculation method.

The new series mentions how timing values were validated. There are a
couple of timing parameters that would vary as mentioned in the above
mentioned mail, but these I don't expect to create problems as this is 
more inline with gpmc peripheral timings. And both of the these has
been verified that it would not create problem with peripheral
functionality. One was tested directly (we_on related for OneNAND) and
other indirectly (adv_rd(wr)_off on SMSC 9220 for SMSC 91C96).

Reason for doing so was that quirks required to handle these specific
cases could be avoided, otherwise new peripheral timing data would be
required and it would be difficult to achieve DT bindings (when DT
happens) for these kind of fixup timings.

But if this causes any problems (which I don't expect), then we will
have to fallback to the quirks that I wanted to avoid.

> Do you think that there is any value in making the tusb member a "u32
> dev_type" and then set it too GPMC_DEVICE_TUSB then this could be used
> for other devices in the future too if needed?

> Would it be possible to create a sub-function called
> gpmc_calc_timings_tusb() and put all these "if (tusb)" statements in
> there? Or maybe a generic function called gpmc_calc_timings_prepare().

Usage of a "tusb" check was something that I really wanted to avoid as
that was making generic timing calculation function peripheral Gnostic.
With the newly posted series, "tusb" field has been removed.

Regards
Afzal
