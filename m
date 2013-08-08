From: Dave Gerlach <d-gerlach@ti.com>
Subject: Re: [PATCHv3 8/9] ARM: OMAP2+: AM33XX: Basic suspend resume support
Date: Thu, 8 Aug 2013 11:06:41 -0500
Message-ID: <5203C211.7040207@ti.com>
References: <1375811376-49985-1-git-send-email-d-gerlach@ti.com> <1375811376-49985-9-git-send-email-d-gerlach@ti.com> <CA+Bv8XbK+=pvG+bbvfCtS2Rtg-YoAhuUbWjSro9m4xWjw=Cr8A@mail.gmail.com> <52038E88.2050604@ti.com> <5203B336.90102@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36907 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964796Ab3HHQHP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 Aug 2013 12:07:15 -0400
In-Reply-To: <5203B336.90102@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Nishanth Menon <nm@ti.com>, Russ Dill <russ.dill@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@linaro.org>, Vaibhav Bedia <vaibhav.bedia@ti.com>, Tony Lingren <tony@atomide.com>, Benoit Cousson <benoit.cousson@linaro.org>

On 08/08/2013 10:03 AM, Santosh Shilimkar wrote:
> $subject and patch don't match.
>
> On Thursday 08 August 2013 08:26 AM, Nishanth Menon wrote:
>> On 08/08/2013 03:45 AM, Russ Dill wrote:
>>>    In reference to
>>> the M3 handling it, the M3 wouldn't know which devices have a driver
>>> bound and which don't.
>> Does it need to? M3 firmware can pretty much define "I will force the device into low power state, and if the drivers dont handle things properly, fix the darned driver". M3 behavior should be considered as a "hardware" as far as Linux running on MPU is concerned, and firmware helps change the behavior by accounting for SoC quirks. *if* we have ability to handle this in the firmware, there is no need to carry this in Linux.
>>
> I agree with Nishant. I don't like this patch and IIRC, I gave same
> comment in the last version. Linux need not know about all such firmware
> quirks. Also all these M3 specific stuff, should be done somewhere
> else. Probably having a small M3 driver won't be a bad idea.
>
> Regards,
> Santosh
>

I am not opposed to doing it this way and letting the M3 firmware handle 
idling these modules, however the one concern raised in the last series 
is that an approach that does not acknowledge drivers will hide driver 
PM bugs. I suppose as long as I make sure to document that the devices 
are being idled by the M3 firmware this may not be an issue. I will look 
into implementing this.

Regards,
Dave
