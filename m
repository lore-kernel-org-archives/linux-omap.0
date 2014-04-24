From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH] ARM: dts: Add support for the BeagleBoard xM A/B
Date: Thu, 24 Apr 2014 16:21:50 -0700
Message-ID: <CAGa+x84uPwuUC61S4Wi2ymSdxVMs14pb_kCv0RhQRi-KySxSAw@mail.gmail.com>
References: <1397574599-29573-1-git-send-email-robertcnelson@gmail.com>
	<7hiopynyt5.fsf@paris.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qc0-f178.google.com ([209.85.216.178]:49060 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753475AbaDXXVv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Apr 2014 19:21:51 -0400
Received: by mail-qc0-f178.google.com with SMTP id i8so3215110qcq.23
        for <linux-omap@vger.kernel.org>; Thu, 24 Apr 2014 16:21:50 -0700 (PDT)
In-Reply-To: <7hiopynyt5.fsf@paris.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Robert Nelson <robertcnelson@gmail.com>
Cc: Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

On Thu, Apr 24, 2014 at 3:32 PM, Kevin Hilman <khilman@linaro.org> wrote:
> Robert Nelson <robertcnelson@gmail.com> writes:
>
>> BeagleBoard xM A/B has an inverted usb hub enable line vs the xM C
>>
>> Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
>> ---
>>  arch/arm/boot/dts/Makefile               |  1 +
>>  arch/arm/boot/dts/omap3-beagle-xm-ab.dts | 15 +++++++++++++++
>>  2 files changed, 16 insertions(+)
>>  create mode 100644 arch/arm/boot/dts/omap3-beagle-xm-ab.dts
>>
>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> index 35c146f..0bdeba3 100644
>> --- a/arch/arm/boot/dts/Makefile
>> +++ b/arch/arm/boot/dts/Makefile
>> @@ -246,6 +246,7 @@ dtb-$(CONFIG_ARCH_OMAP2PLUS) += omap2420-h4.dtb \
>>       omap3-sbc-t3730.dtb \
>>       omap3-devkit8000.dtb \
>>       omap3-beagle-xm.dtb \
>> +     omap3-beagle-xm-ab.dtb \
>>       omap3-evm.dtb \
>>       omap3-evm-37xx.dtb \
>>       omap3-ldp.dtb \
>> diff --git a/arch/arm/boot/dts/omap3-beagle-xm-ab.dts b/arch/arm/boot/dts/omap3-beagle-xm-ab.dts
>> new file mode 100644
>> index 0000000..9d81123
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/omap3-beagle-xm-ab.dts
>> @@ -0,0 +1,15 @@
>> +/*
>> + * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +#include "omap3-beagle-xm.dts"
>> +
>> +/ {
>> +     /* HS USB Port 2 Power enable was inverted with the xM C */
>> +     hsusb2_power: hsusb2_power_reg {
>> +             enable-active-high;
>
> Missing '};' here?
>
> This causes build breakage in linux-omap master, which now has this
> applied.

ignore this.  It's already been fixed, but was still lingering in
Tony's master branch.

Kevin
