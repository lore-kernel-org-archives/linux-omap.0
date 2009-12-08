From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH 1/2] OMAP3: Enable DSS2 for OMAP3EVM board
Date: Wed, 9 Dec 2009 01:36:57 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739404372105DA@dbde02.ent.ti.com>
References: <hvaibhav@ti.com>
 <1256724210-20581-1-git-send-email-hvaibhav@ti.com>
 <19F8576C6E063C45BE387C64729E73940436EEAD77@dbde02.ent.ti.com>
 <20091110010905.GR23952@atomide.com>
 <19F8576C6E063C45BE387C64729E73940436F94084@dbde02.ent.ti.com>
 <1257847956.2400.62.camel@tubuntu.research.nokia.com>
 <19F8576C6E063C45BE387C64729E739404372105C9@dbde02.ent.ti.com>
 <20091208200242.GA4954@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44211 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965957AbZLHUHH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Dec 2009 15:07:07 -0500
In-Reply-To: <20091208200242.GA4954@lixom.net>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> -----Original Message-----
> From: Olof Johansson [mailto:olof@lixom.net]
> Sent: Wednesday, December 09, 2009 1:33 AM
> To: Hiremath, Vaibhav
> Cc: Tomi Valkeinen; Tony Lindgren; linux-omap@vger.kernel.org
> Subject: Re: [PATCH 1/2] OMAP3: Enable DSS2 for OMAP3EVM board
> 
> On Wed, Dec 09, 2009 at 12:19:22AM +0530, Hiremath, Vaibhav wrote:
> 
> > > Wait until DSS2 patches have been merged. I don't want the extra
> > > complexity of board/panel patches, there's enough work with just
> the
> > > half-megabyte DSS patches =).
> > >
> > [Hiremath, Vaibhav] Tomi and Tony,
> >
> > Now since DSS2 has already merged to linux-omap/master, I think
> now we can merge all other dependent patches like,
> >
> > 	- OMAP3EVM support
> > 	- Sharp LQ LCD panel
> > 	- AM3517EVM support
> > 	- V4L2 Driver support
> >
> > Please let me know your opinion on this, so that I can submit it
> to the list.
> 
> linux-omap/master doesn't count. The only place that matters if it's
> made it to Linus' tree.
> 
[Hiremath, Vaibhav] I understand, but if we put the patches on master for whatever period of time available, people can try and validate it.

Some people are forward porting the patches (earlier versions submitted) or pinging me for the patches. Let DSS2 alone go in the first slot. Can we use it as a staging here?

Thanks,
Vaibhav

> Don't get me wrong, I want additional patches on top as well but the
> base work needs to make it _all the way up_.
> 
> 
> 
> -Olof

