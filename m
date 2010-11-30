From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH v5 1/1] OMAP2: Spi: Force CS to be in inactive state after off-mode transition
Date: Mon, 29 Nov 2010 19:08:47 -0800 (PST)
Message-ID: <509131.41359.qm@web180304.mail.gq1.yahoo.com>
References: <877hfw1a6a.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nm23.bullet.mail.sp2.yahoo.com ([98.139.91.93]:47486 "HELO
	nm23.bullet.mail.sp2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750826Ab0K3DJ3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Nov 2010 22:09:29 -0500
In-Reply-To: <877hfw1a6a.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>, Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, spi-devel-general@lists.sourceforge.net, Grant Likely <grant.likely@secretlab.ca>

> > Now force CS to be in inactive state only if it was
> inactive when it was suspended.

Note that it's a bug if CS is active in
any suspend state (including OFF).  That
strongly suggests $SUBJECT is an incomplete
workaround for that other bug...

> >
> > When SPI wake up from OFF mode, CS is in the wrong
> state: force it to the inactive state.

Best report the bug that the suspend/OFF state
was mis-handled...  That is, it didn't
correctly ENTER that OFF mode...

In fact ... I'd like to see that fixed more
than the $SUBJECT issue, so the root cause
gets resolved...

CS should only be active while a SPI message
is being processed, and such processing must
have completed before suspend/OFF/... starts


