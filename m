From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: Fix selection of clockevent timer when
 using device-tree
Date: Fri, 1 Feb 2013 14:44:54 -0800
Message-ID: <20130201224453.GF22517@atomide.com>
References: <1359490991-17688-1-git-send-email-jon-hunter@ti.com>
 <B5906170F1614E41A8A28DE3B8D121433ED03931@DBDE01.ent.ti.com>
 <51095D85.6080204@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:20086 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756741Ab3BAWoz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Feb 2013 17:44:55 -0500
Content-Disposition: inline
In-Reply-To: <51095D85.6080204@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

* Jon Hunter <jon-hunter@ti.com> [130130 09:54]:
> 
> On 01/30/2013 01:18 AM, Bedia, Vaibhav wrote:
> > On Wed, Jan 30, 2013 at 01:53:11, Hunter, Jon wrote:
> >> Commit 9725f44 (ARM: OMAP: Add DT support for timer driver) added
> >> device-tree support for selecting a clockevent timer by property.
> >> However, the code is currently ignoring the property passed and
> >> selecting the first available timer found. Hence, for the OMAP3 beagle
> >> board timer-12 is not being selected as expected. Fix this problem
> >> by ensuring the timer property is passed to omap_get_timer_dt().
> > 
> > I thought that was intentional ;) and had this change in the clkevt-clksrc
> > interchange patch for AM33xx.
> 
> No definitely was not. Thanks, I had missed that detail in the patch you
> sent!
> 
> > Anyways, this change works for me so...
> > 
> > Tested-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
> 
> Thanks!

Thanks applying into omap-for-v3.9/fixes-non-critical.

Tony
