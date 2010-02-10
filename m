From: Niamathullah sharief <omapsha@gmail.com>
Subject: Re: Ubuntu installation on omap
Date: Wed, 10 Feb 2010 20:03:07 +0530
Message-ID: <4ad3b6301002100633u5e8edff9x89ee543cdd27d3bc@mail.gmail.com>
References: <4ad3b6301002090141j3a57c223ib50c254b656239fc@mail.gmail.com>
	 <4551feaf1002090707r1069f25esc2582245057f236@mail.gmail.com>
	 <4ad3b6301002092130x7ea28ed8l9be0cfefc265684d@mail.gmail.com>
	 <7A436F7769CA33409C6B44B358BFFF0C012EBD13D9@dlee02.ent.ti.com>
	 <4ad3b6301002100434n74910f7csf736b92f957f4555@mail.gmail.com>
	 <4ad3b6301002100435k301e79f3rf8213cf65fd37ff7@mail.gmail.com>
	 <4ad3b6301002100438l6fcd5e35qb50312199eca03d8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f202.google.com ([209.85.216.202]:34633 "EHLO
	mail-px0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752291Ab0BJOdM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Feb 2010 09:33:12 -0500
Received: by pxi40 with SMTP id 40so21535pxi.21
        for <linux-omap@vger.kernel.org>; Wed, 10 Feb 2010 06:33:10 -0800 (PST)
In-Reply-To: <4ad3b6301002100438l6fcd5e35qb50312199eca03d8@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: Robert Nelson <robertcnelson@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

still i am getting my kernel booting
i am using "bootcmd=3Dmmcinit;fatload mmc 0:1 0x80000000 uImage;bootm
0x80000000". But i am creating uImage using "mkimage -A arm -O linux
-T kernel -C none -a 0x80008000 -e 0x80008000 -n "Linux" -d
=2E/vmlinuz-* ./uImage"
is this ok?i think the problem might be here. Please help me

On Wed, Feb 10, 2010 at 6:08 PM, Niamathullah sharief <omapsha@gmail.co=
m> wrote:
> sorry i followed this link to create uImage
> "http://elinux.org/BeagleBoardUbuntu#Create_uImage_for_U-Boot" now
> whether my "bootm" env is correct?
>
> On Wed, Feb 10, 2010 at 6:05 PM, Niamathullah sharief <omapsha@gmail.=
com> wrote:
>> Now i have the new problem. My env has changed and my uImage is not =
booting. see
>> reading uImage
>>
>> 3610172 bytes read
>> ## Booting kernel from Legacy Image at 80000000 ...
>> =A0Image Name: =A0 2.6.32.7-x7.1
>> =A0Image Type: =A0 ARM Linux Kernel Image (uncompressed)
>> =A0Data Size: =A0 =A03610108 Bytes =3D =A03.4 MB
>> =A0Load Address: 80008000
>> =A0Entry Point: =A080008000
>> =A0Verifying Checksum ... OK
>> =A0Loading Kernel Image ... OK
>> OK
>>
>> Starting kernel ...
>>
>> After this it is not going. I followed the link
>> http://elinux.org/BeagleBoardUbuntu#Create_U-Boot_boot_image to crea=
te
>> the uImage. whether my env setting are correct? i mean "## Booting
>> kernel from Legacy Image at 80000000 ..." is correct when i followed
>> the above link to create uImage?
>>
>> On Wed, Feb 10, 2010 at 6:04 PM, Niamathullah sharief <omapsha@gmail=
=2Ecom> wrote:
>>>
>>> Now i have the new problem. My env has changed and my uImage is not=
 booting. see
>>> reading uImage
>>>
>>>> 3610172 bytes read
>>>>
>>>> ## Booting kernel from Legacy Image at 80000000 ...
>>>>
>>>> =A0 Image Name: =A0 2.6.32.7-x7.1
>>>>
>>>> =A0 Image Type: =A0 ARM Linux Kernel Image (uncompressed)
>>>>
>>>> =A0 Data Size: =A0 =A03610108 Bytes =3D =A03.4 MB
>>>>
>>>> =A0 Load Address: 80008000
>>>>
>>>> =A0 Entry Point: =A080008000
>>>>
>>>> =A0 Verifying Checksum ... OK
>>>>
>>>> =A0 Loading Kernel Image ... OK
>>>>
>>>> OK
>>>>
>>>> Starting kernel ...
>>>
>>> After this it is not going. I followed the link http://elinux.org/B=
eagleBoardUbuntu#Create_U-Boot_boot_image to create the uImage. whether=
 my env setting are correct? i mean "## Booting kernel from Legacy Imag=
e at 80000000 ..." is correct when i followed the above link to create =
uImage?
>>>
>>>
>>> On Wed, Feb 10, 2010 at 11:20 AM, Menon, Nishanth <nm@ti.com> wrote=
:
>>> >> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>>> >> owner@vger.kernel.org] On Behalf Of Niamathullah sharief
>>> >> Sent: Wednesday, February 10, 2010 7:30 AM
>>> >>
>>> >> On Tue, Feb 9, 2010 at 8:37 PM, Robert Nelson <robertcnelson@gma=
il.com>
>>> >> wrote:
>>> >> > On Tue, Feb 9, 2010 at 3:41 AM, Niamathullah sharief <omapsha@=
gmail.com>
>>> >> wrote:
>>> >> >> Hi,
>>> >> >> =A0 I am trying to install ubuntu on my beagleboard. i instal=
led
>>> >> >> successfully and it is booting fine. But after booting the gr=
aphics
>>> >> >> which i get is not good. It has some graphics problem.
>>> >> >
>>> >> > Ahh, what kind of graphic problems?
>>> >> it is like working without graphics driver
>>> > Is'nt http://groups.google.com/group/beagleboard/ having more fol=
ks
>>> > Who can specifically help on beagleboard? Could we take the discu=
ssion
>>> > there?
>>> >
>>> > Regards,
>>> > Nishanth Menon
>>> >
>>>
>>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
