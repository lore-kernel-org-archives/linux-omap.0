From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 1/4] power_supply: bq27x00: separate common code
Date: Sun, 19 Oct 2008 03:53:16 +0400
Message-ID: <20081018235316.GA7105@oksana.dev.rtsoft.ru>
References: <1224277248-17021-1-git-send-email-felipe.balbi@nokia.com> <1224277248-17021-2-git-send-email-felipe.balbi@nokia.com> <20081018213600.GB1272@oksana.dev.rtsoft.ru> <20081018222949.GU31842@frodo>
Reply-To: avorontsov@ru.mvista.com
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rtsoft3.corbina.net ([85.21.88.6]:18527 "EHLO
	buildserver.ru.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751798AbYJRXxR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 18 Oct 2008 19:53:17 -0400
Content-Disposition: inline
In-Reply-To: <20081018222949.GU31842@frodo>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org, Anton Vorontsov <cbou@mail.ru>, David Woodhouse <dwmw2@infradead.org>

On Sun, Oct 19, 2008 at 01:29:50AM +0300, Felipe Balbi wrote:
[...]
> > > +#include "bq27x00.h"
> > > +
> > > +unsigned int cache_time = 60000;
> > 
> > I think it should be static, no?
> > 
> > > +module_param(cache_time, uint, 0644);
> > > +MODULE_PARM_DESC(cache_time, "cache time in milliseconds");
> > > +
> > > +enum power_supply_property bq27x00_props[] = {
> > 
> > static?
> 
> no, it's used by bq27200.c and bq27000.c

I don't see where. The only user is bq27x00_powersupply_init(),
which is in the same file (bq27x00.c).

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
