From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH V2 0/7] ARM: OMAP2+: Add device-tree support for timers
Date: Mon, 8 Oct 2012 14:10:02 -0700
Message-ID: <20121008211001.GH13011@atomide.com>
References: <1347579091-3794-1-git-send-email-jon-hunter@ti.com>
 <505A7E0B.30709@ti.com>
 <20120920235309.GO28835@atomide.com>
 <5063330E.3000203@ti.com>
 <5065F19E.5020708@ti.com>
 <50661B07.1040200@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:17972 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751286Ab2JHVKI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Oct 2012 17:10:08 -0400
Content-Disposition: inline
In-Reply-To: <50661B07.1040200@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Vaibhav Hiremath <hvaibhav@ti.com>, device-tree <devicetree-discuss@lists.ozlabs.org>, Rob Herring <rob.herring@calxeda.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

* Jon Hunter <jon-hunter@ti.com> [120928 14:48]:
> 
> What is interesting is that it is the interrupt test that is failing for
> timers 5-7. Any chance there is a problem with the interrupt mapping? I
> checked the documentation for AM335x and I don't see anything obvious
> that is wrong with the binding unless the documentation itself is wrong.

This could also be caused by some timers not being able to wake up
the system from idle?

Regards,

Tony
