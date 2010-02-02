From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCH] DSPBRIDGE: Get rid of driver_minor global variable
Date: Tue, 2 Feb 2010 12:05:53 +0200
Message-ID: <4B67F901.7010602@ti.com>
References: <8a14e4992a92e3bc31d518ca71b14f214cf0f764.1265048264.git.ameya.palande@nokia.com>	 <4B67301B.10900@ti.com> <1265104997.3068.10.camel@chotu.research.nokia.com>
Reply-To: <nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40814 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751402Ab0BBKGH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 2 Feb 2010 05:06:07 -0500
In-Reply-To: <1265104997.3068.10.camel@chotu.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>
Cc: "Ramirez Luna, Omar" <omar.ramirez@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Chitriki Rudramuni, Deepak" <deepak.chitriki@ti.com>

Ameya Palande said the following on 02/02/2010 12:03 PM:
> Hi Nishanth,
> 
> On Mon, 2010-02-01 at 20:48 +0100, ext Menon, Nishanth wrote:
>> Ameya Palande said the following on 02/01/2010 08:18 PM:
>>> Since there is only 1 device there is no need of driver_minor global variable.
>> i am a little skeptical about this change - mainly coz, it might be a good idea for a userspace option
>> to be able to define what the minor id could be -> maybe an example could be /dev/mem which has a minor
>> id of 1, not 0. having a module_param might be better as such.. just my 2 cents..
> 
> I do not agree with user space having control of defining minor id.
> I would like to rephrase this sentence as: userspace should have control
> of defining name (string) for the device file. I guess udev takes care
> of that already!
>  
> Ideally userspace should just deal with device
> names: /dev/device1, /dev/device2 etc. Why it interprets (and that way
> creates a dependency on) major/minor number?
> 
> I am in favor of saving 4 bytes and less global namespace pollution :)
> 
> /dev/mem has minor id of 1 because it shares its major id with ramdisk.
> 
> file: include/linux/major.h
> 
> #define MEM_MAJOR               1
> #define RAMDISK_MAJOR           1
> 
> Cheers,
> Ameya.
> 
ok ok ok. you have me convinced :D

/me slinks away to the corner of the room and sits on the chair facing 
the wall ;)

Regards,
Nishanth Menon
