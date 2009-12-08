From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 1/2] OMAP3: Enable DSS2 for OMAP3EVM board
Date: Tue, 8 Dec 2009 14:15:13 -0600
Message-ID: <20091208201513.GA5491@lixom.net>
References: <hvaibhav@ti.com> <1256724210-20581-1-git-send-email-hvaibhav@ti.com> <19F8576C6E063C45BE387C64729E73940436EEAD77@dbde02.ent.ti.com> <20091110010905.GR23952@atomide.com> <19F8576C6E063C45BE387C64729E73940436F94084@dbde02.ent.ti.com> <1257847956.2400.62.camel@tubuntu.research.nokia.com> <19F8576C6E063C45BE387C64729E739404372105C9@dbde02.ent.ti.com> <20091208200242.GA4954@lixom.net> <19F8576C6E063C45BE387C64729E739404372105DA@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from lixom.net ([66.141.50.11]:54943 "EHLO mail.lixom.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965977AbZLHUMQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 Dec 2009 15:12:16 -0500
Content-Disposition: inline
In-Reply-To: <19F8576C6E063C45BE387C64729E739404372105DA@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, Dec 09, 2009 at 01:36:57AM +0530, Hiremath, Vaibhav wrote:

> [Hiremath, Vaibhav] I understand, but if we put the patches on master for whatever period of time available, people can try and validate it.
> 
> Some people are forward porting the patches (earlier versions submitted) or pinging me for the patches. Let DSS2 alone go in the first slot. Can we use it as a staging here?

In a perfect world Tomi would have the staging branch in his tree since
he is the maintainer, and Tony would merge that into his master branch
for testing.

I've been pinging Tomi about my DSS2 patch off-list and he seems to be
waiting for DSS2 to be merged before touching any other code, which is
a little confusing to me but he's free to run it the way he sees fit.


-Olof
