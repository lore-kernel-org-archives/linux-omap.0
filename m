From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 1/2] OMAP3: Enable DSS2 for OMAP3EVM board
Date: Tue, 8 Dec 2009 14:02:42 -0600
Message-ID: <20091208200242.GA4954@lixom.net>
References: <hvaibhav@ti.com> <1256724210-20581-1-git-send-email-hvaibhav@ti.com> <19F8576C6E063C45BE387C64729E73940436EEAD77@dbde02.ent.ti.com> <20091110010905.GR23952@atomide.com> <19F8576C6E063C45BE387C64729E73940436F94084@dbde02.ent.ti.com> <1257847956.2400.62.camel@tubuntu.research.nokia.com> <19F8576C6E063C45BE387C64729E739404372105C9@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from lixom.net ([66.141.50.11]:58925 "EHLO mail.lixom.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756243AbZLHT7p (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 Dec 2009 14:59:45 -0500
Content-Disposition: inline
In-Reply-To: <19F8576C6E063C45BE387C64729E739404372105C9@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, Dec 09, 2009 at 12:19:22AM +0530, Hiremath, Vaibhav wrote:

> > Wait until DSS2 patches have been merged. I don't want the extra
> > complexity of board/panel patches, there's enough work with just the
> > half-megabyte DSS patches =).
> > 
> [Hiremath, Vaibhav] Tomi and Tony,
> 
> Now since DSS2 has already merged to linux-omap/master, I think now we can merge all other dependent patches like,
> 
> 	- OMAP3EVM support
> 	- Sharp LQ LCD panel
> 	- AM3517EVM support
> 	- V4L2 Driver support
> 
> Please let me know your opinion on this, so that I can submit it to the list.

linux-omap/master doesn't count. The only place that matters if it's
made it to Linus' tree.

Don't get me wrong, I want additional patches on top as well but the
base work needs to make it _all the way up_.



-Olof

