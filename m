From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/4] mtd: OneNAND: OMAP2: increase multiblock erase
 verify timeout
Date: Fri, 18 Feb 2011 09:34:47 -0800
Message-ID: <20110218173447.GT20795@atomide.com>
References: <1297068421-14430-1-git-send-email-adrian.hunter@nokia.com>
 <1297068421-14430-5-git-send-email-adrian.hunter@nokia.com>
 <20110217234603.GI20795@atomide.com>
 <1298003498.2735.4.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:45503 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753493Ab1BRRe5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Feb 2011 12:34:57 -0500
Content-Disposition: inline
In-Reply-To: <1298003498.2735.4.camel@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Artem Bityutskiy <dedekind1@gmail.com>
Cc: Adrian Hunter <adrian.hunter@nokia.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-mtd Mailing List <linux-mtd@lists.infradead.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, linux-omap Mailing List <linux-omap@vger.kernel.org>

* Artem Bityutskiy <dedekind1@gmail.com> [110217 20:31]:
> Hi,
> 
> On Thu, 2011-02-17 at 15:46 -0800, Tony Lindgren wrote:
> > * Adrian Hunter <adrian.hunter@nokia.com> [110207 00:45]:
> > > From: Roman Tereshonkov <roman.tereshonkov@nokia.com>
> > > 
> > > The current multiblock erase verify read timeout 100us is the maximum
> > > for none-error case. If errors happen during multibock erase then
> > > the specification recommends to run multiblock erase verify command
> > > with maximum timeout 10ms (see specs. for KFM4G16Q2A and KFN8G16Q2A).
> > > 
> > > For the most common non-error case we wait 100us in udelay polling
> > > loop. In case of timeout the interrupt mode is used to wait for the
> > > command end.
> > > 
> > > Signed-off-by: Roman Tereshonkov <roman.tereshonkov@nokia.com>
> > 
> > I'll queue this series. Anybody from MTD list care to ack this patch?
> 
> Acked-by: Artem Bityutskiy <Artem.Bityutskiy@nokia.com>

Thanks!

Tony
