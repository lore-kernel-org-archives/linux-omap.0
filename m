From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP baseline test results for v3.10-rc6
Date: Fri, 5 Jul 2013 15:44:32 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1307051530290.8573@utopia.booyaka.com>
References: <alpine.DEB.2.02.1306170521020.9909@utopia.booyaka.com> <20130625160243.GE22312@arwen.pp.htv.fi> <alpine.DEB.2.02.1306251746060.14373@utopia.booyaka.com> <51C9F0A8.1050607@ti.com> <87fvw6t136.fsf@linaro.org> <79CD15C6BA57404B839C016229A409A83ECC952D@DBDE04.ent.ti.com>
 <51CAEB33.5010101@ti.com> <alpine.DEB.2.02.1306261722520.6135@utopia.booyaka.com> <51CBBCD8.5030600@ti.com> <alpine.DEB.2.02.1306281844090.8767@utopia.booyaka.com> <alpine.DEB.2.02.1307010211580.3741@utopia.booyaka.com> <79CD15C6BA57404B839C016229A409A83ECCC435@DBDE04.ent.ti.com>
 <51D2E096.5040700@ti.com> <alpine.DEB.2.02.1307031944580.9618@utopia.booyaka.com> <alpine.DEB.2.02.1307041810410.6258@utopia.booyaka.com> <51D65E3C.1070202@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:56824 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751174Ab3GEPod (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Jul 2013 11:44:33 -0400
In-Reply-To: <51D65E3C.1070202@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: Nishanth Menon <nm@ti.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, "Vutla, Lokesh" <lokeshvutla@ti.com>, Kevin Hilman <khilman@linaro.org>, "Rini, Tom" <trini@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Balbi, Felipe" <balbi@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, 5 Jul 2013, Rajendra Nayak wrote:

> Grant already made it clear when he posted that patch that neither that nor
> anything similar would be taken up mainline because the appended dtb was only
> meant for folks stuck with legacy bootloaders and have no way to upgrade.

He's not the final arbiter of what goes into the mainline kernel :-)

> Anyone who uses a bootloader capable of passing the dtb should *not* use
> the appended dtb way.

Look, either the kernel should support appended DTB booting, or it 
shouldn't.  If it shouldn't, then that code should be ripped out of the 
kernel completely, and we tell people 'tough luck'. If it should, then it 
makes sense to help the millions of folks out there with locked 
bootloaders to build and boot new kernels. This half-support that's in the 
kernel now is not good.


- Paul
