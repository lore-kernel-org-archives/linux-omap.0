From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: Git tree updated to v2.6.27-rc5, some USB diffs still lurking
Date: Thu, 4 Sep 2008 02:55:43 +0300
Message-ID: <20080903235541.GE6693@frodo>
References: <20080903221218.GD23085@atomide.com> <20080903232754.GR19980@flint.arm.linux.org.uk> <20080903235223.GI23085@atomide.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:37158 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751687AbYICX4E (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Sep 2008 19:56:04 -0400
Content-Disposition: inline
In-Reply-To: <20080903235223.GI23085@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, David Brownell <david-b@pacbell.net>, Felipe Balbi <felipe.balbi@nokia.com>, Vikram Pandita <vikram.pandita@ti.com>, Nishant Kamat <nskamat@ti.com>

On Wed, Sep 03, 2008 at 04:52:25PM -0700, Tony Lindgren wrote:
> OK, fixed for l-o tree. Felipe has the include fixes patch in Greg's
> queue, but looks like that needs updating too. Felipe, can you take
> care of that?

Yeah, I had a missing change in tusb6010_omap.c for which I have already
sent the patch. Asked Greg to meld in the previous musb patch.

If you were talking about anything else, please point out ;-)

-- 
balbi
