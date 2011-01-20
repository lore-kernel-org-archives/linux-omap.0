From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] ARM: smp: Introduce ARCH_HAS_COMMON_CORES_CLOCK to
 speed-up boot
Date: Thu, 20 Jan 2011 17:21:48 +0100
Message-ID: <AANLkTin00ULesF4vnCUEQh6A_CLyTrUAwWxk2NN01y5v@mail.gmail.com>
References: <1295516579-10225-1-git-send-email-santosh.shilimkar@ti.com>
	<4D385155.4050301@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:54198 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751701Ab1ATQVt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Jan 2011 11:21:49 -0500
Received: by pva4 with SMTP id 4so125799pva.19
        for <linux-omap@vger.kernel.org>; Thu, 20 Jan 2011 08:21:48 -0800 (PST)
In-Reply-To: <4D385155.4050301@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Russell King <rmk+kernel@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

2011/1/20 Rob Herring <robherring2@gmail.com>:
> On 01/20/2011 03:42 AM, Santosh Shilimkar wrote:
>>
>> On some architectures, secondary cores shares clock with primiary
>> core and hence scale together. Hence secondary core lpj calibration
>> is not necessary and can be skipped to save considerable time.
>>
>> This can speed up the secondary cpu boot and hotplug cpu online
>> paths.
>>
>> Discussion thread:
>> =A0 =A0 =A0 =A0http://www.spinics.net/lists/arm-kernel/msg111124.htm=
l
>>
>
> There's already one way to do this with pre-calculated lpj.
>
> Also, this isn't multi-platform friendly.

It can be made to be, then -
skip all Kconfig business (more elegant like this anyway):

static inline int skip_secondary_calibrate(void)
{
    return machine_is_u8500() ||
        machine_is_svp8500v1() ||
        machine_is_svp8500v2() ||
        machine_is_svp5500() ||
        machine_is_b5500() ||
        machine_is_s5500() ||
        machine_is_omap4_panda();
}

Hm if this multi-platform stuff is desirable we probably need
a runtime arch_is_omap4(), arch_is_u8500() etc so this machine
list doesn't grow ridiculously long, but ftm this will work.

Yours,
Linus Walleij
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
