From: David Cohen <dacohen@gmail.com>
Subject: Re: [PATCH 0/4] iommu: Prevent oops in iommu_get() and while
 arch_iommu is in use
Date: Mon, 28 Mar 2011 12:02:52 +0300
Message-ID: <AANLkTi=22HRXP8ij4f0FAyMxFXoQBRavRhx93jQYH3kQ@mail.gmail.com>
References: <4D8CB106.7030608@maxwell.research.nokia.com>
	<AANLkTikxd4kRu1+XskohhQzpqHaZTvK+afbgE-qRSOqN@mail.gmail.com>
	<4D8F738D.3090100@maxwell.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:38054 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753269Ab1C1JCy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Mar 2011 05:02:54 -0400
Received: by wya21 with SMTP id 21so2640908wya.19
        for <linux-omap@vger.kernel.org>; Mon, 28 Mar 2011 02:02:53 -0700 (PDT)
In-Reply-To: <4D8F738D.3090100@maxwell.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sakari Ailus <sakari.ailus@maxwell.research.nokia.com>
Cc: "Ramirez Luna, Omar" <omar.ramirez@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Cohen David Abraham <david.cohen@nokia.com>

Hi Sakari,

On Sun, Mar 27, 2011 at 8:27 PM, Sakari Ailus
<sakari.ailus@maxwell.research.nokia.com> wrote:
> Ramirez Luna, Omar wrote:
>> On Fri, Mar 25, 2011 at 10:13 AM, Sakari Ailus
>> <sakari.ailus@maxwell.research.nokia.com> wrote:
>>> Hi,
>>>
>>> This patchset is aimed to fix a problem in arch_iommu implementatio=
n
>>> references. When an actual arch_iommu implementation is not loaded =
while
>>> iommu_get() is being called results to a kernel oops, as well as
>>> removing an arch_iommu implementation which is in use.
>>
>> How about fixing the dependency instead? Right now iommu2 depends on
>> iommu because of the calls to
>> install_iommu_arch/uninstall_iommu_arch... we should change that
>> dependency to iommu depend on iommu2. Something like iommu (plat)
>> querying iommu2 (mach) for devices to install.
>
> There is no direct dependency from a driver using the generic API to =
a
> particular implementation of the iommu. This comes from the design of
> the iommu framework. The generic layer shouldn't depend on particular
> implementation(s).
>
> What comes to the patch, it works as long as there's only one iommu
> implementation loaded / compiled to the kernel. I wonder if this kind=
 of
> limitation can be accepted.

The generic iommu driver cannot support more than one implementation
loaded at the same time, so your patch is correct by assuming it.

Regards,

David Cohen

>
> Regards,
>
> --
> Sakari Ailus
> sakari.ailus@maxwell.research.nokia.com
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
