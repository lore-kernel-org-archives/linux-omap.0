From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH v6 12/16] OMAP2+: UART: Allow UART parameters to be
 configured from board file.
Date: Wed, 12 Oct 2011 16:14:55 +0530
Message-ID: <CAAL8m4zBJmnUqJewGdCBRF-uiRhCstuR7keaJt7igUh0rXgJ4w@mail.gmail.com>
References: <1317380561-661-1-git-send-email-govindraj.raja@ti.com>
 <1317380561-661-3-git-send-email-govindraj.raja@ti.com> <878vor2wd0.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <878vor2wd0.fsf@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Partha Basak <p-basak2@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Deepak K <deepak.k@ti.com>, Jon Hunter <jon-hunter@ti.com>
List-Id: linux-omap@vger.kernel.org

On Wed, Oct 12, 2011 at 12:23 AM, Kevin Hilman <khilman@ti.com> wrote:
> "Govindraj.R" <govindraj.raja@ti.com> writes:
>
>> From: Deepak K <deepak.k@ti.com>
>>
>> The following UART parameters are defined within the UART driver:
>>
>> 1). Whether the UART uses DMA (dma_enabled), by default set to 0
>> 2). The size of dma buffer (set to 4096 bytes)
>> 3). The time after which the dma should stop if no more data is rece=
ived.
>> 4). The auto suspend delay that will be passed for pm_runtime_autosu=
spend
>> =A0 =A0 where uart will be disabled after timeout
>>
>> Different UARTs may be used for different purpose such as the consol=
e,
>> for interfacing bluetooth chip, for interfacing to a modem chip, etc=
=2E
>> Therefore, it is necessary to be able to customize the above setting=
s
>> for a given board on a per UART basis.
>>
>> This change allows these parameters to be configured from the board =
file
>> and allows the parameters to be configured for each UART independent=
ly.
>>
>> If a board does not define its own custom parameters for the UARTs, =
then
>> use the default parameters in the structure "omap_serial_default_inf=
o".
>> The default parameters are defined to be the same as the current set=
tings
>> in the UART driver to avoid breaking the UART for any cuurnelty supp=
orted
>> boards. By default, make all boards use the default UART parameters.
>>
>> Signed-off-by: Deepak K <deepak.k@ti.com>
>> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
>> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
>
> A couple minor comments below...
>
>> ---
>> This patch is derived and reworked from a custom 2.6.35 kernel
>> Available here:
>> http://git.omapzoom.org/?p=3Dkernel/omap.git;
>> a=3Dcommitdiff;h=3D584ef316542f77312be7ba96a0f3013c8f64852b;
>> hp=3D7233a76cb362c0fc603f773274159adff91d3513
>>
>> =A0arch/arm/mach-omap2/board-n8x0.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 =A06 +-
>> =A0arch/arm/mach-omap2/serial.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0 56 ++++++++++++++++++++----
>> =A0arch/arm/plat-omap/include/plat/omap-serial.h | =A0 =A07 ++-
>> =A0arch/arm/plat-omap/include/plat/serial.h =A0 =A0 =A0| =A0 =A05 ++=
-
>> =A0drivers/tty/serial/omap-serial.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 =A08 +--
>> =A05 files changed, 61 insertions(+), 21 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/=
board-n8x0.c
>> index e11f0c5..3408726 100644
>> --- a/arch/arm/mach-omap2/board-n8x0.c
>> +++ b/arch/arm/mach-omap2/board-n8x0.c
>> @@ -656,15 +656,15 @@ static inline void board_serial_init(void)
>> =A0 =A0 =A0 bdata.pads_cnt =3D 0;
>>
>> =A0 =A0 =A0 bdata.id =3D 0;
>> - =A0 =A0 omap_serial_init_port(&bdata);
>> + =A0 =A0 omap_serial_init_port(&bdata, NULL);
>>
>> =A0 =A0 =A0 bdata.id =3D 1;
>> - =A0 =A0 omap_serial_init_port(&bdata);
>> + =A0 =A0 omap_serial_init_port(&bdata, NULL);
>>
>> =A0 =A0 =A0 bdata.id =3D 2;
>> =A0 =A0 =A0 bdata.pads =3D serial2_pads;
>> =A0 =A0 =A0 bdata.pads_cnt =3D ARRAY_SIZE(serial2_pads);
>> - =A0 =A0 omap_serial_init_port(&bdata);
>> + =A0 =A0 omap_serial_init_port(&bdata, NULL);
>> =A0}
>>
>> =A0#else
>> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/seri=
al.c
>> index 0731575..78f7051 100644
>> --- a/arch/arm/mach-omap2/serial.c
>> +++ b/arch/arm/mach-omap2/serial.c
>> @@ -43,17 +43,29 @@
>> =A0#include "mux.h"
>>
>> =A0/*
>> - * NOTE: By default the serial timeout is disabled as it causes los=
t characters
>> - * over the serial ports. This means that the UART clocks will stay=
 on until
>> - * disabled via sysfs. This also causes that any deeper omap sleep =
states are
>> - * blocked.
>> + * NOTE: By default the serial auto_suspend timeout is disabled as =
it causes
>> + * lost characters over the serial ports. This means that the UART =
clocks will
>> + * stay on until power/autosuspend_delay is set for the uart from s=
ysfs.
>> + * This also causes that any deeper omap sleep states are blocked.
>> =A0 */
>> -#define DEFAULT_TIMEOUT 0
>> +#define DEFAULT_AUTOSUSPEND_DELAY =A0 =A0-1
>>
>> =A0#define MAX_UART_HWMOD_NAME_LEN =A0 =A0 =A0 =A0 =A0 =A0 =A016
>>
>> =A0static u8 num_uarts;
>>
>> +#define DEFAULT_RXDMA_TIMEOUT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A01 =A0 =
=A0 =A0 /* RX DMA polling rate (us) */
>> +#define DEFAULT_RXDMA_BUFSIZE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A04096 =A0=
 =A0/* RX DMA buffer size */
>> +
>> +static struct omap_uart_port_info omap_serial_default_info[] =3D {
>
> This could be __initdata
>

yes correct, will change this.


>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .dma_enabled =A0 =A0=3D 0,
>
> This field is a bool, use 'false' instead of 0.

yes fine.

>
>> + =A0 =A0 =A0 =A0 =A0 =A0 .dma_rx_buf_size =3D DEFAULT_RXDMA_BUFSIZE=
,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .dma_rx_timeout =3D DEFAULT_RXDMA_TIMEOUT,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .autosuspend_timeout =3D DEFAULT_AUTOSUSPE=
ND_DELAY,
>> + =A0 =A0 },
>> +};
>> +
>> =A0static int uart_idle_hwmod(struct omap_device *od)
>> =A0{
>> =A0 =A0 =A0 omap_hwmod_idle(od->hwmods[0]);
>> @@ -298,6 +310,7 @@ core_initcall(omap_serial_early_init);
>> =A0/**
>> =A0 * omap_serial_init_port() - initialize single serial port
>> =A0 * @bdata: port specific board data pointer
>> + * @info: platform specific data pointer
>> =A0 *
>> =A0 * This function initialies serial driver for given port only.
>> =A0 * Platforms can call this function instead of omap_serial_init()
>> @@ -306,7 +319,8 @@ core_initcall(omap_serial_early_init);
>> =A0 * Don't mix calls to omap_serial_init_port() and omap_serial_ini=
t(),
>> =A0 * use only one of the two.
>> =A0 */
>> -void __init omap_serial_init_port(struct omap_board_data *bdata)
>> +void __init omap_serial_init_port(struct omap_board_data *bdata,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct omap_uart_port_info=
 *info)
>
> alignment. =A02nd argument should align with 1st
>
>> =A0{
>> =A0 =A0 =A0 struct omap_hwmod *oh;
>> =A0 =A0 =A0 struct platform_device *pdev;
>> @@ -325,6 +339,9 @@ void __init omap_serial_init_port(struct omap_bo=
ard_data *bdata)
>> =A0 =A0 =A0 if (!oh)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>>
>> + =A0 =A0 if (info =3D=3D NULL)
>
> if (!info)
>
> there's another one of these elsewhere in the patch too.
>

will check and correct.

--
Thanks,
Govindraj.R
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
