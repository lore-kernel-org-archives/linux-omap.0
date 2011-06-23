From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCHv3 5/6] OMAP3: Serial: Made serial to work properly with
 PRCM chain handler
Date: Thu, 23 Jun 2011 16:05:01 +0530
Message-ID: <BANLkTin1u_tKN8mwM0xYhq=qjWkRfx8X2Q@mail.gmail.com>
References: <1308760934-9757-1-git-send-email-t-kristo@ti.com>
 <1308760934-9757-6-git-send-email-t-kristo@ti.com> <20110623082150.GX23145@atomide.com>
 <1308820284.5972.18.camel@sokoban> <20110623100054.GA23145@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:37587 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759222Ab1FWKfW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Jun 2011 06:35:22 -0400
Received: by bwz15 with SMTP id 15so1408566bwz.19
        for <linux-omap@vger.kernel.org>; Thu, 23 Jun 2011 03:35:21 -0700 (PDT)
In-Reply-To: <20110623100054.GA23145@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org

On Thu, Jun 23, 2011 at 3:30 PM, Tony Lindgren <tony@atomide.com> wrote=
:
> * Tero Kristo <t-kristo@ti.com> [110623 02:06]:
>> On Thu, 2011-06-23 at 10:21 +0200, Tony Lindgren wrote:
>> > * Tero Kristo <t-kristo@ti.com> [110622 09:38]:
>> > > @@ -550,6 +550,8 @@ static void omap_uart_idle_init(struct omap_=
uart_state *uart)
>> > > =A0 ret =3D request_threaded_irq(uart->irq, NULL, omap_uart_inte=
rrupt,
>> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0IRQF_=
SHARED, "serial idle", (void *)uart);
>> > > =A0 WARN_ON(ret);
>> > > + ret =3D omap_prcm_register_pad_irq(uart->padconf, uart->irq);
>> > > + WARN_ON(ret);
>> > > =A0}
>> >
>> > Argh, looks like we still have direct mux register tinkering in se=
rial.c:
>> >
>> > $ grep "padconf =3D 0x" serial.c
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 padconf =3D 0x182;
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 padconf =3D 0x17a;
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 padconf =3D 0x19e;
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 padconf =3D 0x0d2;
>> >
>> > By deducting 0x30 from the values above, these map into the follow=
ing mux defines:
>> >
>> > $ grep RX_OFFSET mux34xx.h
>> > #define OMAP3_CONTROL_PADCONF_UART2_RX_OFFSET =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 0x14a
>> > #define OMAP3_CONTROL_PADCONF_UART1_RX_OFFSET =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 0x152
>> > #define OMAP3_CONTROL_PADCONF_UART3_RX_IRRX_OFFSET =A0 =A0 =A0 =A0=
 =A0 =A0 =A00x16e
>> >
>> > So you can make things more generic by getting rid of those and us=
ing
>> > struct omap_mux_partition instead for omap_prcm_register_pad_irq.
>> > The pins used are set already in serial.c with omap_hwmod_mux_init=
=2E
>> >
>> > Otherwise we have to patch the hardcoded padconf values for every =
new omap.
>> > And looks like we're already missing them for 44xx in serial.c.
>> >
>> > Then access to the padconf registers should be done with
>> > omap_mux_read/write instead. If you need to do something more comp=
lex
>> > with them maybe consider adding some new functions to mux.c as nee=
ded.
>> >
>>
>> Padconf stuff is not that much related to this patch set yet (I am n=
ot
>> touching the serial padconf code), but I can probably take a look at
>> this also later on, unless you want this fixed with this set already=
?
>
> Yes please, maybe make it a separate patch before your series to
> prepare things?
>
> Otherwise we will have to change the omap_prcm_register_pad_irq
> later on in each driver using it.
>

Agree,
I am planning of use this call from omap-serial driver. :)

How about using omap_hwmod_mux_get_wake_status proposed earlier?

https://patchwork.kernel.org/patch/773932/

How about register with omap_hwmod data and irq_number from driver
after requesting irq ?

I suppose even using omap_hwmod data from driver file not allowed.
or use pdev ?


--
Thanks,
Govindraj.R


> Tony
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
