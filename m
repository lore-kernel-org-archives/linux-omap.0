From: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>
Subject: Re: [PATCH] omap: iommu: disallow mapping NULL address
Date: Tue, 8 Mar 2011 11:45:35 -0600
Message-ID: <AANLkTinp2nxKSGkvXtxAe6s+URYiOYEVMmTDkdk9PAPN@mail.gmail.com>
References: <4D6D219D.7020605@matrix-vision.de>
	<201103022018.23446.laurent.pinchart@ideasonboard.com>
	<4D6FBC7F.1080500@matrix-vision.de>
	<AANLkTikAKy=CzTqEv-UGBQ1EavqmCStPNFZ5vs7vH5VK@mail.gmail.com>
	<4D70F985.8030902@matrix-vision.de>
	<AANLkTinSJpjPXWHWduLbRSmb=La3sv82ufwgsq-uR7S2@mail.gmail.com>
	<AANLkTi=8Sss-5xfgPmgx=J_T__=hrC1rQU-xBOdKC8Ve@mail.gmail.com>
	<4D74D94F.7040702@matrix-vision.de>
	<AANLkTikokA2hGMYA3vfBOxa0jPr0tjbLfYW603+zicry@mail.gmail.com>
	<AANLkTikzAjUrec+c6zcSCx6auaR9QvbWwwTbXpGYuOoZ@mail.gmail.com>
	<AANLkTi=KncNfW0NEEoV+mrT_Ft2j-c=rQG=qbeR6tLQK@mail.gmail.com>
	<4D75F343.8090505@maxwell.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <4D75F343.8090505@maxwell.research.nokia.com>
Sender: linux-media-owner@vger.kernel.org
To: Sakari Ailus <sakari.ailus@maxwell.research.nokia.com>
Cc: David Cohen <dacohen@gmail.com>, Michael Jones <michael.jones@matrix-vision.de>, Hiroshi.DOYU@nokia.com, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linux Media Mailing List <linux-media@vger.kernel.org>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, Mar 8, 2011 at 3:13 AM, Sakari Ailus
<sakari.ailus@maxwell.research.nokia.com> wrote:
> Guzman Lugo, Fernando wrote:
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
>
> I think the driver for IPU (what is it, btw.?) must map the NULL addr=
ess
> explicitly. It cannot rely on automatic allocation of the NULL addres=
s
> by the iommu even if it was the first allocation.

IPU =3D imaging processor unit (Cortex-M3 on omap4).

yeah, we should rely on that, so we will need to pass IOVMF_DA_FIXED
flag, what ideally always be success because it is the first map after
getting iommu handle. In this moment it is mapped direcctly using
iommu.c and other layer upon that, but it would be nice be able to use
iovmm in the future.

Regards,
=46ernando.


>
> --
> Sakari Ailus
> sakari.ailus@maxwell.research.nokia.com
>
