From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH] arm: omap: reduce zImage size on omap2plus_defconfig
Date: Fri, 26 Dec 2014 14:08:10 +0200
Message-ID: <549D4FAA.1040207@compulab.co.il>
References: <1419271535-4057-1-git-send-email-balbi@ti.com> <54991A25.2030804@compulab.co.il> <20141223161936.GA9147@saruman> <549AA94A.8030209@compulab.co.il> <20141224154948.GA423@saruman> <20141224190401.GN23854@atomide.com> <20141226043719.GA7661@saruman>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:51829 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751721AbaLZMIR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Dec 2014 07:08:17 -0500
In-Reply-To: <20141226043719.GA7661@saruman>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com, Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 12/26/14 06:37, Felipe Balbi wrote:
> Hi,
> 
> On Wed, Dec 24, 2014 at 11:04:01AM -0800, Tony Lindgren wrote:
>> * Felipe Balbi <balbi@ti.com> [141224 07:52]:
>>> Hi,
>>>
>>> On Wed, Dec 24, 2014 at 01:53:46PM +0200, Igor Grinberg wrote:
>>>> -----BEGIN PGP SIGNED MESSAGE-----
>>>> Hash: SHA1
>>>>
>>>> On 12/23/14 18:19, Felipe Balbi wrote:
>>>>> On Tue, Dec 23, 2014 at 09:30:45AM +0200, Igor Grinberg wrote:
>>>>>> Hi Felipe,
>>>>>>
>>>>>> On 12/22/14 20:05, Felipe Balbi wrote:
>>>>>>
>>>>>> [...]
>>>>>>
>>>>>>>  CONFIG_SCSI_SCAN_ASYNC=y
>>>>>>> -CONFIG_ATA=y
>>>>>>> -CONFIG_SATA_AHCI_PLATFORM=y
>>>>>>> -CONFIG_MD=y
>>>>>>> +CONFIG_ATA=m
>>>>>>> +CONFIG_SATA_AHCI_PLATFORM=m
>>>>>>
>>>>>> Isn't this needed for the rootfs on SATA devices?
>>>>>
>>>>> there's no known boards with rootfs on SATA. Until then, we can reduce
>>>>> the size.
>>>>
>>>> What makes you say so?
>>>> The decision for rootfs on SATA is taken dynamically.
>>>> OMAP5 boards (specifically cm-t54) can have rootfs on SATA...
>>>
>>> I'll leave the decision to Tony. Even though they _can_, they really
>>> don't and IIRC, OMAP5's SATA has so many silicon errata that it'd be
>>> annoying to find that special device which works (e.g it can't negotiate
>>> lower speeds with SATA III devices and it won't support SATA I).
>>>
>>> As of today, we don't know of anybody really shipping anything with
>>> rootfs on SATA and distros would rather ship initiramfs than a giant
>>> zImage anyway.
>>>
>>> Tony, your call.
>>
>> I think we should move omap2plus_defconfig to be mostly modular and
>> usable for distros as a base. Most distros prefer to build almost
>> everything as loadable modules. And my preference is that we should
>> only keep the minimum rootfs for devices and serial support as
>> built-in and rely on initramfs for most drivers. And slowly move
>> also the remaining built-in drivers to be loadable modules.
>>
>> The reasons for having drivers as loadable modules are many. It
>> allows distros to use the same kernel for all the devices without
>> bloating the kernel. It makes developing drivers easier as just the
>> module needs to be reloaded. And loadable modules protect us from
>> cross-framework spaghetti calls in the kernel as the interfaces are 
>> clearly defined.
>>
>> Are there people really using SATA as rootfs right now on omaps?
> 
> not that we know :-) The only platforms available today with SATA are
> OMAP5432 uEVM and DRA7x EVM,

I'm sorry... that is not true.

> the latter being mostly used by TIers as of
> now (at least from mainline point of view).

the keyword is mostly... And I'm also not sure this is true these days...

But, really, don't mind me. We will find our solutions (we always did).
I mean, Felipe wants it out so badly...
Who am I to say anything...

> 
>> If it's only something that will be more widely used in the future,
>> then I suggest we make it into a loadable module, and presume
>> initramfs and loadable module also for any new devices. The same
>> way x86 has been doing with distros for years.
> 
> alright, as a module it shall remain.
> 

- -- 
Regards,
Igor.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUnU+qAAoJEBDE8YO64Efa8IgP/jQlP5nHLK8aWXpNIrRH3dri
IzIDvWqUC+zYqIgg1JcPmxgfZ+5vhYgjCVx+q0m/81qk164QK4zGs6gDr8sDjK8O
Q8rqujAbVFO2nmJHmq8VhTpapqTDtG5sH/HvtaWPtBxmBoA5yLdA8KObV9Gf2871
GvlP1WS/CUu6ClzEERsdWJkfpkqrJ1My1Ox7zCkL80uqM5z6jmje2sam4AiuGWSK
Kb/Kdkmqae1lizjSnyW0ZckTyCuLUPdzvV+OCq3JrDDJV9W3hrA0KmYKUe4gO0JI
Z2PNMKvbBuA9miY0IPsbILYkQ01OoKOwZXfDrhhK0k5FLPxSujc9NbfwqByTK2gi
Ca5zZKoTaUN8A2YoxdNv+m9gILnlgDCtRjvc6elEYZBLZd+03TsxgWAB+aYfx03d
1W5+qp8jSGBRzsDg5o8ir6mS8xYM3Hpy7xDPT46BqjKzczMCdeXH5MqibL34kqtC
mMhMw1UzZ5qGOyHXqYE9bosgfpbf+WxmVta7/RRgaJJwo7N41pf1sDyoJjczAfPo
cAQNeIwPd1DxiS2nO46i4w8FUq10Lf3I7mXxabXIsU3YD81QpjxL5arlFXlPfDVg
Ki8GW1yE81RepD5xuhhz3/U9pKvozSewH5BlHBo6h9rSBkyyBPs2NbxSxjSNct1H
MKEG/rYHptCRIntrZ8pm
=w62Y
-----END PGP SIGNATURE-----
