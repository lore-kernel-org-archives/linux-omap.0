From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: Re: [PATCH v4 4/4] OMAP3/4: iommu: adapt to runtime pm
Date: Thu, 15 Dec 2011 21:18:01 -0600
Message-ID: <CAB-zwWhpmwRP2mNu-CdX-RVgmTRjw0UsYckAVsM+qztmVdvc7A@mail.gmail.com>
References: <1323922709-6986-1-git-send-email-omar.ramirez@ti.com>
	<1323922709-6986-5-git-send-email-omar.ramirez@ti.com>
	<CAMP44s3Jb9DZLUyDVU_HmQbaJKp=2qym7Z6uauNchJh0fPL4hQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:45769 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751629Ab1LPDSE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Dec 2011 22:18:04 -0500
In-Reply-To: <CAMP44s3Jb9DZLUyDVU_HmQbaJKp=2qym7Z6uauNchJh0fPL4hQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>, Russell King <linux@arm.linux.org.uk>, Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, iommu@lists.linux-foundation.org, MyungJoo Ham <myungjoo.ham@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Dec 15, 2011 at 6:53 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Thu, Dec 15, 2011 at 6:18 AM, Omar Ramirez Luna <omar.ramirez@ti.c=
om> wrote:
>> Use runtime PM functionality interfaced with hwmod enable/idle
>> functions, to replace direct clock operations, reset and sysconfig
>> handling.
>>
>> Removed clk handling during interrupt, given that in order to receiv=
e one,
>> the device should be powered on in advance. Now doing pm_runtime_get=
/put
>> on iommu_enable/disable so it doesn't rely on others to keep the clo=
cks on.
>>
>> Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/iommu2.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 17 ---=
--------
>> =A0arch/arm/mach-omap2/omap-iommu.c =A0 =A0 =A0 =A0 | =A0 =A01 -
>> =A0arch/arm/plat-omap/include/plat/iommu.h =A0| =A0 =A02 -
>> =A0arch/arm/plat-omap/include/plat/iommu2.h | =A0 =A02 -
>> =A0drivers/iommu/omap-iommu.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 44 +=
+++++++++++-----------------
>> =A05 files changed, 18 insertions(+), 48 deletions(-)
>
> Shouldn't pm_runtime_enable() be called in omap_iommu_init(), and
> omap_iommu_probe() call pm_runtime_get_sync()/put() on the sections
> where the device should be active?

omap_iommu_init is called on module init however omap_iommu_probe is
called by driver instance (isp, iva), on probe pm_runtime_enable
activates runtime for both isp and iva devices, one at a time.

Regards,

Omar
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
