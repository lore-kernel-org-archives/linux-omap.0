From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH-V2] OMAP3EVM:FIX: Reset the smsc911x ethernet controller
 in board_init
Date: Sat, 29 Jan 2011 17:41:30 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739404BD7BEB5C@dbde02.ent.ti.com>
References: <1295968956-10166-1-git-send-email-hvaibhav@ti.com>
	<19F8576C6E063C45BE387C64729E739404BD7BE3F4@dbde02.ent.ti.com>
 <87d3nikt3j.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37755 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751767Ab1A2MLp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 29 Jan 2011 07:11:45 -0500
In-Reply-To: <87d3nikt3j.fsf@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Varadarajan, Charulatha" <charu@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>


> -----Original Message-----
> From: Hilman, Kevin
> Sent: Friday, January 28, 2011 1:38 AM
> To: Hiremath, Vaibhav
> Cc: linux-omap@vger.kernel.org; Varadarajan, Charulatha; linux-arm-
> kernel@lists.infradead.org
> Subject: Re: [PATCH-V2] OMAP3EVM:FIX: Reset the smsc911x ethernet
> controller in board_init
> 
> "Hiremath, Vaibhav" <hvaibhav@ti.com> writes:
> 
> >> -----Original Message-----
> >> From: Hiremath, Vaibhav
> >> Sent: Tuesday, January 25, 2011 8:53 PM
> >> To: linux-omap@vger.kernel.org
> >> Cc: Hiremath, Vaibhav; Varadarajan, Charulatha
> >> Subject: [PATCH-V2] OMAP3EVM:FIX: Reset the smsc911x ethernet
> controller
> >> in board_init
> >>
> >> With addition of hwmod support to gpio, the ethernet controller
> >> goes undetected for OMAP35xEVM. So explicitly assert the reset signal
> to
> >> ethernet controller smsc911x -
> >>
> >> 	- GPIO7 (>=RevG version of EVM's)
> >> 	- GPIO64 (<=RevD version of EVM's)
> >>
> >> This patch is based on intial version from Charulatha V, reference
> >> to original discussion -
> >> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg35784.html
> >> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> >> Signed-off-by: Charulatha V <charu@ti.com>
> >> Tested-by: Kevin Hilman <khilman@ti.com>
> >> ---
> >> Since Kevin reported that this patch doesn't get applied cleanly,
> >> so I am reposting it again after making sure that it gets applied
> cleanly.
> >>
> > [Hiremath, Vaibhav] Oops, missed linux-arm-kernel list, adding here.
> >
> > Not sure whether I need to repost keeping linux-arm-kernel?
> >
> 
> Also, did you post the smc911x driver fix yet that is needed for testing
> with newer kernels?
> 
[Hiremath, Vaibhav] Not yet. Got completely loaded with some high priority issues. I will try to post it sometime this week.

Thanks,
Vaibhav

> Kevin
