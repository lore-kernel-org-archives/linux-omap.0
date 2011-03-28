From: David Cohen <dacohen@gmail.com>
Subject: Re: [PATCH 0/4] iommu: Prevent oops in iommu_get() and while
 arch_iommu is in use
Date: Mon, 28 Mar 2011 12:20:30 +0300
Message-ID: <AANLkTi=EsDvcuO_Entun8gZUw723S7WXn4XbrO6V9--5@mail.gmail.com>
References: <4D8CB106.7030608@maxwell.research.nokia.com>
	<AANLkTikxd4kRu1+XskohhQzpqHaZTvK+afbgE-qRSOqN@mail.gmail.com>
	<4D8F738D.3090100@maxwell.research.nokia.com>
	<AANLkTi=_ZzpkP3vvKhu8AKa-66MG11nbVZwGOjpC87pL@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:54028 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751025Ab1C1JUb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Mar 2011 05:20:31 -0400
Received: by wwa36 with SMTP id 36so3554731wwa.1
        for <linux-omap@vger.kernel.org>; Mon, 28 Mar 2011 02:20:30 -0700 (PDT)
In-Reply-To: <AANLkTi=_ZzpkP3vvKhu8AKa-66MG11nbVZwGOjpC87pL@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: Sakari Ailus <sakari.ailus@maxwell.research.nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Cohen David Abraham <david.cohen@nokia.com>

On Mon, Mar 28, 2011 at 4:42 AM, Ramirez Luna, Omar <omar.ramirez@ti.co=
m> wrote:
> Hi,
>
> On Sun, Mar 27, 2011 at 12:27 PM, Sakari Ailus
> <sakari.ailus@maxwell.research.nokia.com> wrote:
>> Ramirez Luna, Omar wrote:
>>> On Fri, Mar 25, 2011 at 10:13 AM, Sakari Ailus
>>> <sakari.ailus@maxwell.research.nokia.com> wrote:
>>>> This patchset is aimed to fix a problem in arch_iommu implementati=
on
>>>> references. When an actual arch_iommu implementation is not loaded=
 while
>>>> iommu_get() is being called results to a kernel oops, as well as
>>>> removing an arch_iommu implementation which is in use.
>>>
>>> How about fixing the dependency instead? Right now iommu2 depends o=
n
>>> iommu because of the calls to
>>> install_iommu_arch/uninstall_iommu_arch... we should change that
>>> dependency to iommu depend on iommu2. Something like iommu (plat)
>>> querying iommu2 (mach) for devices to install.
>>
>> There is no direct dependency from a driver using the generic API to=
 a
>> particular implementation of the iommu. This comes from the design o=
f
>> the iommu framework. The generic layer shouldn't depend on particula=
r
>> implementation(s).
>
> IMHO there is, take as an example bridgedriver (it is arm/omap
> dependent), so it depends on iommu providing the mach-omap2
> implementation. I imagine isp for omap imposes the same dependency,
> even more your patchset enforces that dependency.

The generic layer can exist without a specific implementation. It
should accept later arch install/uninstall without any problem.

>
> Basically, if there is no "arch_iommu" the iommu driver does not work=
,
> and if there was an "arch_iommu" but it was removed then the driver
> crashes.

The loaded module *must* uninstall arch when existing, then kernel
will see no crash. And yes, generic layer won't work anymore but
that's an expected and correct situation.

>
> Now, there could be architectures that does not depend on a particula=
r
> implementation but this iommu driver doesn't support them because if
> there is no arch_iommu operations, it does nothing or crashes.
>
>> What comes to the patch, it works as long as there's only one iommu
>> implementation loaded / compiled to the kernel. I wonder if this kin=
d of
>> limitation can be accepted.
>
> Which is the way iommu choose to work, like I said if there is no
> arch_iommu nothing works, most of APIs in iommu depend on an machine
> specific implementation. To fix that it is not the scope of my
> proposal.
>
> If indeed iommu can function without a machine specific implementatio=
n
> then a redesign needs to be made, but to me the same approach as I di=
d
> needs to be followed: if there is mach implementation (e.g.: iommu2.c=
)
> the generic API needs to depend on it, otherwise the module can be
> removed and crash the kernel; OTOH if there is no mach implementation=
,
> then iommu should not depend on it to be installed as you point out,
> this could be handled in plat/iommu.h among with:
>
> #if defined(CONFIG_ARCH_OMAP1)
> #error "iommu for this processor not implemented yet"
> #else
> #include <plat/iommu2.h>
> #endif

So, every new specific implementation should modify this piece of
code? Are you sure it's a good idea?

Regards,

David Cohen

>
> A new else defining the install/uninstall_arch_iommu functions or
> simply reversing the check to be OMAP2+ and error on anything else.
>
> Regards,
>
> Omar
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
