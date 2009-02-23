From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [rft/rfc/patch-v2.6.29-rc5+ 00/23] ehci cleanup series
Date: Mon, 23 Feb 2009 21:32:22 +0200
Message-ID: <20090223193222.GH31792@frodo>
References: <1235415335-17408-1-git-send-email-me@felipebalbi.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:48726 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752695AbZBWTcl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Feb 2009 14:32:41 -0500
Content-Disposition: inline
In-Reply-To: <1235415335-17408-1-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: linux-omap@vger.kernel.org, Steve Sakoman <steve@sakoman.com>, Anand Gadiyar <gadiyar@ti.com>

On Mon, Feb 23, 2009 at 08:55:12PM +0200, Felipe Balbi wrote:
> Hi all,
> 
> Please give the following patches a good test. I don't have
> hw to test them so any comments will be really welcome.
> 
> We still have lots to do before getting this driver upstream,
> let's try to keep track of our TODO list and get this driver in
> mainline for 2.6.31 merge window (2.6.30 is too close already).
> 
> Let's not try to push this driver until ES2.x and ES3.x are fully
> supported, that will probably have to be done by an omap_rev
> check in ehci-omap driver, also, this driver doesn't really
> enumerate any attached devices, but that's old problem as Tony
> told me off list.
> 
> Anyways, I guess this driver is finally walking. Me and Anand (and anyone
> interested) will be discussing how to get EHCI and OHCI working fine, I'm
> guessing we won't have really big issues with OHCI but you never know.
> 
> Again, please give it a good test, see if you don't have any clock issues,
> NULL pointers, check if the error path is really fine, see if VBUS turns on
> or not, as I said, *I HAVE NO HW TO TEST THESE*
> 
> thanks in advance for those who will read/test/comment these patches

btw, rebase version of these patches are at:

git://gitorious.org/musb/mainline.git branch ehci

-- 
balbi
