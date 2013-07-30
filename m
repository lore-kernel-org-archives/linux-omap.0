From: Nishanth Menon <nm@ti.com>
Subject: Re: OMAP baseline test results for v3.10-rc6
Date: Tue, 30 Jul 2013 15:28:17 -0500
Message-ID: <51F821E1.3040808@ti.com>
References: <alpine.DEB.2.02.1306170521020.9909@utopia.booyaka.com> <20130625160243.GE22312@arwen.pp.htv.fi> <alpine.DEB.2.02.1306251746060.14373@utopia.booyaka.com> <51C9F0A8.1050607@ti.com> <alpine.DEB.2.02.1306261713260.6135@utopia.booyaka.com> <51CB4C20.3060306@ti.com> <alpine.DEB.2.02.1307290826180.30864@utopia.booyaka.com> <51F66024.1030804@ti.com> <alpine.DEB.2.02.1307302001500.4505@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41501 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756523Ab3G3U2k (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 30 Jul 2013 16:28:40 -0400
In-Reply-To: <alpine.DEB.2.02.1307302001500.4505@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Tom Rini <trini@ti.com>, "Balbi, Felipe" <balbi@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Hiremath, Vaibhav" <hvaibhav@ti.com>

On 07/30/2013 03:23 PM, Paul Walmsley wrote:

> Do you know if anyone ever got serial cold-booting working well for, say,
> OMAP3 and OMAP4 chips?

I had done configuration header based OMAP3 boot[1] once upon a time, 
but serial boot straight to kernel, we need a second that gives control 
there.. could be done, have'nt heard it done + I dont directly see a 
customer usage model for it ("ROI for investment of time") - so doubt 
any investment was done.

CH was the closest I could get to avoiding bootloaders in it's entirety. 
but the level of interest fell off when there was no viable usage model 
for the same.


[1] http://marc.info/?t=127232401100003&r=1&w=2
-- 
Regards,
Nishanth Menon
