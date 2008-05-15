From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 2/3] N810: Don't export camera orientation
Date: Thu, 15 May 2008 11:17:01 +0300
Message-ID: <20080515081701.GA4853@kedavra.cpe.vivax.com.br>
References: <12106946631016-git-send-email-sakari.ailus@nokia.com> <1210694663310-git-send-email-sakari.ailus@nokia.com> <20147cff763adbdb887ad31373040efc@felipebalbi.com> <482AD555.40905@nokia.com> <20080514225823.GF1582@kedavra.cpe.vivax.com.br> <fb249edb0805142354o2060cf43xd98e6d3e64806a74@mail.gmail.com> <20080515075723.GA4625@kedavra.cpe.vivax.com.br> <fb249edb0805150111q35922041tb9247c5f78ebe622@mail.gmail.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:38909 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752860AbYEOIQN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 May 2008 04:16:13 -0400
Content-Disposition: inline
In-Reply-To: <fb249edb0805150111q35922041tb9247c5f78ebe622@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: andrzej zaborowski <balrogg@gmail.com>
Cc: me@felipebalbi.com, Sakari Ailus <sakari.ailus@nokia.com>, linux-omap@vger.kernel.org

On Thu, May 15, 2008 at 10:11:59AM +0200, andrzej zaborowski wrote:
> This doesn't change anything - since machine_is_... is not constant,
> the whole expression is not constant and is a syntax error.  The
> compiler needs to know at compile time whether to store a 0 or a 1 in
> the initialiser.

ugh, that's true :-p
forget about it.

-- 
Best Regards,

Felipe Balbi
me@felipebalbi.com
http://blog.felipebalbi.com
