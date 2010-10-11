From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: RE: [PATCH v4] ARM: Fix sparse warnings due to variables conflicts.
Date: Mon, 11 Oct 2010 11:15:53 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB030CFC4DEB@dbde02.ent.ti.com>
References: <1286517186-29934-1-git-send-email-sourav.poddar@ti.com>
 <4CAF014D.7000909@ti.com> <20101008232237.GC10975@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57422 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751340Ab0JKFqJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Oct 2010 01:46:09 -0400
In-Reply-To: <20101008232237.GC10975@n2100.arm.linux.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, "Menon, Nishanth" <nm@ti.com>
Cc: "Poddar, Sourav" <sourav.poddar@ti.com>, "G, Manjunath Kondaiah" <manjugk@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

 

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk] 
> Sent: Saturday, October 09, 2010 4:53 AM
> To: Menon, Nishanth
> Cc: Poddar, Sourav; G, Manjunath Kondaiah; 
> linux-omap@vger.kernel.org; Shilimkar, Santosh; 
> linux-arm-kernel@lists.infradead.org; Varadarajan, Charulatha
> Subject: Re: [PATCH v4] ARM: Fix sparse warnings due to 
> variables conflicts.
> 
> On Fri, Oct 08, 2010 at 06:32:29AM -0500, Nishanth Menon wrote:
> > Poddar, Sourav had written, on 10/08/2010 12:53 AM, the following:
> >> Fix the sparse warnings generated due to conflicts in 
> variables used in readl/writel.
> >>
> >>
> >> drivers/net/smc91x.c:312:8: warning: symbol '__v' shadows 
> an earlier one
> >> drivers/net/smc91x.c:312:8: originally declared here
> >>
> >> With this change, about 200 sparse warnings are fixed.
> > The commit message could be a little more detailed.
> > see http://marc.info/?l=linux-omap&m=128648102511076&w=2
> >
> > also should $subject say ARM: io: fix namespace conflict
> > to better reflect the fix? sparse warnings are just an 
> indication IMHO

That sounds more appropriate. Thanks.

> 
> afaics, this patch will cause checkpatch to issue warnings 
> due to lines
> over 80 characters.

Okay. The patch was not touching the coding style of how the
macros were defined earlier. Anyways, would fix the warnings
and send the patch asap.

> 
> I can't check that because I don't have the original patch via the
> linux-arm-kernel mailing list.
> 