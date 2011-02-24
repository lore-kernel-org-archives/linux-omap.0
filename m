From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: Re: Ping-> Subject: [PATCH] omap: omap3evm: add support for the
 WL12xx WLAN module to the omap3evm
Date: Thu, 24 Feb 2011 14:24:12 -0800
Message-ID: <AANLkTi=d=xBiaXkO+Hgx7PM7Cv7f-yJtJixe_DG89RJJ@mail.gmail.com>
References: <EC51CDB0807A51469E0C9CB8CF72D65F032D73AA68@dnce02.ent.ti.com>
 <20110217222027.GD20795@atomide.com> <EC51CDB0807A51469E0C9CB8CF72D65F033179C278@dnce02.ent.ti.com>
 <20110223214903.GB30316@atomide.com> <EC51CDB0807A51469E0C9CB8CF72D65F0331870D78@dnce02.ent.ti.com>
 <20110224214747.GR20560@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:34338 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754399Ab1BXWYc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Feb 2011 17:24:32 -0500
Received: by iyb26 with SMTP id 26so563264iyb.19
        for <linux-omap@vger.kernel.org>; Thu, 24 Feb 2011 14:24:32 -0800 (PST)
In-Reply-To: <20110224214747.GR20560@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Reizer, Eyal" <eyalr@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

Hi Eyal,

On Thu, Feb 24, 2011 at 1:47 PM, Tony Lindgren <tony@atomide.com> wrote=
:
> Sorry still can't get this one to apply. Can you please rebase
> this on top of the current omap-for-linus branch?
=2E..
>> +#include <linux/wl12xx.h>
=2E..
>> +struct wl12xx_platform_data omap3evm_wlan_data __initdata =3D {
>> + =A0 =A0 =A0 .irq =3D OMAP_GPIO_IRQ(OMAP3EVM_WLAN_IRQ_GPIO),
>> + =A0 =A0 =A0 .board_ref_clock =3D 2, /* ref clock is 38.4 MHz */
>> +};

If you're anyway resubmitting the patch, could you please use
WL12XX_REFCLOCK_38 (defined in linux/wl12xx.h) instead of the direct
value ? It will make it easier for others to understand where is this
value taken from, and how to port it to other boards.

Thanks,
Ohad.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
