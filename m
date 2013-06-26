From: Tom Rini <trini@ti.com>
Subject: Re: OMAP baseline test results for v3.10-rc6
Date: Wed, 26 Jun 2013 07:27:28 -0400
Message-ID: <51CAD020.5090704@ti.com>
References: <alpine.DEB.2.02.1306170521020.9909@utopia.booyaka.com> <20130625160243.GE22312@arwen.pp.htv.fi> <alpine.DEB.2.02.1306251746060.14373@utopia.booyaka.com> <51C9F0A8.1050607@ti.com> <87fvw6t136.fsf@linaro.org> <51C9FC05.4070700@ti.com> <20130626091522.GT21614@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52708 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751969Ab3FZL1k (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Jun 2013 07:27:40 -0400
In-Reply-To: <20130626091522.GT21614@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Kevin Hilman <khilman@linaro.org>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>, hvaibhav@ti.com

On 06/26/2013 05:15 AM, Russell King - ARM Linux wrote:
> On Tue, Jun 25, 2013 at 04:22:29PM -0400, Tom Rini wrote:
>> On 06/25/2013 03:57 PM, Kevin Hilman wrote:
>>> Just to confirm, my problems with mainline were with appended DTB also.
>>> Separate DTB and zImage work fine (at least using u-boot v2013.04.)
>>>
>>> That being said, appended DTB should still work, so there's a bug hiding
>>> someplace that needs to be found fixed.
>>
>> Since we've narrowed down what the problem is, someone can bisect it
>> now, yeah.
>>
>>> Can you guys update your tests to test appended DTB also?
>>
>> What is the official position on appending DTBs?
> 
> If a platform goes from being able to boot without a DTB to requiring
> a DTB, we must continue to support booting on that platform in some
> manner otherwise it is a regression.
> 
> And no, I don't term upgrading uboot as an acceptable regression fix.
> So if appended DTB doesn't work, that needs fixing before the non-DTB
> support for a platform is removed, otherwise we _will_ have a regression.

am335x never had a board file in mainline, so it's always required a DTB.

Now, I assume you're still saying that whatever software, except for the
kernel of course, shipped on the SD card, has to be supported for
forever by the kernel, right?

-- 
Tom
