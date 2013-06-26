From: Tom Rini <trini@ti.com>
Subject: Re: OMAP baseline test results for v3.10-rc6
Date: Wed, 26 Jun 2013 09:26:11 -0400
Message-ID: <51CAEBF3.1010507@ti.com>
References: <alpine.DEB.2.02.1306170521020.9909@utopia.booyaka.com> <20130625160243.GE22312@arwen.pp.htv.fi> <alpine.DEB.2.02.1306251746060.14373@utopia.booyaka.com> <51C9F0A8.1050607@ti.com> <87fvw6t136.fsf@linaro.org> <79CD15C6BA57404B839C016229A409A83ECC952D@DBDE04.ent.ti.com> <51CAEB33.5010101@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58908 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751368Ab3FZN0Q (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 26 Jun 2013 09:26:16 -0400
In-Reply-To: <51CAEB33.5010101@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: "Hiremath, Vaibhav" <hvaibhav@ti.com>, Kevin Hilman <khilman@linaro.org>, Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Balbi, Felipe" <balbi@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 06/26/2013 09:22 AM, Rajendra Nayak wrote:
>>>
>>> Just to confirm, my problems with mainline were with appended DTB also.
>>> Separate DTB and zImage work fine (at least using u-boot v2013.04.)
>>>
>>> That being said, appended DTB should still work, so there's a bug
>>> hiding
>>> someplace that needs to be found fixed.
>>>
>>> Can you guys update your tests to test appended DTB also?
>>>
>>
>> What is missing here is, 
>>
>> CONFIG_ARM_APPENDED_DTB = y
>> CONFIG_ARM_ATAG_DTB_COMPAT = y
>>
>>
>> And for the code which is required in case of appended DTB, please refer to the code
>> "arch/arm/boot/compressed/head.S"
>>
>>
>> Please __NOTE__ that these options are not enabled in default omap2plus_defconfig.
> 
> Paul/Kevin,
> 
> Apart from confirming if you are manually enabling these options, can you also give some
> details on how you append the dtb to the kernel image?

Yes, please confirm that they're being set.  I've managed to reproduce
the failure, with them off, and enabling them brings things back to life.

Pending rmk's reply in another part of the thread, I'll submit a patch
to enable the above in omap2plus_defconfig.

-- 
Tom
