From: Paul Walmsley <paul@pwsan.com>
Subject: Re: DSS2/PM on 3.2 broken?
Date: Wed, 11 Jan 2012 06:43:04 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1201110632100.31702@utopia.booyaka.com>
References: <WC20120109124643.880164@terrafix.co.uk> <20120110080849.5a242adf@notabene.brown>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:47399 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755726Ab2AKNnF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Jan 2012 08:43:05 -0500
In-Reply-To: <20120110080849.5a242adf@notabene.brown>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Joe Woodward <jw@terrafix.co.uk>, khilman@ti.com, linux-omap@vger.kernel.org

cc Kevin

On Tue, 10 Jan 2012, NeilBrown wrote:

> It seems that when cpuidle on an omap3 tries to switch to lower power
> states, various things misbehave:
>  - UARTs lose characters

Is this with off-mode enabled, or is this with only retention idle 
enabled?

If off-mode is enabled, and incoming serial traffic is used to wake the 
system, it's known and expected that the first byte will be lost.  This is 
an artifact of the hardware and seems to be unavoidable.

>  - dss loses sync

Best to take this up with the DSS maintainer directly.

>  - HDQ seems to lose everything.

Is this with off-mode enabled, or just with retention idle?

If the former, this is hardly surprising as the HDQ driver 
(drivers/w1/masters/omap_hdq.c) doesn't contain any context save/restore 
code.  In fact the HDQ driver doesn't even use PM runtime, so quite a bit 
of work is needed there. 


- Paul
