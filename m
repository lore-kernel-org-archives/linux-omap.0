From: Michael =?ISO-8859-1?Q?B=FCsch?= <mb@bu3sch.de>
Subject: Re: Nokia n810 LCD (MIPID/blizzard) on 2.6.38
Date: Thu, 10 Mar 2011 06:49:46 +0100
Message-ID: <1299736186.10251.3.camel@maggie>
References: <1298925943.16391.19.camel@marge>
	 <alpine.DEB.2.00.1103091807050.15132@utopia.booyaka.com>
	 (sfid-20110310_021859_499343_FFFFFFFF9C481C65)
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 80-190-117-144.ip-home.de ([80.190.117.144]:60284 "EHLO
	bu3sch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750699Ab1CJFtx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Mar 2011 00:49:53 -0500
In-Reply-To: <alpine.DEB.2.00.1103091807050.15132@utopia.booyaka.com> (sfid-20110310_021859_499343_FFFFFFFF9C481C65)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, Varadarajan Charulatha <charu@ti.com>

On Wed, 2011-03-09 at 18:18 -0700, Paul Walmsley wrote: 
> Perhaps this patch will do:
> 
>    http://marc.info/?l=linux-omap&m=129971920806386&w=2
> 
> Afterwards, it should be possible to look up the GPIO1 hwmod in 
> mach-omap2/board-n8x0.c after the call to 
> omap2_init_common_infrastructure(), and then to call 
> omap_hwmod_no_setup_reset() on it.  Perhaps you might wish to try it?

Yep, this looks like the short-term fix I was looking for.

We're still working on a possible long-term fix by fixing up
the blizzard driver, but that will eventually take some time, if
we finally get it sorted out...

-- 
Greetings Michael.

