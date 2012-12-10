From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP2+: timer: remove CONFIG_OMAP_32K_TIMER
Date: Mon, 10 Dec 2012 20:49:11 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1212102047170.1982@utopia.booyaka.com>
References: <1352299344-8011-1-git-send-email-grinberg@compulab.co.il> <509AD478.1050904@ti.com> <509B666F.6080507@compulab.co.il> <509BDAF5.1010703@ti.com> <79CD15C6BA57404B839C016229A409A83EB68589@DBDE01.ent.ti.com> <509BEE6D.9000902@ti.com>
 <alpine.DEB.2.00.1211081754390.20703@utopia.booyaka.com> <509BF525.80309@ti.com> <alpine.DEB.2.00.1211081809470.20703@utopia.booyaka.com> <509BFB4E.2090802@ti.com> <509F8D6B.5070504@compulab.co.il>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:43867 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752278Ab2LJUtM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Dec 2012 15:49:12 -0500
In-Reply-To: <509F8D6B.5070504@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: Jon Hunter <jon-hunter@ti.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, Tony Lindgren <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, mturquette@linaro.org

On Sun, 11 Nov 2012, Igor Grinberg wrote:

> Yep, but the /800 do not get you the 32768...
> and that makes the timer suck.
> Of course this can be dealt with in the clock subsystem
> (I remember Paul said that he will look into that), but it will take time.

It should be possible to implement this now that the CCF conversion is 
done.  Not sure if I'll be able to get to it soon, though.

Is there anyone out there at TI who is focused on AM3517/3505 upstream 
work?


- Paul
