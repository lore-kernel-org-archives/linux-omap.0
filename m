From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v4 4/4] OMAP3/4: iommu: adapt to runtime pm
Date: Fri, 23 Dec 2011 19:04:43 +0200
Message-ID: <CAMP44s2JWRN4XVCVrbVUJwZK9zkT6p2dPnK2SPuZXJPj71c4Yg@mail.gmail.com>
References: <1323922709-6986-1-git-send-email-omar.ramirez@ti.com>
	<1323922709-6986-5-git-send-email-omar.ramirez@ti.com>
	<CAMP44s3Jb9DZLUyDVU_HmQbaJKp=2qym7Z6uauNchJh0fPL4hQ@mail.gmail.com>
	<CAB-zwWhpmwRP2mNu-CdX-RVgmTRjw0UsYckAVsM+qztmVdvc7A@mail.gmail.com>
	<CAMP44s0hYWiZ8OnjQ6Jy_W7MCveP+WyHG18Tt2jRGzxSwoQP3w@mail.gmail.com>
	<CAB-zwWio5iMTyofv3Hx5Q7G7rYY5cRU4kXNQzMF0NRprEd8=5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:61873 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757465Ab1LWREp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Dec 2011 12:04:45 -0500
In-Reply-To: <CAB-zwWio5iMTyofv3Hx5Q7G7rYY5cRU4kXNQzMF0NRprEd8=5g@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>, Russell King <linux@arm.linux.org.uk>, Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, iommu@lists.linux-foundation.org, MyungJoo Ham <myungjoo.ham@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Paul Walmsley <paul@pwsan.com>

On Fri, Dec 23, 2011 at 6:30 PM, Ramirez Luna, Omar <omar.ramirez@ti.co=
m> wrote:
> On Mon, Dec 19, 2011 at 10:27 AM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> On Fri, Dec 16, 2011 at 5:18 AM, Ramirez Luna, Omar <omar.ramirez@ti=
=2Ecom> wrote:
>>> On Thu, Dec 15, 2011 at 6:53 PM, Felipe Contreras
>>> <felipe.contreras@gmail.com> wrote:
>>>> On Thu, Dec 15, 2011 at 6:18 AM, Omar Ramirez Luna <omar.ramirez@t=
i.com> wrote:
>>>>> Use runtime PM functionality interfaced with hwmod enable/idle
>>>>> functions, to replace direct clock operations, reset and sysconfi=
g
>>>>> handling.
>>>>>
>>>>> Removed clk handling during interrupt, given that in order to rec=
eive one,
>>>>> the device should be powered on in advance. Now doing pm_runtime_=
get/put
>>>>> on iommu_enable/disable so it doesn't rely on others to keep the =
clocks on.
>>>>>
>>>>> Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
>>>>> ---
>>>>> =C2=A0arch/arm/mach-omap2/iommu2.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | =C2=A0 17 -----------
>>>>> =C2=A0arch/arm/mach-omap2/omap-iommu.c =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 | =C2=A0 =C2=A01 -
>>>>> =C2=A0arch/arm/plat-omap/include/plat/iommu.h =C2=A0| =C2=A0 =C2=A0=
2 -
>>>>> =C2=A0arch/arm/plat-omap/include/plat/iommu2.h | =C2=A0 =C2=A02 -
>>>>> =C2=A0drivers/iommu/omap-iommu.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 | =C2=A0 44 ++++++++++++-----------------
>>>>> =C2=A05 files changed, 18 insertions(+), 48 deletions(-)
>>>>
>>>> Shouldn't pm_runtime_enable() be called in omap_iommu_init(), and
>>>> omap_iommu_probe() call pm_runtime_get_sync()/put() on the section=
s
>>>> where the device should be active?
>>>
>>> omap_iommu_init is called on module init however omap_iommu_probe i=
s
>>> called by driver instance (isp, iva), on probe pm_runtime_enable
>>> activates runtime for both isp and iva devices, one at a time.
>>
>> Yes, but omap_iommu_init() will *always* be called at boot time and
>> will register the data for all the devices.
>
> There are 2 omap_iommu_init :/ Thought you were talking about the one
> in drivers/iommu/omap-iommu.c.
>
>> If the 'iommu' module is
>> never loaded, then the devices will remain active the whole time.
>
> oma-iommu is meant to be built-in as part of the kernel, there is no
> option for module anymore.

Which omap-iommu? The platform driver, or the device stuff? The device
stuff is always built-in, but not the platform driver
(drivers/iommu/omap-iommu.c), that can be a module.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
