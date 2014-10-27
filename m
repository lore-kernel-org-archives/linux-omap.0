From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v6 4/7] ARM: l2c: Add support for overriding prefetch
 settings
Date: Mon, 27 Oct 2014 12:19:34 +0100
Message-ID: <544E2A46.7070106@samsung.com>
References: <1414407950-3029-1-git-send-email-m.szyprowski@samsung.com>
 <1414407950-3029-5-git-send-email-m.szyprowski@samsung.com>
 <20141027111404.GW12379@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:53451 "EHLO
	mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751622AbaJ0LTk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Oct 2014 07:19:40 -0400
In-reply-to: <20141027111404.GW12379@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, Tomasz Figa <tomasz.figa@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, lauraa@codeaurora.org, linux-omap@vger.kernel.org, linus.walleij@linaro.org, santosh.shilimkar@ti.com, tony@atomide.com, drake@endlessm.com, loeliger@gmail.com, Mark Rutland <mark.rutland@arm.com>

Hello,

On 2014-10-27 12:14, Russell King - ARM Linux wrote:
> On Mon, Oct 27, 2014 at 12:05:47PM +0100, Marek Szyprowski wrote:
>> From: Tomasz Figa <t.figa@samsung.com>
>>
>> Firmware on certain boards (e.g. ODROID-U3) can leave incorrect L2C prefetch
>> settings configured in registers leading to crashes if L2C is enabled
>> without overriding them. This patch introduces bindings to enable
>> prefetch settings to be specified from DT and necessary support in the
>> driver.
>>
>> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
>> [mszyprow: rebased onto v3.18-rc1, added error messages when property value
>>   is missing]
> Why?  What if the boot loader has already set these up appropriately?  Why
> should we force people to list these in the DT?

The error message is displayed only when user provided prefetch related
properties without any value (empty properties). Something that Mark Rutland
requested here: https://lkml.org/lkml/2014/9/24/426 I'm sorry if I didn't
describe it clearly enough.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

