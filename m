From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 2/4] ARM: OMAP4+: PM: Consolidate OMAP4 PM code to
 re-use it for OMAP5
Date: Tue, 9 Apr 2013 09:55:03 -0700
Message-ID: <20130409165503.GM10155@atomide.com>
References: <1365166743-5940-1-git-send-email-santosh.shilimkar@ti.com>
 <1365166743-5940-3-git-send-email-santosh.shilimkar@ti.com>
 <20130405213433.GF10155@atomide.com>
 <5162A093.7090808@ti.com>
 <20130408164228.GK10155@atomide.com>
 <5163B19E.30105@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:29542 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934825Ab3DIQzH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Apr 2013 12:55:07 -0400
Content-Disposition: inline
In-Reply-To: <5163B19E.30105@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: khilman@deeprootsystems.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Santosh Shilimkar <santosh.shilimkar@ti.com> [130408 23:16]:
> > 
> As I said, the IP has been there from OMAP2XX days. Here the case that
> IP version is very similar between OMAP4, OMAP5. DRA(next SOC) and its
> derivatives. Hence can share most of the code. I thought this was good
> enough reason considering at least 4 family of SOC's can make use
> of the code.

Well at least that might be enough of a reasoning to rename it as
it is somewhat futureproof.
 
> It has nothing to do with SMP etc specifically and rather the similarity
> between the PM infrastructure on the mentioned SOCs. 
>
> Let me know if you can suggested better name than what I chose ?

Not really except something like pm-iprevXXX.[chS] where the rev is
the first revision that it works with?

But then again if it's touching registers all over the place directly,
that naming does not make much sense either :)

Regards,

Tony
