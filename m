From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH 3/3] omap3-iommu: remote registration
Date: Mon, 18 May 2009 17:00:40 +0300
Message-ID: <94a0d4530905180700m69254928v15c6d68f863c81bf@mail.gmail.com>
References: <1242468350-23190-1-git-send-email-felipe.contreras@gmail.com>
	 <1242468350-23190-2-git-send-email-felipe.contreras@gmail.com>
	 <1242468350-23190-3-git-send-email-felipe.contreras@gmail.com>
	 <1242468350-23190-4-git-send-email-felipe.contreras@gmail.com>
	 <20090518121113.GB3067@n2100.arm.linux.org.uk>
	 <94a0d4530905180546p47c887afj109b3b60cdd24a00@mail.gmail.com>
	 <20090518130233.GD3067@n2100.arm.linux.org.uk>
	 <94a0d4530905180621r35eebdf2o2f9b0b3e107e77a@mail.gmail.com>
	 <20090518134018.GI3067@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.154]:19662 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752896AbZEROAm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 May 2009 10:00:42 -0400
Received: by fg-out-1718.google.com with SMTP id 16so1170769fgg.17
        for <linux-omap@vger.kernel.org>; Mon, 18 May 2009 07:00:41 -0700 (PDT)
In-Reply-To: <20090518134018.GI3067@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, Hiroshi DOYU <hiroshi.doyu@nokia.com>, Hari Kanigeri <h-kanigeri2@ti.com>, linux-arm-kernel@lists.arm.linux.org.uk

On Mon, May 18, 2009 at 4:40 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, May 18, 2009 at 04:21:19PM +0300, Felipe Contreras wrote:
>> On Mon, May 18, 2009 at 4:02 PM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>> > On Mon, May 18, 2009 at 03:46:07PM +0300, Felipe Contreras wrote:
>> >> On Mon, May 18, 2009 at 3:11 PM, Russell King - ARM Linux
>> >> <linux@arm.linux.org.uk> wrote:
>> >> > The real problem here seems to be the TI DSP bridge code, and i=
f that's
>> >> > the case why can't we just avoid registering IVA2 if the TI DSP=
 bridge
>> >> > code is enabled. =C2=A0That solves your stated problem without =
creating
>> >> > additional management issues.
>> >>
>> >> The bridgedriver is expected to move and use iommu eventually, bu=
t not
>> >> right now, so I guess the iva2 device should be registered only i=
f
>> >> MPU_BRIDGE_IOMMU is defined.
>> >>
>> >> But then what's the point of having the isp iommu device if the c=
amera
>> >> driver is disabled? Wouldn't that be wasting resources? Then if C=
AMERA
>> >> is not defined the isp device should not be registered either.
>> >
>> > So have something like:
>> >
>> > config OMAP_IOMMU
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0tristate
>> >
>> > and then have both MPU_BRIDGE_IOMMU and the camera support (and wh=
atever
>> > else) select it. =C2=A0That way, you only end up with the IOMMU su=
pport code
>> > built into the kernel if you have users of it.
>> >
>> > These low-level internal services drivers really don't need to be
>> > publically visible in the configuration system.
>>
>> Yeap, that needs to be done too.
>>
>> > As for the run-time size, that's truely minimal.
>>
>> I thought creating iommu devices involved some kind of overhead,
>> allocating some resources probably. That's why the iva2 iommu device
>> conflicts with tidspbridge custom mmu.
>
> I believe I've already said how to handle that - in fact it's in the
> quoted messages at the top of this mail.
>
>> >> And finally if none of the two are enabled then you don't really
>> >> iommu. By having omap_iommu_add all the dependencies would be han=
dled
>> >> automatically, right? 'modprobe bridgedriver' would load iommu.
>> >
>> > Think about it - the dependencies _already_ have to be there to us=
e
>> > the iommu services.
>>
>> Ok, yes, for iommu, but not for omap3-iommu which is a separate modu=
le.
>
> That is a point, but I think it's a relatively minor one. =C2=A0We co=
uld
> get around that by ensuring that omap3-iommu is always built-in if
> we have the possibility of iommu support, and leave iommu as a module=
=2E

You mean omap3-iommu will be built-in in the iommu module?

That looks ok to me, *if* it's true that iommu devices don't waste any
significant resources if nobody is using them.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
