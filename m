From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH 1/2] OMAP3: Enable DSS2 for OMAP3EVM board
Date: Wed, 9 Dec 2009 01:48:13 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739404372105DD@dbde02.ent.ti.com>
References: <hvaibhav@ti.com>
 <1256724210-20581-1-git-send-email-hvaibhav@ti.com>
 <19F8576C6E063C45BE387C64729E73940436EEAD77@dbde02.ent.ti.com>
 <20091110010905.GR23952@atomide.com>
 <19F8576C6E063C45BE387C64729E73940436F94084@dbde02.ent.ti.com>
 <1257847956.2400.62.camel@tubuntu.research.nokia.com>
 <19F8576C6E063C45BE387C64729E739404372105C9@dbde02.ent.ti.com>
 <20091208200242.GA4954@lixom.net>
 <19F8576C6E063C45BE387C64729E739404372105DA@dbde02.ent.ti.com>
 <20091208201513.GA5491@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45114 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965997AbZLHUST convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Dec 2009 15:18:19 -0500
In-Reply-To: <20091208201513.GA5491@lixom.net>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> -----Original Message-----
> From: Olof Johansson [mailto:olof@lixom.net]
> Sent: Wednesday, December 09, 2009 1:45 AM
> To: Hiremath, Vaibhav
> Cc: Tomi Valkeinen; Tony Lindgren; linux-omap@vger.kernel.org
> Subject: Re: [PATCH 1/2] OMAP3: Enable DSS2 for OMAP3EVM board
> 
> On Wed, Dec 09, 2009 at 01:36:57AM +0530, Hiremath, Vaibhav wrote:
> 
> > [Hiremath, Vaibhav] I understand, but if we put the patches on
> master for whatever period of time available, people can try and
> validate it.
> >
> > Some people are forward porting the patches (earlier versions
> submitted) or pinging me for the patches. Let DSS2 alone go in the
> first slot. Can we use it as a staging here?
> 
> In a perfect world Tomi would have the staging branch in his tree
> since
> he is the maintainer, and Tony would merge that into his master
> branch
> for testing.
> 
> I've been pinging Tomi about my DSS2 patch off-list and he seems to
> be
> waiting for DSS2 to be merged before touching any other code, which
> is
> a little confusing to me but he's free to run it the way he sees
> fit.
> 
[Hiremath, Vaibhav] Probably because of the amount/size of DSS2 code/patches. 

Thanks,
Vaibhav
> 
> -Olof
