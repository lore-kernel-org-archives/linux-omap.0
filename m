From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP 3630 random crashes
Date: Mon, 23 Jun 2014 01:35:12 -0700
Message-ID: <20140623083512.GC28884@atomide.com>
References: <1403254242990.39117@grundfos.com>
 <20140620091431.GA28884@atomide.com>
 <1403272840480.35753@grundfos.com>
 <CAK8F28=pF=gy10Lar35q2-s=f0TxNJFZ6XpdTFvHYankXtzH4Q@mail.gmail.com>
 <1403274413159.44797@grundfos.com>
 <1403503623834.68421@grundfos.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:26005 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751823AbaFWIfO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Jun 2014 04:35:14 -0400
Content-Disposition: inline
In-Reply-To: <1403503623834.68421@grundfos.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Casper Lyngesen Mogensen <clmogensen@grundfos.com>
Cc: Ash Charles <ash@gumstix.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Casper Lyngesen Mogensen <clmogensen@grundfos.com> [140622 23:08]:
> Hi again
> 
> All my boards are marked "JW513". So the problem might be hardware related, i will try to get some new Overo's and test on these instead. 

OK, please let us know how it goes.

Also if using armhf based distro some omap3 SoCs need
CONFIG_CPU_BPREDICT_DISABLE=y or CONFIG_ARM_ERRATA_430973=y
or both. Sorry no idea yet which revisions, but I've seen some
flakeyness with apt-get dist-upgrade occasionally failing
on a 3630 with revision info:

CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7), cr=10c5307d

Regards,

Tony
