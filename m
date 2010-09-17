From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH] omap3: Prevent SDRC deadlock when L3 is changing
 frequency
Date: Thu, 16 Sep 2010 19:05:55 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE896716203D6F095D9@dlee02.ent.ti.com>
References: <1279728155-2643-1-git-send-email-jon-hunter@ti.com>
 <alpine.DEB.2.00.1009151300190.458@utopia.booyaka.com>
 <20100915224007.GJ4174@atomide.com>
 <alpine.DEB.2.00.1009151707370.458@utopia.booyaka.com>
 <AANLkTimC7_pGag4e+Q0fasP=mdsug8xrU95UJLKOJHvf@mail.gmail.com>
 <20100916185743.GJ29610@atomide.com>
 <AANLkTinXdow4tzmwpx6nRe5VCN5Q8_aKz9EibxKinWWO@mail.gmail.com>
 <20100916204935.GP29610@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52708 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754798Ab0IQAGA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Sep 2010 20:06:00 -0400
In-Reply-To: <20100916204935.GP29610@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, "Gadiyar, Anand" <gadiyar@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, "Hunter, Jon" <jon-hunter@ti.com>, linux-omap <linux-omap@vger.kernel.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>


> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Tony Lindgren
> Sent: Thursday, September 16, 2010 3:50 PM

> Sounds fair. But it might be worth checking that you guys have a system
> in place for collecting omap specific fixes and promptly merging them
> upstream to the mainline tree.

Many times there will be lag.  In many cases the customer has written significant code.  Until they publish this code or publicly post it for review its not something TI should not repost as is.

I think many of the engineers do see the benefit of sharing. However, if they don't have a policy in place which allows them to post until after the production is released it won't happen early.

Anymore, I like to advise a customer's team that it is ok to post patches for RFC even if they don't have time to follow up or it is against an 'old' kernel.

Once this is done TI and others are free to make use of the info to better the common tree.  The customer who found it will re-use the tree likely and get this plus other benefits.

Its best to get this policy set at project start. Asking near launch may very well be denied.

Regards,
Richard W.

