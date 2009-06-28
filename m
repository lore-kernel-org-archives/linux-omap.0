From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH 0/3] omap3-iommu: cleanups and remote registration
Date: Sun, 28 Jun 2009 03:18:38 +0300
Message-ID: <94a0d4530906271718m2eda8787x54806737ecf5c38f@mail.gmail.com>
References: <94a0d4530905161132j23b109bbj6d62f7ff9fac8c7f@mail.gmail.com>
	 <20090518.081627.200381155.Hiroshi.DOYU@nokia.com>
	 <94a0d4530905180448i344328e6hf3a1719b73721d75@mail.gmail.com>
	 <20090518.164849.70215248.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.155]:35648 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752171AbZF1ASg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 27 Jun 2009 20:18:36 -0400
Received: by fg-out-1718.google.com with SMTP id e12so246855fga.17
        for <linux-omap@vger.kernel.org>; Sat, 27 Jun 2009 17:18:38 -0700 (PDT)
In-Reply-To: <20090518.164849.70215248.Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux@arm.linux.org.uk, linux-omap@vger.kernel.org, h-kanigeri2@ti.com, linux-arm-kernel@lists.arm.linux.org.uk

On Mon, May 18, 2009 at 4:48 PM, Hiroshi DOYU<Hiroshi.DOYU@nokia.com> w=
rote:
> From: ext Felipe Contreras <felipe.contreras@gmail.com>
> Subject: Re: [RFC/PATCH 0/3] omap3-iommu: cleanups and remote registr=
ation
> Date: Mon, 18 May 2009 13:48:09 +0200
>
>> On Mon, May 18, 2009 at 8:16 AM, Hiroshi DOYU <Hiroshi.DOYU@nokia.co=
m> wrote:
>> > From: ext Felipe Contreras <felipe.contreras@gmail.com>
>> > Subject: Re: [RFC/PATCH 0/3] omap3-iommu: cleanups and remote regi=
stration
>> > Date: Sat, 16 May 2009 20:32:10 +0200
>> >
>> >> On Sat, May 16, 2009 at 7:36 PM, Russell King - ARM Linux
>> >> <linux@arm.linux.org.uk> wrote:
>> >> > On Sat, May 16, 2009 at 01:05:47PM +0300, Felipe Contreras wrot=
e:
>> >> >> This patch series cleanups up a bit the opap3-iommu device reg=
istration and
>> >> >> then allows registration from other parts of the code.
>> >> >>
>> >> >> Currently the iva2 code (tidspbridge) is not using iommu, ther=
efore it can't be
>> >> >> used as-is with the current omap iommu. By allowing devies to =
be registered
>> >> >> externaly (either isp, or iva2) this problem goes away.
>> >> >
>> >> > Hmm, so does this mean that the iommu patchset is going to grow=
 by three
>> >> > patches? =C2=A0Hope not.
>> >
>> > This series has been posted for a long time and I want to get this=
 in
>> > this time with minor fixes.
>> >
>> >> I hope Hiroshi integrates my patches.
>> >
>> > I think that the problem of yours is that it's not necesary to all=
ow
>> > device registration around kernel anywhere by "omap_iommu_add()" a=
t
>> > all, but enough only in "omap3-iommu.c". Since eventually
>> > "tidspbridge" will use this iommu framework, no need for this
>> > flexibility. Keeping same kind of device registration in one place=
 is
>> > good thing from SoC perspective. So I want to avoid adding unneces=
sary
>> > flexibility to the code. I'll follow Russell's call, anyway.
>>
>> The first patch has nothing to do with omap_iommu_add, it's just
>> cleanups, and you haven't provided any valid reason to reject them.
>
> Your code doesn't work since the other members of "struct resource"
> haven't been initilialized like:
>
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memset(res, 0, =C2=
=A0sizeof(res));

=46or the record, that's not true:

+               struct resource res[] =3D {
+                       { .flags =3D IORESOURCE_MEM },
+                       { .flags =3D IORESOURCE_IRQ },
+               };

Is perfectly fine because according to the C standard in section 6.7.8 =
#19:

The initialization shall occur in initializer list order, each
initializer provided for a
particular subobject overriding any previously listed initializer for
the same subobject;130)
all subobjects that are not initialized explicitly shall be
initialized implicitly the same as
objects that have static storage duration.

So the rest of the fields are initialized to 0.

Cheers.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
