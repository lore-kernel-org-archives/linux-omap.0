From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: Warn about deprecated legacy booting mode
Date: Sun, 2 Nov 2014 10:15:18 -0800
Message-ID: <20141102181518.GJ31454@atomide.com>
References: <20141027200008.GR2560@atomide.com>
 <20141031193057.GC12379@n2100.arm.linux.org.uk>
 <20141031211325.GC31454@atomide.com>
 <20141031223332.GD12379@n2100.arm.linux.org.uk>
 <20141031233722.GE31454@atomide.com>
 <20141101004451.GE12379@n2100.arm.linux.org.uk>
 <20141101215745.GF31454@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:63942 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751155AbaKBSQ3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 2 Nov 2014 13:16:29 -0500
Content-Disposition: inline
In-Reply-To: <20141101215745.GF31454@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>

* Tony Lindgren <tony@atomide.com> [141101 15:00]:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [141031 17:46]:
>  
> > However, these are minor compared to the dreadful poweroff behaviour.
> > Still going to have to disable DT booting for the LDP because of that.
> 
> Sure, I'll let you know as soon as I have something available
> for the PMIC powerdown issue.

OK found the problem. The PMIC power transition register needs to
have charger and VBUS bits disabled to prevent immediate reboot
on powerdown for some boards.

Fix posted as "mfd: twl4030-power: Fix poweroff with PM configuration
enabled":

https://lkml.org/lkml/2014/11/2/114

Regards,

Tony
