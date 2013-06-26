From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP baseline test results for v3.10-rc6
Date: Wed, 26 Jun 2013 17:28:53 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1306261726280.6135@utopia.booyaka.com>
References: <alpine.DEB.2.02.1306170521020.9909@utopia.booyaka.com> <20130625160243.GE22312@arwen.pp.htv.fi> <alpine.DEB.2.02.1306251746060.14373@utopia.booyaka.com> <51C9F0A8.1050607@ti.com> <87fvw6t136.fsf@linaro.org> <79CD15C6BA57404B839C016229A409A83ECC952D@DBDE04.ent.ti.com>
 <51CAEB33.5010101@ti.com> <51CAEBF3.1010507@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:53602 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751841Ab3FZR2y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Jun 2013 13:28:54 -0400
In-Reply-To: <51CAEBF3.1010507@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tom Rini <trini@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, Kevin Hilman <khilman@linaro.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Balbi, Felipe" <balbi@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Wed, 26 Jun 2013, Tom Rini wrote:

> Yes, please confirm that they're being set.

For the Kconfig that I use to boot the BeagleBone-white, which is called 
"am33xx_only", yes, both of those are set.  

Here's the v3.8-rc1 version of this Kconfig as an example:

http://www.pwsan.com/omap/testlogs/test_v3.8-rc1/20121228031713/build/am33xx_only/am33xx_only


- Paul
