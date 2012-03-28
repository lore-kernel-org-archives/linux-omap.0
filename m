From: "Raja, Govindraj" <govindraj.raja@ti.com>
Subject: Re: [PATCH 1/3] OMAP2+: UART: Remove cpu checks for populating errata flags
Date: Wed, 28 Mar 2012 16:39:37 +0530
Message-ID: <CAMrsUdKfsoks4fB4GhrRcEur8niJsaWuYGE34+j5Bk6u2XiZQQ@mail.gmail.com>
References: <1332325501-10467-1-git-send-email-govindraj.raja@ti.com>
 <1332325501-10467-2-git-send-email-govindraj.raja@ti.com> <4F722C63.9080900@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob129.obsmtp.com ([74.125.149.136]:58319 "EHLO
	na3sys009amx259.postini.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1758106Ab2C1LJ6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 28 Mar 2012 07:09:58 -0400
Received: by yenm14 with SMTP id m14so588727yen.9
        for <linux-omap@vger.kernel.org>; Wed, 28 Mar 2012 04:09:57 -0700 (PDT)
In-Reply-To: <4F722C63.9080900@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Felipe Balbi <balbi@ti.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, Mar 28, 2012 at 2:38 AM, Jon Hunter <jon-hunter@ti.com> wrote:
> Hi Govindraj,
>
>
> On 3/21/2012 5:24, Govindraj.R wrote:
>>
>> From: "Govindraj.R"<govindraj.raja@ti.com>
>>
>> Currently the errata is populated based on cpu checks this can
>> be removed and replaced with module version check of uart ip block.
>> MVR reg is provided within the uart reg map use the same
>> to populate the errata and thus now errata population and handling
>> can be managed within the driver itself.
>>
>> Cc: Paul Walmsley<paul@pwsan.com>
>> Cc: Kevin Hilman<khilman@ti.com>
>> Signed-off-by: Felipe Balbi<balbi@ti.com>
>> Signed-off-by: Govindraj.R<govindraj.raja@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/serial.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0 =A08 ---
>> =A0arch/arm/plat-omap/include/plat/omap-serial.h | =A0 =A01 -
>> =A0drivers/tty/serial/omap-serial.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 62
>> ++++++++++++++++++++++++-
>> =A03 files changed, 61 insertions(+), 10 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/seri=
al.c
>> index f590afc..330ee04 100644
>> --- a/arch/arm/mach-omap2/serial.c
>> +++ b/arch/arm/mach-omap2/serial.c
>> @@ -357,14 +357,6 @@ void __init omap_serial_init_port(struct
>> omap_board_data *bdata,
>> =A0 =A0 =A0 =A0omap_up.dma_rx_poll_rate =3D info->dma_rx_poll_rate;
>> =A0 =A0 =A0 =A0omap_up.autosuspend_timeout =3D info->autosuspend_tim=
eout;
>>
>> - =A0 =A0 =A0 /* Enable the MDR1 Errata i202 for OMAP2430/3xxx/44xx =
*/
>> - =A0 =A0 =A0 if (!cpu_is_omap2420()&& =A0!cpu_is_ti816x())
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_up.errata |=3D UART_ERRATA_i202_M=
DR1_ACCESS;
>> -
>> - =A0 =A0 =A0 /* Enable DMA Mode Force Idle Errata i291 for omap34xx=
/3630 */
>> - =A0 =A0 =A0 if (cpu_is_omap34xx() || cpu_is_omap3630())
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_up.errata |=3D UART_ERRATA_i291_D=
MA_FORCEIDLE;
>> -
>> =A0 =A0 =A0 =A0pdata =3D&omap_up;
>> =A0 =A0 =A0 =A0pdata_size =3D sizeof(struct omap_uart_port_info);
>>
>> diff --git a/arch/arm/plat-omap/include/plat/omap-serial.h
>> b/arch/arm/plat-omap/include/plat/omap-serial.h
>> index 9ff4444..1a52725 100644
>> --- a/arch/arm/plat-omap/include/plat/omap-serial.h
>> +++ b/arch/arm/plat-omap/include/plat/omap-serial.h
>> @@ -65,7 +65,6 @@ struct omap_uart_port_info {
>> =A0 =A0 =A0 =A0bool =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dma_enabl=
ed; =A0 =A0/* To specify DMA Mode */
>> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0uartclk; =A0 =A0 =
=A0 =A0/* UART clock rate */
>> =A0 =A0 =A0 =A0upf_t =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 flags; =A0 =
=A0 =A0 =A0 =A0/* UPF_* flags */
>> - =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 errata;
>> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0dma_rx_buf_size;
>> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0dma_rx_timeout;
>> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0autosuspend_timeo=
ut;
>> diff --git a/drivers/tty/serial/omap-serial.c
>> b/drivers/tty/serial/omap-serial.c
>> index f809041..c7666d6 100644
>> --- a/drivers/tty/serial/omap-serial.c
>> +++ b/drivers/tty/serial/omap-serial.c
>> @@ -44,6 +44,13 @@
>> =A0#include<plat/dmtimer.h>
>> =A0#include<plat/omap-serial.h>
>>
>> +#define UART_BUILD_REVISION(x, y) =A0 =A0 =A0(((x)<< =A08) | (y))
>> +
>> +#define OMAP_UART_REV_42 0x0402
>> +#define OMAP_UART_REV_46 0x0406
>> +#define OMAP_UART_REV_52 0x0502
>> +#define OMAP_UART_REV_63 0x0603
>> +
>> =A0#define DEFAULT_CLK_SPEED 48000000 /* 48Mhz*/
>>
>> =A0/* SCR register bitmasks */
>> @@ -1346,6 +1353,58 @@ static void uart_tx_dma_callback(int lch, u16
>> ch_status, void *data)
>> =A0 =A0 =A0 =A0return;
>> =A0}
>>
>> +static void omap_serial_fill_features_erratas(struct uart_omap_port=
 *up)
>> +{
>> + =A0 =A0 =A0 u32 mvr, scheme;
>> + =A0 =A0 =A0 u16 revision, major, minor;
>> +
>> + =A0 =A0 =A0 mvr =3D serial_in(up, UART_OMAP_MVER);
>> +
>> + =A0 =A0 =A0 /* Check revision register scheme */
>> + =A0 =A0 =A0 scheme =3D mvr& =A0(0x03<< =A030);
>> + =A0 =A0 =A0 scheme>>=3D 30;
>
>
> Minor nit-pick, why not ...
>
> =A0 =A0 =A0 =A0scheme =3D mvr >> 30;
>

yes will correct it.

>
>> + =A0 =A0 =A0 switch (scheme) {
>> + =A0 =A0 =A0 case 0: /* Legacy Scheme: OMAP2/3 */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* MINOR_REV[0:4], MAJOR_REV[4:7] */
>
>
> This scheme is also true from OMAP1 devices. Maybe we could include i=
n the
> comment.

No omap1 from $SUBJECT also reason,

mach-omap1/serial.c =3D> 8250.c
mach-omap2/serial.c =3D> omap-serial.c

>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 major =3D (mvr& =A00xf0)>> =A04;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 minor =3D (mvr& =A00x0f);
>>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 case 1:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* New Scheme: OMAP4+ */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* MINOR_REV[0:5], MAJOR_REV[8:10] */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 major =3D (mvr& =A00x7<< =A08)>> =A08;
>
>
> Nit-pick ...
>
> =A0 =A0 =A0 =A0major =3D (mvr >> 8) & 0x7;

yes fine will correct this.

--
Thanks,
Govindraj.R
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
