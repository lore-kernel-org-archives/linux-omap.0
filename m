From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: Fix selection of clockevent timer when using
 device-tree
Date: Wed, 30 Jan 2013 11:51:01 -0600
Message-ID: <51095D85.6080204@ti.com>
References: <1359490991-17688-1-git-send-email-jon-hunter@ti.com> <B5906170F1614E41A8A28DE3B8D121433ED03931@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52520 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751760Ab3A3RvF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 30 Jan 2013 12:51:05 -0500
In-Reply-To: <B5906170F1614E41A8A28DE3B8D121433ED03931@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>


On 01/30/2013 01:18 AM, Bedia, Vaibhav wrote:
> On Wed, Jan 30, 2013 at 01:53:11, Hunter, Jon wrote:
>> Commit 9725f44 (ARM: OMAP: Add DT support for timer driver) added
>> device-tree support for selecting a clockevent timer by property.
>> However, the code is currently ignoring the property passed and
>> selecting the first available timer found. Hence, for the OMAP3 beagle
>> board timer-12 is not being selected as expected. Fix this problem
>> by ensuring the timer property is passed to omap_get_timer_dt().
> 
> I thought that was intentional ;) and had this change in the clkevt-clksrc
> interchange patch for AM33xx.

No definitely was not. Thanks, I had missed that detail in the patch you
sent!

> Anyways, this change works for me so...
> 
> Tested-by: Vaibhav Bedia <vaibhav.bedia@ti.com>

Thanks!
Jon
