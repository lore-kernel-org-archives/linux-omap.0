From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 7/7] OMAP2+: devices: Remove all omap_device_pm_latency
 structures
Date: Thu, 1 Sep 2011 13:59:13 +0200
Message-ID: <4E5F7391.7060602@ti.com>
References: <1314026347-21623-1-git-send-email-b-cousson@ti.com> <1314026347-21623-8-git-send-email-b-cousson@ti.com> <87sjoh6wnj.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49787 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753055Ab1IAL7S (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 1 Sep 2011 07:59:18 -0400
In-Reply-To: <87sjoh6wnj.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "paul@pwsan.com" <paul@pwsan.com>

On 9/1/2011 12:31 AM, Hilman, Kevin wrote:
> Benoit Cousson<b-cousson@ti.com>  writes:
>
>> Remove all these duplicated structures since a default one is now
>> available.
>>
>> Signed-off-by: Benoit Cousson<b-cousson@ti.com>
>> Cc: Kevin Hilman<khilman@ti.com>
>> ---
>>   arch/arm/mach-omap2/devices.c    |   46 +++----------------------------------
>>   arch/arm/mach-omap2/display.c    |   11 +--------
>>   arch/arm/mach-omap2/dma.c        |   11 +--------
>>   arch/arm/mach-omap2/gpio.c       |   12 +---------
>>   arch/arm/mach-omap2/hsmmc.c      |   18 +--------------
>>   arch/arm/mach-omap2/hwspinlock.c |   12 +---------
>>   arch/arm/mach-omap2/mcbsp.c      |   11 +--------
>>   arch/arm/mach-omap2/serial.c     |   25 +-------------------
>>   arch/arm/mach-omap2/sr_device.c  |   11 +--------
>>   arch/arm/mach-omap2/usb-musb.c   |   11 +--------
>>   arch/arm/plat-omap/i2c.c         |   10 +-------
>>   11 files changed, 14 insertions(+), 164 deletions(-)
>
> Nice!  queuing this for v3.2 (branch: for_3.2/omap_device)

Thanks,
Benoit
