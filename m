From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: Re: [PATCH 0/4] iommu: Prevent oops in iommu_get() and while
 arch_iommu is in use
Date: Sun, 27 Mar 2011 20:42:23 -0500
Message-ID: <AANLkTi=_ZzpkP3vvKhu8AKa-66MG11nbVZwGOjpC87pL@mail.gmail.com>
References: <4D8CB106.7030608@maxwell.research.nokia.com>
	<AANLkTikxd4kRu1+XskohhQzpqHaZTvK+afbgE-qRSOqN@mail.gmail.com>
	<4D8F738D.3090100@maxwell.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:37462 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753056Ab1C1Bm0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sun, 27 Mar 2011 21:42:26 -0400
Received: by mail-ww0-f53.google.com with SMTP id 40so2811432wwj.22
        for <linux-omap@vger.kernel.org>; Sun, 27 Mar 2011 18:42:24 -0700 (PDT)
In-Reply-To: <4D8F738D.3090100@maxwell.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sakari Ailus <sakari.ailus@maxwell.research.nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Cohen David Abraham <david.cohen@nokia.com>

Hi,

On Sun, Mar 27, 2011 at 12:27 PM, Sakari Ailus
<sakari.ailus@maxwell.research.nokia.com> wrote:
> Ramirez Luna, Omar wrote:
>> On Fri, Mar 25, 2011 at 10:13 AM, Sakari Ailus
>> <sakari.ailus@maxwell.research.nokia.com> wrote:
>>> This patchset is aimed to fix a problem in arch_iommu implementation
>>> references. When an actual arch_iommu implementation is not loaded while
>>> iommu_get() is being called results to a kernel oops, as well as
>>> removing an arch_iommu implementation which is in use.
>>
>> How about fixing the dependency instead? Right now iommu2 depends on
>> iommu because of the calls to
>> install_iommu_arch/uninstall_iommu_arch... we should change that
>> dependency to iommu depend on iommu2. Something like iommu (plat)
>> querying iommu2 (mach) for devices to install.
>
> There is no direct dependency from a driver using the generic API to a
> particular implementation of the iommu. This comes from the design of
> the iommu framework. The generic layer shouldn't depend on particular
> implementation(s).

IMHO there is, take as an example bridgedriver (it is arm/omap
dependent), so it depends on iommu providing the mach-omap2
implementation. I imagine isp for omap imposes the same dependency,
even more your patchset enforces that dependency.

Basically, if there is no "arch_iommu" the iommu driver does not work,
and if there was an "arch_iommu" but it was removed then the driver
crashes.

Now, there could be architectures that does not depend on a particular
implementation but this iommu driver doesn't support them because if
there is no arch_iommu operations, it does nothing or crashes.

> What comes to the patch, it works as long as there's only one iommu
> implementation loaded / compiled to the kernel. I wonder if this kind of
> limitation can be accepted.

Which is the way iommu choose to work, like I said if there is no
arch_iommu nothing works, most of APIs in iommu depend on an machine
specific implementation. To fix that it is not the scope of my
proposal.

If indeed iommu can function without a machine specific implementation
then a redesign needs to be made, but to me the same approach as I did
needs to be followed: if there is mach implementation (e.g.: iommu2.c)
the generic API needs to depend on it, otherwise the module can be
removed and crash the kernel; OTOH if there is no mach implementation,
then iommu should not depend on it to be installed as you point out,
this could be handled in plat/iommu.h among with:

#if defined(CONFIG_ARCH_OMAP1)
#error "iommu for this processor not implemented yet"
#else
#include <plat/iommu2.h>
#endif

A new else defining the install/uninstall_arch_iommu functions or
simply reversing the check to be OMAP2+ and error on anything else.

Regards,

Omar
