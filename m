From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: status of USB on omap35xx ?
Date: Wed, 10 Dec 2008 21:01:01 +0200
Message-ID: <20081210190100.GF9799@frodo>
References: <1228870250.32014.148.camel@localhost.localdomain> <1228926833.32014.162.camel@localhost.localdomain> <20081210174030.GD9799@frodo> <200812101028.25235.david-b@pacbell.net>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:58446 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755746AbYLJTBK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Dec 2008 14:01:10 -0500
Content-Disposition: inline
In-Reply-To: <200812101028.25235.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: me@felipebalbi.com, Jeff Steele <jsteele@coloradocollege.edu>, linux-omap <linux-omap@vger.kernel.org>

On Wed, Dec 10, 2008 at 10:28:25AM -0800, David Brownell wrote:
> I don't know the details, but the big problem with EHCI
> on OMAP3 is evidently some kind of silicon issue that
> shows up through the transceiver hookup and prevents the
> link from being reliable.  I'm told that some boards using
> that without a transceiver -- for on-board communication,
> not for an external link -- have been successful.
> 
> Folk at TI were looking at those issues; I don't know if
> they've been resolved yet, e.g. in the ES 3.0 silicon.

Oh yeah, that's right. There was some pin-incompatibility with ohci
which prevented port handoffs to be done reliably, or something like
that.

If I'm not wrong, once the port is handed over to ohci, it can never
switch back to ehci and it dies.

Can't really remember if this is the right issue since I haven't been
working too much with ehci :-p

-- 
balbi
