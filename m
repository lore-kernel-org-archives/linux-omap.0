From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 00/23] twl4030 patches (v3)
Date: Tue, 30 Sep 2008 00:04:10 +0300
Message-ID: <20080929210408.GI2445@frodo>
References: <1222705669-18230-1-git-send-email-me@felipebalbi.com> <200809291359.34589.david-b@pacbell.net>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:52291 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751713AbYI2VEZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Sep 2008 17:04:25 -0400
Content-Disposition: inline
In-Reply-To: <200809291359.34589.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Felipe Balbi <me@felipebalbi.com>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>

On Mon, Sep 29, 2008 at 01:59:34PM -0700, David Brownell wrote:
> Well I can confirm that this is stuff I've seen to behave OK,
> by diffing the patches against known-working versions.  There
> were Overo differences, and some keymap things.
> 
> Patch 0002 (don't zero pullup/pulldown configuration) is still
> missing the ACK I sent when it first came though.  :)

Damn... i might have missed it when moving the patches around work and
home :-p

Will re-add it.

> On the other hand, building against the tarball of patches
> you sent gives me:

Steve also saw that, it's already fixed :-)

-- 
balbi
