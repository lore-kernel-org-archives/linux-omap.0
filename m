From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: Re: [PATCH 1/5] omap: mailbox: initial hwmod support for omap3
Date: Wed, 27 Oct 2010 06:50:34 -0500
Message-ID: <AANLkTik7p24f47ECYoh89gTHvvyctrNwfWrOS_1g8kYV@mail.gmail.com>
References: <1288129984-22957-1-git-send-email-omar.ramirez@ti.com>
	<1288129984-22957-2-git-send-email-omar.ramirez@ti.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB030D3105B4@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:33963 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754445Ab0J0Lug convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Oct 2010 07:50:36 -0400
Received: by wwe15 with SMTP id 15so680909wwe.1
        for <linux-omap@vger.kernel.org>; Wed, 27 Oct 2010 04:50:34 -0700 (PDT)
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB030D3105B4@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@gmail.com>, Dmitry Kasatkin <dmitry.kasatkin@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Anna, Suman" <s-anna@ti.com>, Paul Walmsley <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Raja, Govindraj" <govindraj.raja@ti.com>, "C.A, Subramaniam" <subramaniam.ca@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, Oct 27, 2010 at 12:07 AM, Varadarajan, Charulatha <charu@ti.com=
> wrote:
>> HWMOD support for omap3.
>
> Use "hwmod".

ok

=2E..
> This patch series breaks OMAP4 support.

indeed, I'll try to exercise a sanity use case with omap4 and its hwmod=
 data

>
> OMAP2 support is broken with this patch and the same is fixed
> in the next patch. Hence patch 2 should be ordered before patch 1.
>

Agree

>> --- a/arch/arm/mach-omap2/mailbox.c
>> +++ b/arch/arm/mach-omap2/mailbox.c
>> @@ -15,6 +15,7 @@
>> =A0#include <linux/platform_device.h>
>> =A0#include <linux/io.h>
>> =A0#include <plat/mailbox.h>
>> +#include <plat/omap_hwmod.h>
>
> Is this required? I do not see this file using any hwmod info.

might have been kept with the rebase, I'll check again

Regards,

Omar
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
