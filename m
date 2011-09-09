From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH v4 04/11] OMAP2+: UART: Remove uart clock handling code
 from serial.c
Date: Fri, 9 Sep 2011 10:52:17 +0530
Message-ID: <CAAL8m4xzaEhNbf9iRSq3crPvM_KwfLgjCgbsq_s5EEqr62ZasQ@mail.gmail.com>
References: <1315400013-4849-1-git-send-email-govindraj.raja@ti.com>
 <1315400013-4849-5-git-send-email-govindraj.raja@ti.com> <87pqja61ue.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:41951 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754093Ab1IIFWj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Sep 2011 01:22:39 -0400
In-Reply-To: <87pqja61ue.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Partha Basak <p-basak2@ti.com>, linux-serial@vger.kernel.org, Vishwanath Sripathy <vishwanath.bs@ti.com>, linux-arm-kernel@lists.infradead.org

Hi Kevin,

Thanks for the review.

On Fri, Sep 9, 2011 at 5:09 AM, Kevin Hilman <khilman@ti.com> wrote:
> "Govindraj.R" <govindraj.raja@ti.com> writes:
>
>> Cleanup serial.c file in preparation to addition of runtime API's in=
 omap-serial
>> file. Remove all clock handling mechanism as this will be taken care=
 with
>> pm runtime API's in omap-serial.c file itself.
>>
>> 1.) Remove omap-device enable and disable. We can can use get_sync/p=
ut_sync API's
>> 2.) Remove context save/restore can be done with runtime_resume call=
back for
>> =A0 =A0 get_sync call. No need to save context as all reg details av=
ailable in
>> =A0 =A0 uart_port structure can be used for restore, so add missing =
regs in
>> =A0 =A0 uart port struct.
>> 3.) Add func to identify console uart.
>
> I don't see that as part of this patch.

Yes I have to remove that line.

>
>> 4.) Erratum handling informed as flag to driver and func to handle e=
rratum
>> =A0 =A0 can be moved to omap-serial driver itself.
>
> OK, but I see two erratum flags removed, but only flag added back.
> Also, the erratum handling is completely removed here and not added t=
o
> the driver.
>

errata 2.15, yes correct force idle mode if in dma mode
need to incorporated into runtime suspend call back.

> In general, this way of moving things makes it very difficult to revi=
ew.
> You remove a bunch of things in this patch (and the previous one) and
> imply that some of it is added back to the driver. =A0However, that's
> really difficult to verify with patch review.
>

the things I moved from here to driver :

1.) prepare and resume calls, Yes I can incorporate 9/11 into this patc=
h.

2.) mdr errata movement - yes can be part of this change.

3.) context restore is part of runtime resume call back so I think
that should be part of runtime patches itself. Also force idle mode err=
ata 2.15
missed out also should be part of runtime suspend hook.
so cant be part of this change here.


> If code is being moved, it is customary to remove it and add it to th=
e
> new place in the same patch.
>

Ok.

>> Acked-by: Alan Cox <alan@linux.intel.com>
>> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/serial.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0742 ++-----------------------
>> =A0arch/arm/plat-omap/include/plat/omap-serial.h | =A0 11 +-
>> =A02 files changed, 53 insertions(+), 700 deletions(-)
>
> [...]
>
>> -static DEVICE_ATTR(sleep_timeout, 0644, sleep_timeout_show,
>> - =A0 =A0 =A0 =A0 =A0 =A0 sleep_timeout_store);
>> -#define DEV_CREATE_FILE(dev, attr) WARN_ON(device_create_file(dev, =
attr))
>> -#else
>> -static inline void omap_uart_idle_init(struct omap_uart_state *uart=
) {}
>> -static void omap_uart_block_sleep(struct omap_uart_state *uart)
>> +struct omap_hwmod *omap_uart_hwmod_lookup(int num)
>
> function should be static
>

OK.

> [...]
>
>> + =A0 =A0 for (i =3D 0; i < OMAP_MAX_HSUART_PORTS; i++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 oh =3D omap_uart_hwmod_lookup(i);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!oh)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 uart =3D kzalloc(sizeof(struct omap_uart_s=
tate), GFP_KERNEL);
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (WARN_ON(!uart))
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 uart->oh =3D oh;
>> - =A0 =A0 =A0 =A0 =A0 =A0 uart->num =3D i++;
>> - =A0 =A0 =A0 =A0 =A0 =A0 list_add_tail(&uart->node, &uart_list);
>> - =A0 =A0 =A0 =A0 =A0 =A0 num_uarts++;
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 /*
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0* NOTE: omap_hwmod_setup*() has not yet=
 been called,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0* =A0 =A0 =A0 so no hwmod functions wil=
l work yet.
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 /*
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0* During UART early init, device need t=
o be probed
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0* to determine SoC specific init before=
 omap_device
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0* is ready. =A0Therefore, don't allow i=
dle here
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> - =A0 =A0 =A0 =A0 =A0 =A0 uart->oh->flags |=3D HWMOD_INIT_NO_IDLE | =
HWMOD_INIT_NO_RESET;
>> - =A0 =A0 } while (1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>>
>> + =A0 =A0 =A0 =A0 =A0 =A0 oh->flags |=3D HWMOD_INIT_NO_IDLE | HWMOD_=
INIT_NO_RESET;
>
> With proper runtime PM in the driver, I did not expect these to be
> needed any longer by the end of the series, but I see they are still
> there. =A0Are they really needed?
>

Actually when we use early_printk option from CONFIG_DEBUG_LL
we use the debug-macro.s file to do put-char of early kernel prints unt=
il
a console driver is available, So while debug-macros does putchar from =
uart
if we try to reset console uart during hwmod_init this will cause uart
to go to bad state
and still no console driver available and can halt uart during bootup.

reset from hwmod -> putchar from earlyprintk driver doing tx on uart ??

Since softreset from hwmod can loose uart configuration from bootloader
and earlyprintk driver is unaware of this and does tx on uart.

Hence we still need this code to avoid uart reset & idle during bootup.

> [...]
>
>> @@ -864,15 +213,14 @@ void __init omap_serial_init_port(struct omap_=
board_data *bdata)
>> =A0 */
>> =A0void __init omap_serial_init(void)
>> =A0{
>> - =A0 =A0 struct omap_uart_state *uart;
>> =A0 =A0 =A0 struct omap_board_data bdata;
>> + =A0 =A0 u8 i;
>>
>> - =A0 =A0 list_for_each_entry(uart, &uart_list, node) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 bdata.id =3D uart->num;
>> + =A0 =A0 for (i =3D 0; i < OMAP_MAX_HSUART_PORTS; i++) {
>
> This should probably use the hwmod class iterator.

yes, will check that option.

--
Thanks,
Govindraj.R


>
> Kevin
> --
> To unsubscribe from this list: send the line "unsubscribe linux-seria=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
