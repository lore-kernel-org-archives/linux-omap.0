From: "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>
Subject: Re: [PATCH RFC] OMAP: serial: Release the claimed memory region in remove
Date: Fri, 10 Feb 2012 23:31:47 +0530
Message-ID: <CANQgH-Zy6XN+fqxx0eeVDERRSpBrU8zuOAkeSqtuL2un=6xmxA@mail.gmail.com>
References: <1328853482-3687-1-git-send-email-shubhrajyoti@ti.com>
	<CAOMWX4f0Mpj=NRBXZgtLbvCg3uo+8tZY8OAkriPu2YucRGoPkw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:38539 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752160Ab2BJSB4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Feb 2012 13:01:56 -0500
In-Reply-To: <CAOMWX4f0Mpj=NRBXZgtLbvCg3uo+8tZY8OAkriPu2YucRGoPkw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: linux-serial@vger.kernel.org, "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Feb 10, 2012 at 8:53 PM, Menon, Nishanth <nm@ti.com> wrote:
> On Thu, Feb 9, 2012 at 23:58, Shubhrajyoti D <shubhrajyoti@ti.com> wr=
ote:
>> Currently the memory region is not released the folowing error is
>> observed.
>>
>> /testsuites # insmod omap-serial.ko
>> [ =A0130.746917] omap_uart omap_uart.0: memory region already claime=
d
>> [ =A0130.753143] omap_uart: probe of omap_uart.0 failed with error -=
16
>> [ =A0130.759338] omap_uart omap_uart.1: memory region already claime=
d
>> [ =A0130.765380] omap_uart: probe of omap_uart.1 failed with error -=
16
>> [ =A0130.771606] omap_uart omap_uart.2: memory region already claime=
d
>> [ =A0130.777679] omap_uart: probe of omap_uart.2 failed with error -=
16
>> [ =A0130.783905] omap_uart omap_uart.3: memory region already claime=
d
>> [ =A0130.789947] omap_uart: probe of omap_uart.3 failed with error -=
16
>>
>> Fix it by releasing the memory region.
>>
>> Cc: Govindraj.R <govindraj.raja@ti.com>
>> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
>> ---
>> =A0drivers/tty/serial/omap-serial.c | =A0 =A04 ++++
>> =A01 files changed, 4 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/o=
map-serial.c
>> index 130f7f8..4def6c3 100644
>> --- a/drivers/tty/serial/omap-serial.c
>> +++ b/drivers/tty/serial/omap-serial.c
>> @@ -1480,6 +1480,10 @@ do_release_region:
>> =A0static int serial_omap_remove(struct platform_device *dev)
>> =A0{
>> =A0 =A0 =A0 =A0struct uart_omap_port *up =3D platform_get_drvdata(de=
v);
>> + =A0 =A0 =A0 struct resource =A0 =A0 =A0 =A0 *r;
>> +
>> + =A0 =A0 =A0 r =3D platform_get_resource(dev, IORESOURCE_MEM, 0);
>> + =A0 =A0 =A0 release_mem_region(r->start, resource_size(r));
> if this is the same region which ioremapped to up->port.membase, then
> please release mem region after the unmap.

My bad will send an updated patch.
Thanks ,

> Regards,
> Nishanth Menon
>
>>
>> =A0 =A0 =A0 =A0if (up) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0iounmap(up->port.membase);
>> --
>> 1.7.1
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
