From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH] i2c: change twl4030-usb back to subsys_initcall
Date: Sat, 4 Oct 2008 02:48:30 +0300
Message-ID: <20081003234827.GG10743@frodo>
References: <200810030136.33838.david-b@pacbell.net> <1223027154-20385-1-git-send-email-felipe.balbi@nokia.com> <e5e6ade50810031305x7037644crbd22fcf8d5507395@mail.gmail.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:35367 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753504AbYJCXtA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Oct 2008 19:49:00 -0400
Content-Disposition: inline
In-Reply-To: <e5e6ade50810031305x7037644crbd22fcf8d5507395@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nathan Monson <nmonson@gmail.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org

On Fri, Oct 03, 2008 at 01:05:14PM -0700, Nathan Monson wrote:
> On Fri, Oct 3, 2008 at 2:45 AM, Felipe Balbi <felipe.balbi@nokia.com> wrote:
> > without it, otg_get/set_transceiver won't be useful and
> > twl4030-usb transceiver won't get to musb code.
> >
> > +subsys_init(twl4030_usb_init);
> 
> Should this be subsys_initcall?

Crap... good catch. Sorry for that. new one coming.

-- 
balbi
