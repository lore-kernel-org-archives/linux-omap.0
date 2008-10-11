From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 3/7] Twl4030 power code updated for new twl4030 core
Date: Sat, 11 Oct 2008 21:49:11 +0300
Message-ID: <20081011184910.GC20247@frodo>
References: <1223657776-16544-1-git-send-email-peter.de-schrijver@nokia.com> <1223657776-16544-2-git-send-email-peter.de-schrijver@nokia.com> <1223657776-16544-3-git-send-email-peter.de-schrijver@nokia.com> <1223657776-16544-4-git-send-email-peter.de-schrijver@nokia.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:49940 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754117AbYJKStS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 11 Oct 2008 14:49:18 -0400
Content-Disposition: inline
In-Reply-To: <1223657776-16544-4-git-send-email-peter.de-schrijver@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
Cc: linux-omap@vger.kernel.org

On Fri, Oct 10, 2008 at 07:56:12PM +0300, Peter 'p2' De Schrijver wrote:
> This patch adds the twl4030 power handling. It downloads the scripts provided
> by the board configuration to the twl4030 and configures the chip to call
> the relevant script for each event (processor group 1 and 2 sleep,
> processor group 3 sleep, wakeup or warm reset).
> 
> Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>

Looking now I'd say patches 1 - 3 could be one. And generate use the -C
flag from git format-patch so we can see what really changed in the
process.

-- 
balbi
