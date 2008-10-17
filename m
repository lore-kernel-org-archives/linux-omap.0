From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: Re: [PATCH 5/6] Generic twl4030 power script for 3430 based boards.
Date: Fri, 17 Oct 2008 12:10:01 +0300
Message-ID: <20081017091001.GA4637@codecarver.research.nokia.com>
References: <1224077854-23481-1-git-send-email-peter.de-schrijver@nokia.com> <1224077854-23481-5-git-send-email-peter.de-schrijver@nokia.com> <1224077854-23481-6-git-send-email-peter.de-schrijver@nokia.com> <200810161609.47835.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:37132 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752062AbYJQJKX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Oct 2008 05:10:23 -0400
Content-Disposition: inline
In-Reply-To: <200810161609.47835.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org

On Thu, Oct 16, 2008 at 04:09:47PM -0700, ext David Brownell wrote:
> On Wednesday 15 October 2008, Peter 'p2' De Schrijver wrote:
> > --- /dev/null
> > +++ b/arch/arm/mach-omap2/twl4030-generic-scripts.h
> > @@ -0,0 +1,8 @@
> > +#ifndef __TWL4030_GENERIC_SCRIPTS_H
> > +#define __TWL4030_GENERIC_SCRIPTS_H
> > +
> > +#include <linux/i2c/twl4030.h>
> > +
> > +extern struct twl4030_power_data generic3430_t2scripts_data;
> > +
> > +#endif
> 
> I'd still put this decl into arch/arm/mach-omap2/pm.h, which
> is already a bit of a grab-bag of PM hooks.  As you noted,
> having a header for a single declaration isn't the Best Way.

In retrospect I don't think that's such a good idea either. pm.h
contains prototypes related to OMAP2/3 powermanagement. Even though
twl4030 plays some role in powermanagement, it's more at the system
level then at the OMAP chip level. Ie. from an OMAP point of view
nothing has to be switched off. But from a system point of view, it does
save some power to switch things off. So I don't feel it belongs there.

Cheers,

Peter.

-- 
goa is a state of mind
