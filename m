From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH 0/3] omap3-iommu: cleanups and remote registration
Date: Mon, 18 May 2009 14:51:06 +0300
Message-ID: <94a0d4530905180451g7213887exb466dde18f358897@mail.gmail.com>
References: <20090516163635.GB25657@n2100.arm.linux.org.uk>
	 <94a0d4530905161132j23b109bbj6d62f7ff9fac8c7f@mail.gmail.com>
	 <20090518.081627.200381155.Hiroshi.DOYU@nokia.com>
	 <20090518.083341.233686060.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:54835 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752494AbZERLvI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 May 2009 07:51:08 -0400
Received: by fg-out-1718.google.com with SMTP id d23so599528fga.17
        for <linux-omap@vger.kernel.org>; Mon, 18 May 2009 04:51:07 -0700 (PDT)
In-Reply-To: <20090518.083341.233686060.Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux@arm.linux.org.uk, linux-omap@vger.kernel.org, h-kanigeri2@ti.com, linux-arm-kernel@lists.arm.linux.org.uk

On Mon, May 18, 2009 at 8:33 AM, Hiroshi DOYU <Hiroshi.DOYU@nokia.com> =
wrote:
> From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> Subject: Re: [RFC/PATCH 0/3] omap3-iommu: cleanups and remote registr=
ation
> Date: Mon, 18 May 2009 08:16:27 +0300 (EEST)
>
>> From: ext Felipe Contreras <felipe.contreras@gmail.com>
>> Subject: Re: [RFC/PATCH 0/3] omap3-iommu: cleanups and remote regist=
ration
>> Date: Sat, 16 May 2009 20:32:10 +0200
>>
>> > On Sat, May 16, 2009 at 7:36 PM, Russell King - ARM Linux
>> > <linux@arm.linux.org.uk> wrote:
>> > > On Sat, May 16, 2009 at 01:05:47PM +0300, Felipe Contreras wrote=
:
>> > >> This patch series cleanups up a bit the opap3-iommu device regi=
stration and
>> > >> then allows registration from other parts of the code.
>> > >>
>> > >> Currently the iva2 code (tidspbridge) is not using iommu, there=
fore it can't be
>> > >> used as-is with the current omap iommu. By allowing devies to b=
e registered
>> > >> externaly (either isp, or iva2) this problem goes away.
>> > >
>> > > Hmm, so does this mean that the iommu patchset is going to grow =
by three
>> > > patches? =C2=A0Hope not.
>>
>> This series has been posted for a long time and I want to get this i=
n
>> this time with minor fixes.
>>
>> > I hope Hiroshi integrates my patches.
>>
>> I think that the problem of yours is that it's not necesary to allow
>> device registration around kernel anywhere by "omap_iommu_add()" at
>> all, but enough only in "omap3-iommu.c". Since eventually
>> "tidspbridge" will use this iommu framework, no need for this
>> flexibility. Keeping same kind of device registration in one place i=
s
>> good thing from SoC perspective. So I want to avoid adding unnecessa=
ry
>> flexibility to the code. I'll follow Russell's call, anyway.
>
> The other thing is about introducing a new structure type, "struct
> iommu_device". I don't want to define new structure type just for thi=
s
> device registration. Since device registration part is kind of
> conventional one in kernel, I want to keep things simple/conventional
> as much as possible.

It is an *internal* structure, just like you local 'omap3_iommu_pdata'
nobody has not know about it outside omap3-iommu.c.

The exported function is:
struct platform_device *omap_iommu_add(const char *name);

Nothing custom there.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
