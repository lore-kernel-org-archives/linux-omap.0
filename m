From: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>
Subject: Re: [PATCH] omap: iommu: disallow mapping NULL address
Date: Tue, 8 Mar 2011 11:49:04 -0600
Message-ID: <AANLkTin7SgyN=23rp4a3sPpURLDewR68OScWJC2QGfPD@mail.gmail.com>
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
	<AANLkTi=DYfXubPH0fkwFQSHHqW64tQ11K-yKCfx9PVMv@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:56314 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753103Ab1CHRtG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 Mar 2011 12:49:06 -0500
In-Reply-To: <AANLkTi=DYfXubPH0fkwFQSHHqW64tQ11K-yKCfx9PVMv@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Cohen <dacohen@gmail.com>
Cc: Sakari Ailus <sakari.ailus@maxwell.research.nokia.com>, Michael Jones <michael.jones@matrix-vision.de>, Hiroshi.DOYU@nokia.com, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linux Media Mailing List <linux-media@vger.kernel.org>, linux-omap@vger.kernel.org

On Tue, Mar 8, 2011 at 3:55 AM, David Cohen <dacohen@gmail.com> wrote:
> Hi Fernando,
>
> On Tue, Mar 8, 2011 at 11:13 AM, Sakari Ailus
> <sakari.ailus@maxwell.research.nokia.com> wrote:
>> Guzman Lugo, Fernando wrote:
>>> On Mon, Mar 7, 2011 at 1:19 PM, David Cohen <dacohen@gmail.com> wro=
te:
>>>> On Mon, Mar 7, 2011 at 9:17 PM, Guzman Lugo, Fernando
>>>> <fernando.lugo@ti.com> wrote:
>>>>> On Mon, Mar 7, 2011 at 7:10 AM, Michael Jones
>>>>> <michael.jones@matrix-vision.de> wrote:
>>>>>> From e7dbe4c4b64eb114f9b0804d6af3a3ca0e78acc8 Mon Sep 17 00:00:0=
0 2001
>>>>>> From: Michael Jones <michael.jones@matrix-vision.de>
>>>>>> Date: Mon, 7 Mar 2011 13:36:15 +0100
>>>>>> Subject: [PATCH] omap: iommu: disallow mapping NULL address
>>>>>>
>>>>>> commit c7f4ab26e3bcdaeb3e19ec658e3ad9092f1a6ceb allowed mapping
>>>>>> the NULL address if da_start=3D=3D0. =A0Force da_start to exclud=
e the
>>>>>> first page.
>>>>>
>>>>> what about devices that uses page 0? ipu after reset always start=
s
>>>>> from 0x00000000 how could we map that address??
>>>>
>>>> from 0x0? The driver sees da =3D=3D 0 as error. May I ask you why =
do you want it?
>>>
>>> unlike DSP that you can load a register with the addres the DSP wil=
l
>>> boot, IPU core always starts from address 0x00000000, so if you tak=
e
>>> IPU out of reset it will try to access address 0x0 if not map it,
>>> there will be a mmu fault.
>>
>> I think the driver for IPU (what is it, btw.?) must map the NULL add=
ress
>> explicitly. It cannot rely on automatic allocation of the NULL addre=
ss
>> by the iommu even if it was the first allocation.
>
> That's an interesting question. My first thought was "it's not
> automatic allocation", because it seems you know the specific 'da' IP=
U
> needs. But then, looking into the driver's API, the automatic
> allocation is defined whether the argument da =3D=3D 0 (automatic
> allocation) or da !=3D 0 (fixed da). So, by default, the IOMMU driver
> does not see da =3D=3D 0 as valid address for fixed da. Then, why onl=
y
> automatic allocation should use such address? My second point is: if
> you're using automatic allocation, you *cannot* rely on specific da t=
o
> be used, as it would be up to IOMMU driver to choose. So, doesn't
> matter the option, your driver seems to be wrong, unless I'm missing
> something. If you were using fixed da passing da =3D 0, you were just
> being lucky that it was the first request and automatic allocation
> returned da =3D=3D 0.

yes, the driver is wrong, it should use only flag IOVMF_DA_ANON to get
an automatic address. it has to be changed too.

Regards,
=46ernando.

> IMO either first page is not allowed at all or OMAP's IOMMU API shoul=
d
> change the way it checks if it's fixed da or not.
>
> Kind regards,
>
> David
>
>>
>> --
>> Sakari Ailus
>> sakari.ailus@maxwell.research.nokia.com
>>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
