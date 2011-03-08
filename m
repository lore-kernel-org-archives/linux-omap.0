From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH] omap: iommu: disallow mapping NULL address
Date: Tue, 08 Mar 2011 11:02:51 +0200 (EET)
Message-ID: <20110308.110251.355905602403266314.Hiroshi.DOYU@nokia.com>
References: <AANLkTikzAjUrec+c6zcSCx6auaR9QvbWwwTbXpGYuOoZ@mail.gmail.com>
	<AANLkTi=KncNfW0NEEoV+mrT_Ft2j-c=rQG=qbeR6tLQK@mail.gmail.com>
	<AANLkTimac512Gu0_vyPjThvNxXHsXTRD73B0d1bHnnAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <AANLkTimac512Gu0_vyPjThvNxXHsXTRD73B0d1bHnnAg@mail.gmail.com>
Sender: linux-media-owner@vger.kernel.org
To: dacohen@gmail.com
Cc: fernando.lugo@ti.com, michael.jones@matrix-vision.de, laurent.pinchart@ideasonboard.com, sakari.ailus@maxwell.research.nokia.com, linux-media@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

=46rom: ext David Cohen <dacohen@gmail.com>
Subject: Re: [PATCH] omap: iommu: disallow mapping NULL address
Date: Mon, 7 Mar 2011 21:41:21 +0200

> On Mon, Mar 7, 2011 at 9:25 PM, Guzman Lugo, Fernando
> <fernando.lugo@ti.com> wrote:
>> On Mon, Mar 7, 2011 at 1:19 PM, David Cohen <dacohen@gmail.com> wrot=
e:
>>> On Mon, Mar 7, 2011 at 9:17 PM, Guzman Lugo, Fernando
>>> <fernando.lugo@ti.com> wrote:
>>>> On Mon, Mar 7, 2011 at 7:10 AM, Michael Jones
>>>> <michael.jones@matrix-vision.de> wrote:
>>>>> From e7dbe4c4b64eb114f9b0804d6af3a3ca0e78acc8 Mon Sep 17 00:00:00=
 2001
>>>>> From: Michael Jones <michael.jones@matrix-vision.de>
>>>>> Date: Mon, 7 Mar 2011 13:36:15 +0100
>>>>> Subject: [PATCH] omap: iommu: disallow mapping NULL address
>>>>>
>>>>> commit c7f4ab26e3bcdaeb3e19ec658e3ad9092f1a6ceb allowed mapping
>>>>> the NULL address if da_start=3D=3D0. =A0Force da_start to exclude=
 the
>>>>> first page.
>>>>
>>>> what about devices that uses page 0? ipu after reset always starts
>>>> from 0x00000000 how could we map that address??
>>>
>>> from 0x0? The driver sees da =3D=3D 0 as error. May I ask you why d=
o you want it?
>>
>> unlike DSP that you can load a register with the addres the DSP will
>> boot, IPU core always starts from address 0x00000000, so if you take
>> IPU out of reset it will try to access address 0x0 if not map it,
>> there will be a mmu fault.
>=20
> Hm. Looks like the iommu should not restrict any da. The valid da
> range should rely only on pdata.
> Michael, what about just update ISP's da_start on omap-iommu.c file?
> Set it to 0x1000.
>=20
> Hiroshi, any opinion?

We have assumed that 'da =3D=3D 0' is NULL so far. According to Fernand=
o's
explanation, 'da =3D=3D 0' should be allowed in iovmm layer by default.
