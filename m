From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [RFC/PATCH 1/2] omap: mailbox: initial hwmod support
Date: Tue, 25 May 2010 07:49:44 -0700
Message-ID: <87bpc4qbnb.fsf@deeprootsystems.com>
References: <1274549122-26521-1-git-send-email-felipe.contreras@gmail.com>
	<1274549122-26521-2-git-send-email-felipe.contreras@gmail.com>
	<871vd0voiu.fsf@deeprootsystems.com>
	<AANLkTilI_Fqlz9Bj6WDxahheVODv-OZEQcacWw4dz6dV@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:37078 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757005Ab0EYOts convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 May 2010 10:49:48 -0400
Received: by pwi2 with SMTP id 2so1078152pwi.19
        for <linux-omap@vger.kernel.org>; Tue, 25 May 2010 07:49:47 -0700 (PDT)
In-Reply-To: <AANLkTilI_Fqlz9Bj6WDxahheVODv-OZEQcacWw4dz6dV@mail.gmail.com> (Felipe Contreras's message of "Tue\, 25 May 2010 03\:29\:33 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, Paul Walmsley <paul@pwsan.com>, Ohad Ben-Cohen <ohad@wizery.com>

=46elipe Contreras <felipe.contreras@gmail.com> writes:

> On Tue, May 25, 2010 at 3:00 AM, Kevin Hilman
> <khilman@deeprootsystems.com> wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>> Only OMAP3 would work.
>>>
>>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>>> ---
>>> =A0arch/arm/mach-omap2/devices.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A010=
3 +++++----------------------
>>> =A0arch/arm/mach-omap2/mailbox.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 1=
4 +---
>>> =A0arch/arm/mach-omap2/omap_hwmod_3xxx_data.c | =A0 45 ++++++++++++
>>> =A0arch/arm/plat-omap/include/plat/mailbox.h =A0| =A0 =A04 +
>>> =A04 files changed, 72 insertions(+), 94 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/de=
vices.c
>>> index d9ac853..89f6cbc 100644
>>> --- a/arch/arm/mach-omap2/devices.c
>>> +++ b/arch/arm/mach-omap2/devices.c
>>> @@ -20,12 +20,14 @@
>>> =A0#include <asm/mach-types.h>
>>> =A0#include <asm/mach/map.h>
>>>
>>> +#include <plat/omap_device.h>
>>> =A0#include <plat/control.h>
>>> =A0#include <plat/tc.h>
>>> =A0#include <plat/board.h>
>>> =A0#include <plat/mux.h>
>>> =A0#include <mach/gpio.h>
>>> =A0#include <plat/mmc.h>
>>> +#include <plat/mailbox.h>
>>>
>>> =A0#include "mux.h"
>>>
>>> @@ -137,95 +139,28 @@ static inline void omap_init_camera(void)
>>> =A0#endif
>>>
>>> =A0#if defined(CONFIG_OMAP_MBOX_FWK) || defined(CONFIG_OMAP_MBOX_FW=
K_MODULE)
>>> +static inline void omap_init_mbox(void)
>>> +{
>>> + =A0 =A0 struct omap_hwmod *hwmod;
>>> + =A0 =A0 struct omap_device *odev;
>>> + =A0 =A0 struct omap_mbox_platform_data pdata;
> ...
>
>>> + =A0 =A0 hwmod =3D omap_hwmod_lookup("mailbox");
>>> + =A0 =A0 if (!hwmod) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: unable to find hwmod\n", __fu=
nc__);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>>> + =A0 =A0 }
>>>
>>> -static struct platform_device mbox_device =3D {
>>> - =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "omap-mailbox",
>>> - =A0 =A0 .id =A0 =A0 =A0 =A0 =A0 =A0 =3D -1,
>>> -};
>>> + =A0 =A0 pdata.base_addr =3D hwmod->_rt_va;
>>
>> Shouldn't need the base address in pdata. =A0The driver should just =
do a
>> platform_get_resource() to get the physical address and then ioremap=
=2E
>
> But the hwmod code already did ioremap in _find_mpu_rt_base().

Yes, but that's a hwmod-internal implementation detail that may
change, or may not be needed for some hwmods, or may be iounmapped
after hwmod init etc.

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
