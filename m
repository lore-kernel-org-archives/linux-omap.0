From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 08/10] OMAP: split plat-omap/common.c
Date: Mon, 4 Oct 2010 13:15:25 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1010041314170.13816@utopia.booyaka.com>
References: <20101001213119.1408.65395.stgit@twilight.localdomain> <20101001213532.1408.55832.stgit@twilight.localdomain> <4CA999AA.4030608@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:47496 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752126Ab0JDTP0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Oct 2010 15:15:26 -0400
In-Reply-To: <4CA999AA.4030608@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Mon, 4 Oct 2010, Cousson, Benoit wrote:

> > --- /dev/null
> > +++ b/arch/arm/plat-omap/32ksynctimer.c
> > @@ -0,0 +1,184 @@
> > +/*
> > + * linux/arch/arm/plat-omap/clocksource.c
> 
> What name do you want to use? 32ksynctimer.c or clocksource.c?

Thanks, that's a bug.

> If this file is dedicated for the 32k sync timer, maybe we should now use the
> new OMAP4 name: "counter_32k".
> 
> Noboby knows what the sync stand for, and at the end this is just a 32k
> counter. Hence the new name :-)

Yep, let's use counter_32k.c.


- Paul
