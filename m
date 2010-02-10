From: Niamathullah sharief <omapsha@gmail.com>
Subject: Re: Ubuntu installation on omap
Date: Wed, 10 Feb 2010 18:05:02 +0530
Message-ID: <4ad3b6301002100435k301e79f3rf8213cf65fd37ff7@mail.gmail.com>
References: <4ad3b6301002090141j3a57c223ib50c254b656239fc@mail.gmail.com>
	 <4551feaf1002090707r1069f25esc2582245057f236@mail.gmail.com>
	 <4ad3b6301002092130x7ea28ed8l9be0cfefc265684d@mail.gmail.com>
	 <7A436F7769CA33409C6B44B358BFFF0C012EBD13D9@dlee02.ent.ti.com>
	 <4ad3b6301002100434n74910f7csf736b92f957f4555@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f187.google.com ([209.85.222.187]:61299 "EHLO
	mail-pz0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755219Ab0BJMfE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Feb 2010 07:35:04 -0500
Received: by pzk17 with SMTP id 17so1249211pzk.4
        for <linux-omap@vger.kernel.org>; Wed, 10 Feb 2010 04:35:02 -0800 (PST)
In-Reply-To: <4ad3b6301002100434n74910f7csf736b92f957f4555@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: Robert Nelson <robertcnelson@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Now i have the new problem. My env has changed and my uImage is not boo=
ting. see
reading uImage

3610172 bytes read
## Booting kernel from Legacy Image at 80000000 ...
  Image Name:   2.6.32.7-x7.1
  Image Type:   ARM Linux Kernel Image (uncompressed)
  Data Size:    3610108 Bytes =3D  3.4 MB
  Load Address: 80008000
  Entry Point:  80008000
  Verifying Checksum ... OK
  Loading Kernel Image ... OK
OK

Starting kernel ...

After this it is not going. I followed the link
http://elinux.org/BeagleBoardUbuntu#Create_U-Boot_boot_image to create
the uImage. whether my env setting are correct? i mean "## Booting
kernel from Legacy Image at 80000000 ..." is correct when i followed
the above link to create uImage?

On Wed, Feb 10, 2010 at 6:04 PM, Niamathullah sharief <omapsha@gmail.co=
m> wrote:
>
> Now i have the new problem. My env has changed and my uImage is not b=
ooting. see
> reading uImage
>
>> 3610172 bytes read
>>
>> ## Booting kernel from Legacy Image at 80000000 ...
>>
>> =A0 Image Name: =A0 2.6.32.7-x7.1
>>
>> =A0 Image Type: =A0 ARM Linux Kernel Image (uncompressed)
>>
>> =A0 Data Size: =A0 =A03610108 Bytes =3D =A03.4 MB
>>
>> =A0 Load Address: 80008000
>>
>> =A0 Entry Point: =A080008000
>>
>> =A0 Verifying Checksum ... OK
>>
>> =A0 Loading Kernel Image ... OK
>>
>> OK
>>
>> Starting kernel ...
>
> After this it is not going. I followed the link http://elinux.org/Bea=
gleBoardUbuntu#Create_U-Boot_boot_image to create the uImage. whether m=
y env setting are correct? i mean "## Booting kernel from Legacy Image =
at 80000000 ..." is correct when i followed the above link to create uI=
mage?
>
>
> On Wed, Feb 10, 2010 at 11:20 AM, Menon, Nishanth <nm@ti.com> wrote:
> >> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> >> owner@vger.kernel.org] On Behalf Of Niamathullah sharief
> >> Sent: Wednesday, February 10, 2010 7:30 AM
> >>
> >> On Tue, Feb 9, 2010 at 8:37 PM, Robert Nelson <robertcnelson@gmail=
=2Ecom>
> >> wrote:
> >> > On Tue, Feb 9, 2010 at 3:41 AM, Niamathullah sharief <omapsha@gm=
ail.com>
> >> wrote:
> >> >> Hi,
> >> >> =A0 I am trying to install ubuntu on my beagleboard. i installe=
d
> >> >> successfully and it is booting fine. But after booting the grap=
hics
> >> >> which i get is not good. It has some graphics problem.
> >> >
> >> > Ahh, what kind of graphic problems?
> >> it is like working without graphics driver
> > Is'nt http://groups.google.com/group/beagleboard/ having more folks
> > Who can specifically help on beagleboard? Could we take the discuss=
ion
> > there?
> >
> > Regards,
> > Nishanth Menon
> >
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
