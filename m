From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCHv3 1/3] OMAP UART: Add omap-serial driver support.
Date: Thu, 26 Nov 2009 10:25:04 +0530
Message-ID: <d6a0f7aa0911252055u65cb6d10wdc956ff1e363d213@mail.gmail.com>
References: <35817.192.168.10.88.1256713980.squirrel@dbdmail.itg.ti.com>
	 <45113.192.168.10.88.1258095234.squirrel@dbdmail.itg.ti.com>
	 <1258996319.18407.49.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f192.google.com ([209.85.221.192]:47768 "EHLO
	mail-qy0-f192.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752398AbZKZEy7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Nov 2009 23:54:59 -0500
Received: by qyk30 with SMTP id 30so196851qyk.33
        for <linux-omap@vger.kernel.org>; Wed, 25 Nov 2009 20:55:04 -0800 (PST)
In-Reply-To: <1258996319.18407.49.camel@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dedekind1@gmail.com
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org

On Mon, Nov 23, 2009 at 10:41 PM, Artem Bityutskiy <dedekind1@gmail.com=
> wrote:
> On Fri, 2009-11-13 at 12:23 +0530, Govindraj.R wrote:
>> From 4756e3743c7acd2de1030b2bd432c1b19f0b9ff5 Mon Sep 17 00:00:00 20=
01
>> From: Govindraj R <govindraj.raja@ti.com>
>> Date: Fri, 13 Nov 2009 12:01:54 +0530
>> Subject: [PATCH] OMAP UART: Add omap-serial driver support.
>>
>> This patch adds support for OMAP3430-HIGH SPEED UART Controller.
>>
>> It adds support for the following features:
>> 1. It supports Interrupt mode and DMA mode of operation.
>> 2. Supports Hardware flow control and sofware flow control.
>> 3. Debug Console support on all UARTs.
>>
>> Signed-off-by: Govindraj R <govindraj.raja@ti.com>
>> ---
>> =C2=A0arch/arm/plat-omap/include/plat/omap-serial.h | =C2=A0115 +++
>> =C2=A0drivers/serial/Kconfig =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 23 +
>> =C2=A0drivers/serial/Makefile =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A01 +
>> =C2=A0drivers/serial/omap-serial.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 1330 +++++++++++++++++++++++++
>> =C2=A0include/linux/serial_core.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A03 +
>> =C2=A05 files changed, 1472 insertions(+), 0 deletions(-)
>> =C2=A0create mode 100644 arch/arm/plat-omap/include/plat/omap-serial=
=2Eh
>> =C2=A0create mode 100644 drivers/serial/omap-serial.c
>
> Did you address the irq storm problems pointed by Mika Westerberg?

that issue has been resolved with this current patch series.

---
Regards,
Govindraj.R


>
> --
> Best Regards,
> Artem Bityutskiy (=D0=90=D1=80=D1=82=D1=91=D0=BC =D0=91=D0=B8=D1=82=D1=
=8E=D1=86=D0=BA=D0=B8=D0=B9)
>
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
