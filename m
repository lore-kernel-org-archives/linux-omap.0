From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 08/10] OMAP: split plat-omap/common.c
Date: Tue, 5 Oct 2010 09:07:20 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1010050906540.13816@utopia.booyaka.com>
References: <20101001213119.1408.65395.stgit@twilight.localdomain> <20101001213532.1408.55832.stgit@twilight.localdomain> <4CA999AA.4030608@ti.com> <alpine.DEB.2.00.1010041314170.13816@utopia.booyaka.com> <4CAB0545.5060309@ru.mvista.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:53868 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753574Ab0JEPHV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Oct 2010 11:07:21 -0400
In-Reply-To: <4CAB0545.5060309@ru.mvista.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, 5 Oct 2010, Sergei Shtylyov wrote:

> Hello.
> 
> On 04-10-2010 23:15, Paul Walmsley wrote:
> 
> > > > --- /dev/null
> > > > +++ b/arch/arm/plat-omap/32ksynctimer.c
> > > > @@ -0,0 +1,184 @@
> > > > +/*
> > > > + * linux/arch/arm/plat-omap/clocksource.c
> 
> > > What name do you want to use? 32ksynctimer.c or clocksource.c?
> 
> > Thanks, that's a bug.
> 
>    And also note that filenames in heading comments have been long
> discouraged.

Yeah, I dropped that from the updated patch, that was a pointless attempt 
at consistency with the old code.


- Paul
