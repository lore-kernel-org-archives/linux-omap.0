From: Tony Lindgren <tony@atomide.com>
Subject: Re: Where did the twl4030 battery charging code go?
Date: Thu, 1 Apr 2010 03:16:20 -0700
Message-ID: <20100401101620.GM31200@atomide.com>
References: <738b3f7e1003300859t633ace94h5945e9974109e176@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:63398 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753179Ab0DAKO2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Apr 2010 06:14:28 -0400
Content-Disposition: inline
In-Reply-To: <738b3f7e1003300859t633ace94h5945e9974109e176@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Barada <peter.barada@gmail.com>
Cc: linux-omap@vger.kernel.org

* Peter Barada <peter.barada@gmail.com> [100330 08:55]:
> I'm looking in linux-2.6.33-rc3 to turn on the battery backup charger
> to get the RTC working on a Logic SOM, and I don't see
> drivers/mfd/twl4030_bci_battery.c anymore.
> 
> Digging through Tony's trees I find it was removed way back at::
> 
> http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=commitdiff;h=b122a4b8a18ebbb0b5de90baeb54650a53cd9d7d
> 
> Did this code resurface anywhere in the new kernels?

If it's not in mainline, we don't have it queued anywhere else.
The missing pieces should be sent via the MFD list after the
necessary cleanups.

Regards,

Tony
