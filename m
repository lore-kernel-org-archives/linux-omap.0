From: Shubhrajyoti <shubhrajyoti@ti.com>
Subject: Re: [PATCH] OMAP2+: UART: Make the SERIAL_OMAP depend on ARCH_OMAP2PLUS
Date: Tue, 15 Nov 2011 15:16:03 +0530
Message-ID: <4EC234DB.4030501@ti.com>
References: <1321338460-1421-1-git-send-email-shubhrajyoti@ti.com> <20111115090634.GA31462@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:52131 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754576Ab1KOJqL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Nov 2011 04:46:11 -0500
In-Reply-To: <20111115090634.GA31462@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tuesday 15 November 2011 02:36 PM, Russell King - ARM Linux wrote:
> On Tue, Nov 15, 2011 at 11:57:40AM +0530, Shubhrajyoti D wrote:
>> Making  SERIAL_OMAP depend on ARCH_OMAP2PLUS instead of
>> oring with ARCH2/3/4.
>>
>> Acked-by: Felipe Balbi <balbi@ti.com>
>> Suggested-by: Sricharan R <r.sricharan@ti.com>
>> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> There's another one:
>
> drivers/mtd/nand/Kconfig:     depends on ARM && (ARCH_OMAP2 || ARCH_OMAP3 || ARCH_OMAP4)
>
> And the 'ARM &&' is redundant.
Will send a patch addressing the same.


