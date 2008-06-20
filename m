From: Felipe Balbi <me@felipebalbi.com>
Subject: RE: FW: [PATCH] suppress needless timer reprogramming {tick-sched.c} -
 test/comment
Date: Fri, 20 Jun 2008 02:45:31 -0500
Message-ID: <f278ad39078f34bbfa6fc95f84411724@felipebalbi.com>
References: <13B9B4C6EF24D648824FF11BE8967162035B9BE166@dlee02.ent.ti.com> <1aa81d795700f751f1a6fb401fcdc73e@felipebalbi.com> <13B9B4C6EF24D648824FF11BE8967162035B9BE9CE@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:36619 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752719AbYFTHpf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Jun 2008 03:45:35 -0400
In-Reply-To: <13B9B4C6EF24D648824FF11BE8967162035B9BE9CE@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: linux-omap@vger.kernel.org, felipe.balbi@nokia.com



On Thu, 19 Jun 2008 17:06:11 -0500, "Woodruff, Richard"
<r-woodruff2@ti.com> wrote:

>> care to send it to my nokia mail?
>> felipe 'dot' balbi 'at' nokia 'dot' com
> 
> Ok.

Thanks for sending them :-)

> Ok.  I did catch Thomas G. on IRC and he indicated it seemed fine and
> would try later after fixing some bugs.

That's great :-)

> Perhaps more exciting would be to make sure x86 didn't care.  My ARM
> targets only work better.

better sending to lkml, then?

I'm pretty sure at least ehci will be positively affected. We could
be getting around 400mbps throughput with ehci (and musb) but last
time I tried I got something around 150mbps.

That was a good catch Richard :-)

-- 
Best Regards,

Felipe Balbi
http://felipebalbi.com
me@felipebalbi.com

