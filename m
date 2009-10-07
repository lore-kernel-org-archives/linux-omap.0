From: Nishanth Menon <menon.nishanth@gmail.com>
Subject: Re: [PATCH 1/1] OMAP: I2C: Add mpu wake up latency constraint in
 i2c
Date: Wed, 07 Oct 2009 05:49:18 -0500
Message-ID: <4ACC722E.5060707@gmail.com>
References: <> <1253204923-21916-1-git-send-email-kalle.jokiniemi@digia.com>	 <1253204923-21916-2-git-send-email-kalle.jokiniemi@digia.com>	 <FCCFB4CDC6E5564B9182F639FC35608702F9F49663@dbde02.ent.ti.com> <1254910234.22468.251.camel@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f173.google.com ([209.85.210.173]:46405 "EHLO
	mail-yx0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758907AbZJGKt5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Oct 2009 06:49:57 -0400
Received: by yxe3 with SMTP id 3so4543097yxe.4
        for <linux-omap@vger.kernel.org>; Wed, 07 Oct 2009 03:49:21 -0700 (PDT)
In-Reply-To: <1254910234.22468.251.camel@ubuntu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "Sonasath, Moiz" <m-sonasath@ti.com>, "jhnikula@gmail.com" <jhnikula@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Kalle Jokiniemi said the following on 10/07/2009 05:10 AM:
>>> extra delays and subsequent re-trys cause i2c clocks
>>> to be active more often. This has also an negative
>>> effect on power consumption.
>>>
>>> Added a constraint that allows MPU to wake up in few
>>> hundred usecs, which is roughly the average i2c wait
>>> period.
>>>       
>> How did you arrive at the number 500us for the wakeup latency?
>>     
>
> This was about the average time that I observed i2c-transfers to be
> (from clk_enable to clk_disable), when off mode was not enabled.
>   
just a quick 2cents: I understand that the 500uSec might need to be
board dependent - here is why:
one theory we have regarding the timeout delay having to be modified on
zoom2 was that if the delay was 500uSec, the touch screen controller
timesout and pulls of the data in the middle of transfer.
Regards,
Nishanth Menon
