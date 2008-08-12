From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: Git tree updated to v2.6.27-rc2, help needed
Date: Tue, 12 Aug 2008 18:35:54 +0300
Message-ID: <20080812153553.GT7574@frodo>
References: <20080811152620.GO25784@atomide.com> <20080812101332.a321e783.jarkko.nikula@nokia.com> <20080812114446.GG6705@atomide.com> <20080812143119.GL6705@atomide.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:34415 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752055AbYHLPgF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Aug 2008 11:36:05 -0400
Content-Disposition: inline
In-Reply-To: <20080812143119.GL6705@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>, linux-omap@vger.kernel.org, Sakari Ailus <sakari.ailus@nokia.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Eduardo Valentin <edubezval@gmail.com>

On Tue, Aug 12, 2008 at 05:31:20PM +0300, Tony Lindgren wrote:
> For me reverting 0e5194e1a84c219bebbb78f305b7a8eabc4a3656 fixes this.
> Reverting 718fc6cd4db902aa2242a736cc3feb8744a4c71a like Felipe mentioned
> does not help for me with gcc version 4.2.3 (Sourcery G++ Lite
> 2008q1-126).

But still quite weird that it only happens on 24xx. I gcc attributes to
force alignment and make that union transparent, and nothing seems to
help.

Any thoughts from you guys ??

-- 
balbi
