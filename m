From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH] arm: omap: reduce zImage size on omap2plus_defconfig
Date: Fri, 26 Dec 2014 13:56:26 +0200
Message-ID: <549D4CEA.6090009@compulab.co.il>
References: <1419271535-4057-1-git-send-email-balbi@ti.com> <54991A25.2030804@compulab.co.il> <20141223161936.GA9147@saruman> <549AA94A.8030209@compulab.co.il> <20141224154948.GA423@saruman> <20141224190401.GN23854@atomide.com> <549BE333.9060709@compulab.co.il> <20141226044246.GB7661@saruman>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:50128 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751441AbaLZL4d convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Dec 2014 06:56:33 -0500
In-Reply-To: <20141226044246.GB7661@saruman>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 12/26/14 06:42, Felipe Balbi wrote:
> Hi,
> 
> On Thu, Dec 25, 2014 at 12:13:07PM +0200, Igor Grinberg wrote:
>> Hi Tony,
>>
>> On 12/24/14 21:04, Tony Lindgren wrote:
>>> * Felipe Balbi <balbi@ti.com> [141224 07:52]:
>>>> Hi,
>>>>
>>>> On Wed, Dec 24, 2014 at 01:53:46PM +0200, Igor Grinberg wrote:
>>>>> -----BEGIN PGP SIGNED MESSAGE-----
>>>>> Hash: SHA1
>>>>>
>>>>> On 12/23/14 18:19, Felipe Balbi wrote:
>>>>>> On Tue, Dec 23, 2014 at 09:30:45AM +0200, Igor Grinberg wrote:
>>>>>>> Hi Felipe,
>>>>>>>
>>>>>>> On 12/22/14 20:05, Felipe Balbi wrote:
>>>>>>>
>>>>>>> [...]
>>>>>>>
>>>>>>>>  CONFIG_SCSI_SCAN_ASYNC=y
>>>>>>>> -CONFIG_ATA=y
>>>>>>>> -CONFIG_SATA_AHCI_PLATFORM=y
>>>>>>>> -CONFIG_MD=y
>>>>>>>> +CONFIG_ATA=m
>>>>>>>> +CONFIG_SATA_AHCI_PLATFORM=m
>>>>>>>
>>>>>>> Isn't this needed for the rootfs on SATA devices?
>>>>>>
>>>>>> there's no known boards with rootfs on SATA. Until then, we can reduce
>>>>>> the size.
>>>>>
>>>>> What makes you say so?
>>>>> The decision for rootfs on SATA is taken dynamically.
>>>>> OMAP5 boards (specifically cm-t54) can have rootfs on SATA...
>>>>
>>>> I'll leave the decision to Tony. Even though they _can_, they really
>>>> don't and IIRC, OMAP5's SATA has so many silicon errata that it'd be
>>>> annoying to find that special device which works (e.g it can't negotiate
>>>> lower speeds with SATA III devices and it won't support SATA I).
>>
>> Yet, it is not that buggy and at least until now, I di not get any
>> reports about badly working SATA from customers...
>>
>>>>
>>>> As of today, we don't know of anybody really shipping anything with
>>>> rootfs on SATA and distros would rather ship initiramfs than a giant
>>>> zImage anyway.
>>
>> So, you just continue to ignore what I'm saying... even after I point
>> to a device...
> 
> you pointed a device which *can* have rootfs on SATA, not one which
> *has* rootfs on SATA, there's a very big difference there.

Yeah, I thought you will parse me in that way...

> 
>> Is it SATA that makes it so giant?
>> Because I find it worth having in SATA than spare some more k's...
> 
> that's your point of view. As Tony mentioned, we have a very standard
> way of dealing with this which is initramfs and x86 has been using that
> for the past 15+ years.

may be, but no... x86 has SATA built in...

> 
>>>> Tony, your call.
>>>
>>> I think we should move omap2plus_defconfig to be mostly modular and
>>> usable for distros as a base. Most distros prefer to build almost
>>> everything as loadable modules. And my preference is that we should
>>> only keep the minimum rootfs for devices and serial support as
>>> built-in and rely on initramfs for most drivers. And slowly move
>>> also the remaining built-in drivers to be loadable modules.
>>>
>>> The reasons for having drivers as loadable modules are many. It
>>> allows distros to use the same kernel for all the devices without
>>> bloating the kernel. It makes developing drivers easier as just the
>>> module needs to be reloaded. And loadable modules protect us from
>>> cross-framework spaghetti calls in the kernel as the interfaces are 
>>> clearly defined.
>>>
>>> Are there people really using SATA as rootfs right now on omaps?
>>
>> Yes. That is exactly my point.
> 
> read your email, you said it *CAN* have rootfs on SATA.

yep, it also *CAN* have rootfs on MMC and NFS and ...

> 
>>> If it's only something that will be more widely used in the future,
>>> then I suggest we make it into a loadable module, and presume
>>> initramfs and loadable module also for any new devices. The same
>>> way x86 has been doing with distros for years.
>>
>> The difference from x86 is that we're in embedded here and
> 
> bullshit, you would never ship a product with omap2plus_defconfig. You'd
> build your own at which point you would switch SATA to built-in.

Yep, that is one of the options indeed, but I'm not asking you to
deal with my problems, right?
I'm feeling like you are trying to insult me.
Are you angry with me? Why?
Is it because I have a different opinion?

> 
>> although initramfs is a kind of option, but it means, you need to
>> load even more data during the boot process... it is annoying and
>> I would not want to use it on embedded.
> 
> make your own defconfig.

This sounds like: mind your own business...
Is that what you want to say?

> 
>> (BTW, x86_64_defconfig has it compiled in...)
>>
>> We can also, split the defconfig as it was some time ago... but I
>> would not want to go that direction...
>>
>> If we go the initramfs way, then why not also load MMC from it?
>> That will also reduce kernel size... (but add initramfs size)
> 
> I'm fine with that. The difference is that people have been relying on
> MMC built-in for the past 10+ years, since the old OMAP1 MMC driver,
> changing that now is likely to cause some "my board won't boot anymore"
> bug reports.

Yep. So there are exceptions, right?

> 
>> I'm sure you will find making the MMC a loadable module inconvenient.
>> That how I find making the SATA a loadable module...
>>
>> Right now, we tell our customers that they can use mainline with
>> omap2plus_defconfig.
> 
> that's the worst thing you can do.

Hmmm... Interesting, so people should not use mainline.

> You should at a minimum provide your
> customers with a more minimal rootfs. Why would you have your customers
> build MUSB on an OMAP5 board ? Why would they build 5 different
> network device drivers ? Why would they build almost every single PMIC
> we ever used ? The list goes on and on.

That is their decision to make. I'm just saying that they can use it.


- -- 
Regards,
Igor.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUnUzqAAoJEBDE8YO64EfawVsP/RBnEcOMVLjocMKwB/wVDrAf
PamLBOMHtFNZrqMntL13N25a799h2FS5lYn+jYBw7AkXcdfJUgJeHjivukJMwPdm
RArMzY03HtwXqfH1pn8zpopxbuFgSGRcS6O0k8xAV21iLgSFvLuZTIJK5/9RH3Oi
rznIgrxg1yDpGttm2Btq+55IIVhStf2IwPSqEidK/73Rjx08a2j+bkSXnlYVnhyx
ZNfumCpcHoAFLX3SQIbAKSpWNO0jMvqJ2dqN+wNb0A/RtoWWf26ITdVEXEpt0HE7
g1r7xvcEVZsXaeN2rMQsfNaZk9zGHOM50v3G6n/LMkyCa0oWO2CPPwTeCPoDdzgZ
5HAjHOXSnYV3QcMj9cklI09vYIKRPvASNyGcEft/HsYv98TmbNU5YGdTHwW66aDK
5VKKKLBwuGOJC5k+fQdEO38oqrEuxWfHRolSCoOmZXfaTPYAAGzU9s4NL9OisgPa
pqyOIqU4/WexWzFyhKE28ebJmtsNtlAyNiXPV/4s0y4hf0E0Se1Z2DhhOSI9BZK+
P6ce+pqrDZgJlGMN13PR4p6vxCEIW6+xZu8sUTHEMs8EhplQRrduSud6OY60ocjm
5F/f2LicydOu7w1OyO3HoENhdZ1EuSTp1njlJ5DkGhHNtw10rFr+5sSUcooPFQwg
9eozH1HMbeJS4CRgV5iT
=VLzg
-----END PGP SIGNATURE-----
