From: Kevin Hilman <khilman@ti.com>
Subject: Re: [RFC 2/5] ARM: OMAP: omap_device: add a method to set iommu private archdata
Date: Tue, 04 Oct 2011 11:15:59 -0700
Message-ID: <87botwk4gw.fsf@ti.com>
References: <1316948337-7924-1-git-send-email-ohad@wizery.com>
	<1316948337-7924-3-git-send-email-ohad@wizery.com>
	<87sjni9aql.fsf@ti.com>
	<CAK=WgbZhz8LcAYZEY3qqRkX4E_wtspWp09Eq9G=5VdpoMMF1FQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK=WgbZhz8LcAYZEY3qqRkX4E_wtspWp09Eq9G=5VdpoMMF1FQ@mail.gmail.com>
	(Ohad Ben-Cohen's message of "Tue, 27 Sep 2011 21:09:57 +0300")
Sender: linux-kernel-owner@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Joerg Roedel <Joerg.Roedel@amd.com>, iommu@lists.linux-foundation.org, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, Cousson Benoit <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@secretlab.ca>
List-Id: linux-omap@vger.kernel.org

Ohad Ben-Cohen <ohad@wizery.com> writes:

> Hi Kevin,
>
> On Tue, Sep 27, 2011 at 1:53 AM, Kevin Hilman <khilman@ti.com> wrote:
>> Benoit did just this in preparation for DT.
>>
>> =C2=A0 =C2=A0 =C2=A0 http://marc.info/?l=3Dlinux-omap&m=3D1316724801=
11927&w=3D2
>>
>> Will that meet your needs?
>
> It's almost there, but not entirely.
>
> Benoit's alloc/delete functions focus on the omap_device part, leavin=
g
> the handling of the platform device (allocation and pdata setting) to
> omap_device_build_ss(), which at the same time registers the pdev.
>
> I'd need to split omap_device_build_ss() into two: an alloc() part
> which does everything but registering the pdev, and a register() part=
=2E
> Users will first call alloc(), manually set archdata members, and the=
n
> call the register() part.
>
> Something like this (compile-tested only, based on Benoit's
> for_3.2/4_omap4_dt_early_devices branch):

[...]

> That's the idea; please tell me how you'd like to see this go forward
> (there are at least several personal-taste issues here, e.g., naming:
> now we have two sets of alloc/delete functions which have different
> semantics)=20

The approach is OK with me, but I'm a bit torn about whether or not to
merge this since the need for this should go away when converting to DT=
=2E
Is anyone working on IOMMU DT description?

I guess if I do merge this, we can also clean this up significantly
after all devices are converted to DT.

> and which branch would you like me to base this work off of
> (not sure if Benoit's patches already went into your
> for_3.2/omap_device branch) and I'll respin this patch properly.

Unless it has other dependencies on Benoit's further DT patches, you ca=
n
base this on my for_3.2/omap_device-2 branch which includes Benoit's
alloc changes.

Kevin
