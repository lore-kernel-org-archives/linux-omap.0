From: Koen Kooi <koen@dominion.thruhere.net>
Subject: Re: [PATCH] omap3: Add basic support for 720MHz part
Date: Tue, 18 Jan 2011 16:38:01 +0100
Message-ID: <789E54BD-D2B6-4B98-B9B8-19688E415E39@dominion.thruhere.net>
References: <1295336995-15831-1-git-send-email-premi@ti.com>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:62985 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750961Ab1ARPiH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Jan 2011 10:38:07 -0500
Received: by wwa36 with SMTP id 36so6615706wwa.1
        for <linux-omap@vger.kernel.org>; Tue, 18 Jan 2011 07:38:05 -0800 (PST)
In-Reply-To: <1295336995-15831-1-git-send-email-premi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sanjeev Premi <premi@ti.com>
Cc: l-o List <linux-omap@vger.kernel.org>, Nishanth Menon <nm@ti.com>, thara@ti.com


Op 18 jan 2011, om 08:49 heeft Sanjeev Premi het volgende geschreven:

> This patch adds support for new speed enhanced parts with ARM
> and IVA running at 720MHz and 520MHz respectively. These parts
> can be probed at run-time by reading PRODID.SKUID[3:0] at
> 0x4830A20C [1].
> 
> This patch specifically does following:
> * Detect devices capable of 720MHz.
> * Add new OPP
> * Ensure that OPP is conditionally enabled.
> * Check for presence of IVA before attempting to enable
>   the corresponding OPP.

Thanks for the updated patch! 

I'm still having problem using this together with DVFS, the kernel won't scale beyond 600MHz because 600MHz and 720MHz share the same voltage. Thara, Nishant, do you have any suggestions on how to convince the kernel that 2 frequencies can share the same voltage settings? 

If that isn't possible, should we lower the voltages for the lower opps when detecting a 720MHz capable SoC? It would make sense that if 720MHz works at X volt that 600MHz would work at less  than X volt. (I don't have a PDF reader at hand to check the TRM at the moment).

Complete tree at http://dominion.thruhere.net/git/cgit.cgi/linux-omap/log/?h=koen/beagle-next but this can be reproduced as well by merging Thara's dvfs branch and applying Sanjeevs patch.

regards,

Koen