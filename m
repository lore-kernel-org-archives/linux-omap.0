From: Venkatraman S <svenkatr@ti.com>
Subject: Re: [PATCH] serial: Add OMAP high-speed UART driver.
Date: Tue, 2 Mar 2010 19:16:12 +0530
Message-ID: <618f0c911003020546mb7c8412o2bac4e86a081332b__21928.0820609585$1267537597$gmane$org@mail.gmail.com>
References: <41322.192.168.10.89.1267454612.squirrel@dbdmail.itg.ti.com>
	 <20100301184600.GC3389@atomide.com>
	 <E0D41E29EB0DAC4E9F3FF173962E9E94026ED95FC1@dbde02.ent.ti.com>
	 <20100302060821.GI3389@atomide.com>
	 <E0D41E29EB0DAC4E9F3FF173962E9E94026ED9600D@dbde02.ent.ti.com>
	 <20100302065224.GL3389@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f196.google.com ([209.85.223.196]:63416 "EHLO
	mail-iw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753051Ab0CBNqN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Mar 2010 08:46:13 -0500
In-Reply-To: <20100302065224.GL3389@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, "G, Manjunath Kondaiah" <manjugk@ti.com>, "Raja, Govindraj" <govindraj.raja@ti.com>, Greg KH <greg@kroah.com>, "linux-serial@vger.kernel.org" <linux>

On Tue, Mar 2, 2010 at 12:22 PM, Tony Lindgren <tony@atomide.com> wrote=
:
> * G, Manjunath Kondaiah <manjugk@ti.com> [100301 22:24]:
>>
>>
>>
>> > > > > + =A0 =A0 up->uart_dma.prev_rx_dma_pos =3D
>> > up->uart_dma.rx_buf_dma_phys;
>> > > > > + =A0 =A0 if (cpu_is_omap44xx())
>> > > > > + =A0 =A0 =A0 =A0 =A0 =A0 omap_writel(0, OMAP44XX_DMA4_BASE
>> > > > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 +
>> > OMAP_DMA4_CDAC(up->uart_dma.rx_dma_channel));
>> > > > > + =A0 =A0 else
>> > > > > + =A0 =A0 =A0 =A0 =A0 =A0 omap_writel(0, OMAP34XX_DMA4_BASE
>> > > > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 +
>> > OMAP_DMA4_CDAC(up->uart_dma.rx_dma_channel));
>> > > >
>> > > > NAK. Please don't use omap_read/write for for new code. And do=
 not
>> > > > tinker with the omap hardware registers directly in the driver=
=2E
>> > > >
>> > > > This needs to be done properly in
>> > arch/arm/plat-omap/dma.c instead.
>> > >
>> > > Thanks for the suggestion.
>> > >
>> > > Currently, dma_read/dma_write are #define's in dma.c which
>> > cannot be
>> > > accessed outside dma.c. I don't see any API's in dma.c for
>> > setting required
>> > > value for this register?
>> >
>> > Hmm isn't this the same as omap_get_dma_dst_pos(int lch)? If you'r=
e
>> > trying do something that's not in dma.c, we can add a new function
>> > for it.
>>
>> The omap_get_dma_dst_pos(int lch) is for read operation in CDAC regi=
ster.
>> But, We need to write required value into CDAC register. For this, I=
 propose:
>>
>> omap_set_dma_dst_pos(int lch, int value) which does not exist in cur=
rent dma
>> driver.
>
> OK, it that's needed.
>
> Tony
> --
CDAC is a shadow register used for monitoring the DMA channel.
 I think it would be a lot
simpler if omap_start_dma() always resets CDAC to 0, and the UART drive=
r
just not set it explicitly.

Simple wrapper APIs doing get / set on individual DMA registers is as
difficult to understand
as omap_read / omap_write, IMHO.

Best regards,
Venkat.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
