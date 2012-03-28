From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 1/3] OMAP2+: UART: Remove cpu checks for populating errata
 flags
Date: Wed, 28 Mar 2012 11:43:48 -0500
Message-ID: <4F733FC4.9010506@ti.com>
References: <1332325501-10467-1-git-send-email-govindraj.raja@ti.com> <1332325501-10467-2-git-send-email-govindraj.raja@ti.com> <4F722C63.9080900@ti.com> <CAMrsUdKfsoks4fB4GhrRcEur8niJsaWuYGE34+j5Bk6u2XiZQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33148 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752960Ab2C1Qnw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 28 Mar 2012 12:43:52 -0400
In-Reply-To: <CAMrsUdKfsoks4fB4GhrRcEur8niJsaWuYGE34+j5Bk6u2XiZQQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Raja, Govindraj" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Felipe Balbi <balbi@ti.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Govindraj,

On 3/28/2012 6:09, Raja, Govindraj wrote:
> On Wed, Mar 28, 2012 at 2:38 AM, Jon Hunter<jon-hunter@ti.com>  wrote:
>> Hi Govindraj,
>>
>>
>> On 3/21/2012 5:24, Govindraj.R wrote:
>>>
>>> From: "Govindraj.R"<govindraj.raja@ti.com>
>>>
>>> Currently the errata is populated based on cpu checks this can
>>> be removed and replaced with module version check of uart ip block.
>>> MVR reg is provided within the uart reg map use the same
>>> to populate the errata and thus now errata population and handling
>>> can be managed within the driver itself.
>>>
>>> Cc: Paul Walmsley<paul@pwsan.com>
>>> Cc: Kevin Hilman<khilman@ti.com>
>>> Signed-off-by: Felipe Balbi<balbi@ti.com>
>>> Signed-off-by: Govindraj.R<govindraj.raja@ti.com>
>>> ---
>>>   arch/arm/mach-omap2/serial.c                  |    8 ---
>>>   arch/arm/plat-omap/include/plat/omap-serial.h |    1 -
>>>   drivers/tty/serial/omap-serial.c              |   62
>>> ++++++++++++++++++++++++-
>>>   3 files changed, 61 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
>>> index f590afc..330ee04 100644
>>> --- a/arch/arm/mach-omap2/serial.c
>>> +++ b/arch/arm/mach-omap2/serial.c
>>> @@ -357,14 +357,6 @@ void __init omap_serial_init_port(struct
>>> omap_board_data *bdata,
>>>         omap_up.dma_rx_poll_rate = info->dma_rx_poll_rate;
>>>         omap_up.autosuspend_timeout = info->autosuspend_timeout;
>>>
>>> -       /* Enable the MDR1 Errata i202 for OMAP2430/3xxx/44xx */
>>> -       if (!cpu_is_omap2420()&&    !cpu_is_ti816x())
>>>
>>> -               omap_up.errata |= UART_ERRATA_i202_MDR1_ACCESS;
>>> -
>>> -       /* Enable DMA Mode Force Idle Errata i291 for omap34xx/3630 */
>>> -       if (cpu_is_omap34xx() || cpu_is_omap3630())
>>> -               omap_up.errata |= UART_ERRATA_i291_DMA_FORCEIDLE;
>>> -
>>>         pdata =&omap_up;
>>>         pdata_size = sizeof(struct omap_uart_port_info);
>>>
>>> diff --git a/arch/arm/plat-omap/include/plat/omap-serial.h
>>> b/arch/arm/plat-omap/include/plat/omap-serial.h
>>> index 9ff4444..1a52725 100644
>>> --- a/arch/arm/plat-omap/include/plat/omap-serial.h
>>> +++ b/arch/arm/plat-omap/include/plat/omap-serial.h
>>> @@ -65,7 +65,6 @@ struct omap_uart_port_info {
>>>         bool                    dma_enabled;    /* To specify DMA Mode */
>>>         unsigned int            uartclk;        /* UART clock rate */
>>>         upf_t                   flags;          /* UPF_* flags */
>>> -       u32                     errata;
>>>         unsigned int            dma_rx_buf_size;
>>>         unsigned int            dma_rx_timeout;
>>>         unsigned int            autosuspend_timeout;
>>> diff --git a/drivers/tty/serial/omap-serial.c
>>> b/drivers/tty/serial/omap-serial.c
>>> index f809041..c7666d6 100644
>>> --- a/drivers/tty/serial/omap-serial.c
>>> +++ b/drivers/tty/serial/omap-serial.c
>>> @@ -44,6 +44,13 @@
>>>   #include<plat/dmtimer.h>
>>>   #include<plat/omap-serial.h>
>>>
>>> +#define UART_BUILD_REVISION(x, y)      (((x)<<    8) | (y))
>>> +
>>> +#define OMAP_UART_REV_42 0x0402
>>> +#define OMAP_UART_REV_46 0x0406
>>> +#define OMAP_UART_REV_52 0x0502
>>> +#define OMAP_UART_REV_63 0x0603
>>> +
>>>   #define DEFAULT_CLK_SPEED 48000000 /* 48Mhz*/
>>>
>>>   /* SCR register bitmasks */
>>> @@ -1346,6 +1353,58 @@ static void uart_tx_dma_callback(int lch, u16
>>> ch_status, void *data)
>>>         return;
>>>   }
>>>
>>> +static void omap_serial_fill_features_erratas(struct uart_omap_port *up)
>>> +{
>>> +       u32 mvr, scheme;
>>> +       u16 revision, major, minor;
>>> +
>>> +       mvr = serial_in(up, UART_OMAP_MVER);
>>> +
>>> +       /* Check revision register scheme */
>>> +       scheme = mvr&    (0x03<<    30);
>>> +       scheme>>= 30;
>>
>>
>> Minor nit-pick, why not ...
>>
>>         scheme = mvr>>  30;
>>
>
> yes will correct it.

Thinking some more, could be better to add some #defines for 
OMAP_MVR_VERSION_MASK/SHIFT here.

>>
>>> +       switch (scheme) {
>>> +       case 0: /* Legacy Scheme: OMAP2/3 */
>>> +               /* MINOR_REV[0:4], MAJOR_REV[4:7] */
>>
>>
>> This scheme is also true from OMAP1 devices. Maybe we could include in the
>> comment.
>
> No omap1 from $SUBJECT also reason,
>
> mach-omap1/serial.c =>  8250.c
> mach-omap2/serial.c =>  omap-serial.c

Got it! Thanks.

>>> +               major = (mvr&    0xf0)>>    4;
>>> +               minor = (mvr&    0x0f);
>>>
>>> +               break;
>>> +       case 1:
>>> +               /* New Scheme: OMAP4+ */
>>> +               /* MINOR_REV[0:5], MAJOR_REV[8:10] */
>>> +               major = (mvr&    0x7<<    8)>>    8;
>>
>>
>> Nit-pick ...
>>
>>         major = (mvr>>  8)&  0x7;
>
> yes fine will correct this.

May be we should add #defines here to for OMAP_UART_MVR1_MAJ_MASK/SHIFT, 
OMAP_UART_MVR1_MIN_MASK/SHIFT, OMAP_UART_MVR2_MAJ_MASK/SHIFT and 
OMAP_UART_MVR2_MIN_MASK/SHIFT.

Jon
