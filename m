From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH 1/2] omap: mailbox: initial hwmod support
Date: Tue, 25 May 2010 18:23:48 +0300
Message-ID: <AANLkTikXZRPJIeZcnUBdegFTnHIOaXUL9Ukns45GO1bh@mail.gmail.com>
References: <1274549122-26521-1-git-send-email-felipe.contreras@gmail.com>
	 <1274549122-26521-2-git-send-email-felipe.contreras@gmail.com>
	 <871vd0voiu.fsf@deeprootsystems.com>
	 <AANLkTilI_Fqlz9Bj6WDxahheVODv-OZEQcacWw4dz6dV@mail.gmail.com>
	 <87bpc4qbnb.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:53319 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757090Ab0EYPXt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 May 2010 11:23:49 -0400
Received: by bwz7 with SMTP id 7so1319878bwz.19
        for <linux-omap@vger.kernel.org>; Tue, 25 May 2010 08:23:48 -0700 (PDT)
In-Reply-To: <87bpc4qbnb.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, Paul Walmsley <paul@pwsan.com>, Ohad Ben-Cohen <ohad@wizery.com>

On Tue, May 25, 2010 at 5:49 PM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Tue, May 25, 2010 at 3:00 AM, Kevin Hilman
>> <khilman@deeprootsystems.com> wrote:
>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>>
>>>> Only OMAP3 would work.
>>>>
>>>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>>>> ---
>>>> =C2=A0arch/arm/mach-omap2/devices.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0| =C2=A0103 +++++----------------------
>>>> =C2=A0arch/arm/mach-omap2/mailbox.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0| =C2=A0 14 +---
>>>> =C2=A0arch/arm/mach-omap2/omap_hwmod_3xxx_data.c | =C2=A0 45 +++++=
+++++++
>>>> =C2=A0arch/arm/plat-omap/include/plat/mailbox.h =C2=A0| =C2=A0 =C2=
=A04 +
>>>> =C2=A04 files changed, 72 insertions(+), 94 deletions(-)
>>>>
>>>> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/d=
evices.c
>>>> index d9ac853..89f6cbc 100644
>>>> --- a/arch/arm/mach-omap2/devices.c
>>>> +++ b/arch/arm/mach-omap2/devices.c
>>>> @@ -20,12 +20,14 @@
>>>> =C2=A0#include <asm/mach-types.h>
>>>> =C2=A0#include <asm/mach/map.h>
>>>>
>>>> +#include <plat/omap_device.h>
>>>> =C2=A0#include <plat/control.h>
>>>> =C2=A0#include <plat/tc.h>
>>>> =C2=A0#include <plat/board.h>
>>>> =C2=A0#include <plat/mux.h>
>>>> =C2=A0#include <mach/gpio.h>
>>>> =C2=A0#include <plat/mmc.h>
>>>> +#include <plat/mailbox.h>
>>>>
>>>> =C2=A0#include "mux.h"
>>>>
>>>> @@ -137,95 +139,28 @@ static inline void omap_init_camera(void)
>>>> =C2=A0#endif
>>>>
>>>> =C2=A0#if defined(CONFIG_OMAP_MBOX_FWK) || defined(CONFIG_OMAP_MBO=
X_FWK_MODULE)
>>>> +static inline void omap_init_mbox(void)
>>>> +{
>>>> + =C2=A0 =C2=A0 struct omap_hwmod *hwmod;
>>>> + =C2=A0 =C2=A0 struct omap_device *odev;
>>>> + =C2=A0 =C2=A0 struct omap_mbox_platform_data pdata;
>> ...
>>
>>>> + =C2=A0 =C2=A0 hwmod =3D omap_hwmod_lookup("mailbox");
>>>> + =C2=A0 =C2=A0 if (!hwmod) {
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_err("%s: unable to =
find hwmod\n", __func__);
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
>>>> + =C2=A0 =C2=A0 }
>>>>
>>>> -static struct platform_device mbox_device =3D {
>>>> - =C2=A0 =C2=A0 .name =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D "omap=
-mailbox",
>>>> - =C2=A0 =C2=A0 .id =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D =
-1,
>>>> -};
>>>> + =C2=A0 =C2=A0 pdata.base_addr =3D hwmod->_rt_va;
>>>
>>> Shouldn't need the base address in pdata. =C2=A0The driver should j=
ust do a
>>> platform_get_resource() to get the physical address and then iorema=
p.
>>
>> But the hwmod code already did ioremap in _find_mpu_rt_base().
>
> Yes, but that's a hwmod-internal implementation detail that may
> change, or may not be needed for some hwmods, or may be iounmapped
> after hwmod init etc.

So I have to do another ioremap()?

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
