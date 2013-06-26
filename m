From: Tom Rini <trini@ti.com>
Subject: Re: OMAP baseline test results for v3.10-rc6
Date: Wed, 26 Jun 2013 16:02:02 -0400
Message-ID: <51CB48BA.7020401@ti.com>
References: <alpine.DEB.2.02.1306170521020.9909@utopia.booyaka.com> <20130625160243.GE22312@arwen.pp.htv.fi> <alpine.DEB.2.02.1306251746060.14373@utopia.booyaka.com> <51C9F0A8.1050607@ti.com> <87fvw6t136.fsf@linaro.org> <79CD15C6BA57404B839C016229A409A83ECC952D@DBDE04.ent.ti.com> <51CAEB33.5010101@ti.com> <51CAEBF3.1010507@ti.com> <alpine.DEB.2.02.1306261726280.6135@utopia.booyaka.com> <51CB28BD.2020105@ti.com> <alpine.DEB.2.02.1306261750210.6135@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39508 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752112Ab3FZUHv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 26 Jun 2013 16:07:51 -0400
In-Reply-To: <alpine.DEB.2.02.1306261750210.6135@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, Kevin Hilman <khilman@linaro.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Balbi, Felipe" <balbi@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 06/26/2013 01:58 PM, Paul Walmsley wrote:
> On Wed, 26 Jun 2013, Tom Rini wrote:
> 
>> OK, is there a reason to not be using omap2plus_defconfig?  My pass/fail
>> here is based on that config and enabling, or not, dtb append.  Seems
>> like it would be one less thing to maintain on your end and it would be
>> on TIs end (roughly speaking) to make sure our platforms that ought to
>> be working upstream have what they need enabled in the defconfig(s) in
>> question.
> 
> That would be convenient for me, but part of the goal is to verify that a 
> Kconfig that deselects all OMAPs other than AM33xx continues to work.
> 
> So the build process for am33xx_only here goes something like:
> 
> 1. Start with omap2plus_defconfig
> 
> 2. Turn off support for everything other than AM33xx in the SoC target 
> selection menus
> 
> 3. Turn on the appended DTB and compat ATAGs options
> 
> You might consider adding something like this to your pass/fail tests.

Adding more and different build+boot tests is on the list.  I guess you
could automate this with a fraagment of everything am33xx must have to
boot+root and alldefconfig for the rest?

-- 
Tom
