From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap2+: mux: Initialise the static pads.
Date: Fri, 4 Mar 2011 08:28:58 -0800
Message-ID: <20110304162858.GW20560@atomide.com>
References: <1299003360-32120-1-git-send-email-r.sricharan@ti.com>
 <20110304022832.GR20560@atomide.com>
 <44e29d555f2b399b7067d827603897cc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:25571 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751953Ab1CDQ3M (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Mar 2011 11:29:12 -0500
Content-Disposition: inline
In-Reply-To: <44e29d555f2b399b7067d827603897cc@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sricharan R <r.sricharan@ti.com>
Cc: linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>, paul@pswan.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

* Sricharan R <r.sricharan@ti.com> [110304 04:22]:
> 
> I have tested this on the devel-mux(I did not see a devel-mmc branch)

Sorry that was a typo, I meant devel-mux not devel-mmc..
 
> Ok. This works fine for all scenarios.

OK thanks for testing.
 
> A small cleanup change which helps.
...

> I was not able to see the your above patch in the tree and
> I saw only the older patch.

Hmm it's there as commit 93c5f165e10c21a3813a687204388a34072b2a62
in devel-mux branch. Can you please update your patch against
that commit so it's easier to see what your changes are?

BTW, the patch you posted got trashed by your email client
or server..

Regards,

Tony
