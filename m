From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: Re: [PATCH v5 3/5] OMAP4: hwmod data: add mailbox data
Date: Tue, 15 Feb 2011 15:55:41 -0600
Message-ID: <AANLkTinA2a60TSM7qDC1LQiRaUTs0DR3bDMv+oVsVOE0@mail.gmail.com>
References: <1296674843-12718-1-git-send-email-omar.ramirez@ti.com>
	<1296674843-12718-4-git-send-email-omar.ramirez@ti.com>
	<4D5943A9.8010205@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:37832 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755670Ab1BOVzo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Feb 2011 16:55:44 -0500
Received: by mail-gw0-f51.google.com with SMTP id a20so312058gwa.10
        for <linux-omap@vger.kernel.org>; Tue, 15 Feb 2011 13:55:41 -0800 (PST)
In-Reply-To: <4D5943A9.8010205@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, lo <linux-omap@vger.kernel.org>, lak <linux-arm-kernel@lists.infradead.org>

Hi Benoit,

On Mon, Feb 14, 2011 at 9:00 AM, Cousson, Benoit <b-cousson@ti.com> wro=
te:
>> +static struct omap_hwmod_irq_info omap44xx_mailbox_irqs[] =3D {
>> + =A0 =A0 =A0 { .name =3D "mbox", .irq =3D 26 + OMAP44XX_IRQ_GIC_STA=
RT, },
>
> The original entry was unnamed since it is an unique entry and thus d=
oes not
> need to be differentiate on this platform.
>
> =A0 =A0 =A0 =A0{ .irq =3D 26 + OMAP44XX_IRQ_GIC_START },
>
> Do you really need to have a name here? The strategy being to provide=
 a name
> only if more than one entry exist.
> It is perfectibility doable, I'm just trying to understand your ratio=
nal.

It is this way instead of plain platform_get_irq because omap2420 has
two interrupt sources to MPU and mailbox driver uses
platform_get_irq_byname to get the irq number.

Regards,

Omar
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
