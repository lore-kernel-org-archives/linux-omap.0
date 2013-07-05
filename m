From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: OMAP baseline test results for v3.10-rc6
Date: Fri, 5 Jul 2013 11:18:44 +0530
Message-ID: <51D65E3C.1070202@ti.com>
References: <alpine.DEB.2.02.1306170521020.9909@utopia.booyaka.com> <20130625160243.GE22312@arwen.pp.htv.fi> <alpine.DEB.2.02.1306251746060.14373@utopia.booyaka.com> <51C9F0A8.1050607@ti.com> <87fvw6t136.fsf@linaro.org> <79CD15C6BA57404B839C016229A409A83ECC952D@DBDE04.ent.ti.com> <51CAEB33.5010101@ti.com> <alpine.DEB.2.02.1306261722520.6135@utopia.booyaka.com> <51CBBCD8.5030600@ti.com> <alpine.DEB.2.02.1306281844090.8767@utopia.booyaka.com> <alpine.DEB.2.02.1307010211580.3741@utopia.booyaka.com> <79CD15C6BA57404B839C016229A409A83ECCC435@DBDE04.ent.ti.com> <51D2E096.5040700@ti.com> <alpine.DEB.2.02.1307031944580.9618@utopia.booyaka.com> <alpine.DEB.2.02.1307041810410.6258@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41346 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751998Ab3GEFtQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 5 Jul 2013 01:49:16 -0400
In-Reply-To: <alpine.DEB.2.02.1307041810410.6258@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Nishanth Menon <nm@ti.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, "Vutla, Lokesh" <lokeshvutla@ti.com>, Kevin Hilman <khilman@linaro.org>, "Rini, Tom" <trini@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Balbi, Felipe" <balbi@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thursday 04 July 2013 11:42 PM, Paul Walmsley wrote:
> On Wed, 3 Jul 2013, Paul Walmsley wrote:
> 
>> As far as Lokesh's patch goes: it doesn't make sense to me to remove a 
>> file during 'make clean' that the build process doesn't create.  So while 
>> I understand the motivation for the patch, and don't mind if upstream 
>> takes it, I personally wouldn't care to ack it.
> 
> Incidentally, if there's any patch that would improve the current 
> situation with appended DTBs by going upstream, it would be a patch like 
> Grant's "HACK" patch to add appended DTB building into the kernel build 
> system.  Maybe folks can push to something similar to that one upstream?

Grant already made it clear when he posted that patch that neither that nor
anything similar would be taken up mainline because the appended dtb was only
meant for folks stuck with legacy bootloaders and have no way to upgrade.
Anyone who uses a bootloader capable of passing the dtb should *not* use the
appended dtb way.

> 
> 
> - Paul
> 

