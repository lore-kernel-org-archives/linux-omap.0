From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH v6 06/16] OMAP2+: UART: Remove certain feilds from
	omap_uart_state struct
Date: Wed, 12 Oct 2011 15:55:18 +0530
Message-ID: <CAAL8m4y62EuwUNpUDTpL+bheDS=yAC0n211AdPnEAVpgdoUOOg@mail.gmail.com>
References: <1317380495-584-1-git-send-email-govindraj.raja@ti.com>
	<1317380495-584-6-git-send-email-govindraj.raja@ti.com>
	<87d3e4ctki.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <87d3e4ctki.fsf@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Rajendra Nayak <rnayak@ti.com>, Partha Basak <p-basak2@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-serial@vger.kernel.org, Vishwanath Sripathy <vishwanath.bs@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Tue, Oct 11, 2011 at 5:01 AM, Kevin Hilman <khilman@ti.com> wrote:
> "Govindraj.R" <govindraj.raja@ti.com> writes:
>
>> Removing some of the uart info that is maintained in omap_uart_state str=
uct
>> used for UART PM in serial.c.
>>
>> Remove omap_uart_state struct dependency from omap_serial_init,
>> omap_serial_init_port, omap_serial_early_init and omap_uart_idle_init
>> functions. =A0And populate the same info in omap_uart_port_info struct
>> used as pdata struct.
>
> IMO, this change doesn't belong in this patch and leads to clutter. =A0The
> rest of the series slowly removes/replaces all the fields from this
> struct, so the right place to remove it's usage all together is at the
> end of the series when (if) all the fields are no longer needed (or have
> been moved.)
>

Okay will move it to end.

> Stated differently, IMO, this patch should leave the uart->num and
> uart->oh and the list_head (uart->node) alone (probably uart->pdev too)
> and just cleanup the fields that are no longer used. =A0Removing num, oh,
> node here causes churn because you're force to change things here that
> are then removed in later patches.
>

okay will retain the list part.

>> Added omap_uart_hwmod_lookup function to look up oh by name used in
>> serial_port_init and omap_serial_early_init functions.
>
> Because of the above change, you now are doing a hwmod lookup 2 times
> for every UART. =A0Leaving the uart_list and uart->num in place will avoid
> the need for that change.
>

yes since uart_list was removed, will retain the uart_list
to avoid the look up twice.


>> A list of omap_uart_state was maintained one for each uart, the same
>> is removed. =A0Number of uarts available is maintained in num_uarts
>> field, re-use the same in omap_serial_init func to register each uart.
>>
>> Remove omap_info which used details from omap_uart_state and use a
>> pdata pointer to pass platform specific info to driver.
>
> There is no omap_info. =A0Did you mean omap_up_info?

yes sorry typo.

>
>> The mapbase (start_address), membase(io_remap cookie) maintained as
>> part of uart_state struct and pdata struct are removed as this is
>> handled within driver.
>
> This part makes sense.
>

okay will retain this part only.

>> Errata field is also moved to pdata.
>
> Why in this patch instead of the subsequent "Move errata handling from
> serial.c to omap-serial" patch?
>

will move to the errata patch.


>> These changes are done to cleanup serial.c file and prepare for
>> runtime changes.
>
> There are a lot of changes in this patch with very little description as
> to why, and many appear to be unrelated. =A0They should probably be
> separate patches, or have a better description as to how all the changes
> are related so they belong in the same patch.
>

okay fine will split them into smaller changes.


>> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/serial.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
132 +++++++++---------------
>> =A0arch/arm/plat-omap/include/plat/omap-serial.h | =A0 =A04 +-
>> =A0drivers/tty/serial/omap-serial.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 12 =
++-
>> =A03 files changed, 61 insertions(+), 87 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
>> index c98b9b4..8c43d1c 100644
>> --- a/arch/arm/mach-omap2/serial.c
>> +++ b/arch/arm/mach-omap2/serial.c
>> @@ -68,14 +68,6 @@ struct omap_uart_state {
>> =A0 =A0 =A0 int clocked;
>>
>> =A0 =A0 =A0 int regshift;
>> - =A0 =A0 void __iomem *membase;
>> - =A0 =A0 resource_size_t mapbase;
>> -
>> - =A0 =A0 struct list_head node;
>> - =A0 =A0 struct omap_hwmod *oh;
>> - =A0 =A0 struct platform_device *pdev;
>> -
>> - =A0 =A0 u32 errata;
>> =A0#if defined(CONFIG_ARCH_OMAP3) && defined(CONFIG_PM)
>> =A0 =A0 =A0 int context_valid;
>>
>> @@ -90,7 +82,6 @@ struct omap_uart_state {
>> =A0#endif
>> =A0};
>>
>> -static LIST_HEAD(uart_list);
>> =A0static u8 num_uarts;
>>
>> =A0static int uart_idle_hwmod(struct omap_device *od)
>> @@ -143,7 +134,19 @@ static inline void serial_write_reg(struct omap_uar=
t_state *uart, int offset,
>> =A0 =A0 =A0 __raw_writeb(value, uart->membase + offset);
>> =A0}
>>
>> -#if defined(CONFIG_PM) && defined(CONFIG_ARCH_OMAP3)
>> +struct omap_hwmod *omap_uart_hwmod_lookup(int num)
>> +{
>> + =A0 =A0 struct omap_hwmod *oh;
>> + =A0 =A0 char oh_name[MAX_UART_HWMOD_NAME_LEN];
>> +
>> + =A0 =A0 snprintf(oh_name, MAX_UART_HWMOD_NAME_LEN, "uart%d", num + 1);
>> + =A0 =A0 oh =3D omap_hwmod_lookup(oh_name);
>> + =A0 =A0 WARN(IS_ERR(oh), "Could not lookup hmwod info for %s\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 oh_name);
>> + =A0 =A0 return oh;
>> +}
>> +
>> +#if defined(CONFIG_PM)
>
> The CONFIG_ARCH_OMAP3 part of this #if was dropped with this change with
> no mention as to why. =A0(I understand why it was done, but it's not
> releveant to $SUBJECT patch so should be a separate patch.)
>
>> =A0/*
>> =A0 * Work Around for Errata i202 (3430 - 1.12, 3630 - 1.6)
>> @@ -357,22 +360,17 @@ int omap_uart_can_sleep(void)
>> =A0 =A0 =A0 return can_sleep;
>> =A0}
>>
>> -static void omap_uart_idle_init(struct omap_uart_state *uart)
>> +static void omap_uart_idle_init(struct omap_uart_port_info *uart,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned short=
 num)
>> =A0{
>> - =A0 =A0 int ret;
>> -
>> - =A0 =A0 uart->can_sleep =3D 0;
>> - =A0 =A0 omap_uart_smart_idle_enable(uart, 0);
>> -
>> =A0 =A0 =A0 if (cpu_is_omap34xx() && !cpu_is_ti816x()) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 u32 mod =3D (uart->num > 1) ? OMAP3430_PER_MOD=
 : CORE_MOD;
>> + =A0 =A0 =A0 =A0 =A0 =A0 u32 mod =3D (num > 1) ? OMAP3430_PER_MOD : COR=
E_MOD;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 wk_mask =3D 0;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 padconf =3D 0;
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 /* XXX These PRM accesses do not belong here */
>
> why?
>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 uart->wk_en =3D OMAP34XX_PRM_REGADDR(mod, PM=
_WKEN1);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 uart->wk_st =3D OMAP34XX_PRM_REGADDR(mod, PM=
_WKST1);
>> - =A0 =A0 =A0 =A0 =A0 =A0 switch (uart->num) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 switch (num) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 case 0:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wk_mask =3D OMAP3430_ST_UART=
1_MASK;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 padconf =3D 0x182;
>> @@ -391,12 +389,11 @@ static void omap_uart_idle_init(struct omap_uart_s=
tate *uart)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 uart->wk_mask =3D wk_mask;
>> - =A0 =A0 =A0 =A0 =A0 =A0 uart->padconf =3D padconf;
>
> The assignment is removed here, making all the rest of the padconf stuff
> that remains useless.
>
> However, a subsequent patch removes the mux stuff entirely, so I suggest
> you just drop this change from here.
>

okay will incorporate this as part of mux changes patch.


>> =A0 =A0 =A0 } else if (cpu_is_omap24xx()) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 wk_mask =3D 0;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 wk_en =3D PM_WKEN1, wk_st =3D PM_WKST1;
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 switch (uart->num) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 switch (num) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 case 0:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wk_mask =3D OMAP24XX_ST_UART=
1_MASK;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> @@ -421,7 +418,6 @@ static void omap_uart_idle_init(struct omap_uart_sta=
te *uart)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 uart->wk_en =3D NULL;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 uart->wk_st =3D NULL;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 uart->wk_mask =3D 0;
>> - =A0 =A0 =A0 =A0 =A0 =A0 uart->padconf =3D 0;
>> =A0 =A0 =A0 }
>> =A0}
>>
>> @@ -436,26 +432,13 @@ static void omap_uart_block_sleep(struct omap_uart=
_state *uart)
>>
>> =A0static int __init omap_serial_early_init(void)
>> =A0{
>> - =A0 =A0 int i =3D 0;
>> -
>> =A0 =A0 =A0 do {
>> - =A0 =A0 =A0 =A0 =A0 =A0 char oh_name[MAX_UART_HWMOD_NAME_LEN];
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct omap_hwmod *oh;
>> - =A0 =A0 =A0 =A0 =A0 =A0 struct omap_uart_state *uart;
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 snprintf(oh_name, MAX_UART_HWMOD_NAME_LEN,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"uart%d", i + 1);
>> - =A0 =A0 =A0 =A0 =A0 =A0 oh =3D omap_hwmod_lookup(oh_name);
>> + =A0 =A0 =A0 =A0 =A0 =A0 oh =3D omap_uart_hwmod_lookup(num_uarts);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!oh)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 uart =3D kzalloc(sizeof(struct omap_uart_state=
), GFP_KERNEL);
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (WARN_ON(!uart))
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 uart->oh =3D oh;
>> - =A0 =A0 =A0 =A0 =A0 =A0 uart->num =3D i++;
>> - =A0 =A0 =A0 =A0 =A0 =A0 list_add_tail(&uart->node, &uart_list);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 num_uarts++;
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>> @@ -468,7 +451,7 @@ static int __init omap_serial_early_init(void)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* to determine SoC specific init before o=
map_device
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* is ready. =A0Therefore, don't allow idl=
e here
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> - =A0 =A0 =A0 =A0 =A0 =A0 uart->oh->flags |=3D HWMOD_INIT_NO_IDLE | HWMO=
D_INIT_NO_RESET;
>> + =A0 =A0 =A0 =A0 =A0 =A0 oh->flags |=3D HWMOD_INIT_NO_IDLE | HWMOD_INIT=
_NO_RESET;
>> =A0 =A0 =A0 } while (1);
>>
>> =A0 =A0 =A0 return 0;
>> @@ -488,57 +471,47 @@ core_initcall(omap_serial_early_init);
>> =A0 */
>> =A0void __init omap_serial_init_port(struct omap_board_data *bdata)
>> =A0{
>> - =A0 =A0 struct omap_uart_state *uart;
>> =A0 =A0 =A0 struct omap_hwmod *oh;
>> =A0 =A0 =A0 struct platform_device *pdev;
>> - =A0 =A0 void *pdata =3D NULL;
>> + =A0 =A0 char *name =3D DRIVER_NAME;
>> + =A0 =A0 struct omap_uart_port_info *pdata;
>> =A0 =A0 =A0 u32 pdata_size =3D 0;
>> - =A0 =A0 char *name;
>> - =A0 =A0 struct omap_uart_port_info omap_up;
>>
>> =A0 =A0 =A0 if (WARN_ON(!bdata))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> =A0 =A0 =A0 if (WARN_ON(bdata->id < 0))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> - =A0 =A0 if (WARN_ON(bdata->id >=3D num_uarts))
>> + =A0 =A0 if (WARN_ON(bdata->id >=3D OMAP_MAX_HSUART_PORTS))
>
> why? =A0because of early_init, num_uarts is already the max number
> of UARTs available (based on hwmod probe.)
>

yes will correct this and use num_uarts

>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>>
>> - =A0 =A0 list_for_each_entry(uart, &uart_list, node)
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (bdata->id =3D=3D uart->num)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> -
>> - =A0 =A0 oh =3D uart->oh;
>> - =A0 =A0 uart->dma_enabled =3D 0;
>> - =A0 =A0 name =3D DRIVER_NAME;
>> + =A0 =A0 oh =3D omap_uart_hwmod_lookup(bdata->id);
>> + =A0 =A0 if (!oh)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>>
>> - =A0 =A0 omap_up.dma_enabled =3D uart->dma_enabled;
>> - =A0 =A0 omap_up.uartclk =3D OMAP24XX_BASE_BAUD * 16;
>> - =A0 =A0 omap_up.mapbase =3D oh->slaves[0]->addr->pa_start;
>> - =A0 =A0 omap_up.membase =3D omap_hwmod_get_mpu_rt_va(oh);
>> - =A0 =A0 omap_up.flags =3D UPF_BOOT_AUTOCONF | UPF_SHARE_IRQ;
>> + =A0 =A0 pdata =3D kzalloc(sizeof(*pdata), GFP_KERNEL);
>> + =A0 =A0 if (!pdata) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_err("Memory allocation for UART pdata faile=
d\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> + =A0 =A0 }
>>
>> - =A0 =A0 pdata =3D &omap_up;
>> =A0 =A0 =A0 pdata_size =3D sizeof(struct omap_uart_port_info);
>> + =A0 =A0 omap_uart_idle_init(pdata, bdata->id);
>
> Why was this moved here?
>
> ISTR that the order of this call relative to the hwmod/omap_device
> enable/disable calls below was important, especially in the DEBUG_LL
> case.
>
>> - =A0 =A0 if (WARN_ON(!oh))
>> - =A0 =A0 =A0 =A0 =A0 =A0 return;
>> + =A0 =A0 pdata->uartclk =3D OMAP24XX_BASE_BAUD * 16;
>> + =A0 =A0 pdata->flags =3D UPF_BOOT_AUTOCONF;
>> +
>> + =A0 =A0 /* Enable the MDR1 errata for OMAP3 */
>> + =A0 =A0 if (cpu_is_omap34xx() && !cpu_is_ti816x())
>> + =A0 =A0 =A0 =A0 =A0 =A0 pdata->errata |=3D UART_ERRATA_i202_MDR1_ACCES=
S;
>>
>> - =A0 =A0 pdev =3D omap_device_build(name, uart->num, oh, pdata, pdata_s=
ize,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_uart_laten=
cy,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ARRAY_SIZE(omap=
_uart_latency), false);
>> + =A0 =A0 pdev =3D omap_device_build(name, bdata->id, oh, pdata,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata_size, om=
ap_uart_latency,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ARRAY_SIZE(oma=
p_uart_latency), false);
>
> Note the unecesary whitespace changes in this change.
>
>> =A0 =A0 =A0 WARN(IS_ERR(pdev), "Could not build omap_device for %s: %s.\=
n",
>> =A0 =A0 =A0 =A0 =A0 =A0name, oh->name);
>>
>> - =A0 =A0 omap_device_disable_idle_on_suspend(pdev);
>
> This should also be a separate patch at the end of the series, and is
> not related to the changes described in the changelog.
>

okay.

>> =A0 =A0 =A0 oh->mux =3D omap_hwmod_mux_init(bdata->pads, bdata->pads_cnt=
);
>>
>> - =A0 =A0 uart->regshift =3D 2;
>> - =A0 =A0 uart->mapbase =3D oh->slaves[0]->addr->pa_start;
>> - =A0 =A0 uart->membase =3D omap_hwmod_get_mpu_rt_va(oh);
>> - =A0 =A0 uart->pdev =3D pdev;
>> -
>> - =A0 =A0 oh->dev_attr =3D uart;
>> -
>> =A0 =A0 =A0 console_lock(); /* in case the earlycon is on the UART */
>>
>> =A0 =A0 =A0 /*
>> @@ -546,23 +519,18 @@ void __init omap_serial_init_port(struct omap_boar=
d_data *bdata)
>> =A0 =A0 =A0 =A0* on init. =A0Now that omap_device is ready, ensure full =
idle
>> =A0 =A0 =A0 =A0* before doing omap_device_enable().
>> =A0 =A0 =A0 =A0*/
>> - =A0 =A0 omap_hwmod_idle(uart->oh);
>> + =A0 =A0 omap_hwmod_idle(oh);
>>
>> - =A0 =A0 omap_device_enable(uart->pdev);
>> - =A0 =A0 omap_uart_idle_init(uart);
>> - =A0 =A0 omap_hwmod_enable_wakeup(uart->oh);
>> - =A0 =A0 omap_device_idle(uart->pdev);
>> + =A0 =A0 omap_device_enable(pdev);
>> + =A0 =A0 omap_hwmod_enable_wakeup(oh);
>>
>> - =A0 =A0 omap_uart_block_sleep(uart);
>> =A0 =A0 =A0 console_unlock();
>>
>> - =A0 =A0 if ((cpu_is_omap34xx() && uart->padconf) ||
>> - =A0 =A0 =A0 =A0 (uart->wk_en && uart->wk_mask))
>> + =A0 =A0 if ((cpu_is_omap34xx() && bdata->pads) ||
>> + =A0 =A0 =A0 =A0 =A0 =A0 (pdata->wk_en && pdata->wk_mask))
>
> This change seems to belong as part of the mux patch.
>

okay moving to mux change patch.

>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_init_wakeup(&pdev->dev, true);
>>
>> - =A0 =A0 /* Enable the MDR1 errata for OMAP3 */
>> - =A0 =A0 if (cpu_is_omap34xx() && !cpu_is_ti816x())
>> - =A0 =A0 =A0 =A0 =A0 =A0 uart->errata |=3D UART_ERRATA_i202_MDR1_ACCESS;
>> + =A0 =A0 kfree(pdata);
>> =A0}
>>
>> =A0/**
>> @@ -574,11 +542,11 @@ void __init omap_serial_init_port(struct omap_boar=
d_data *bdata)
>> =A0 */
>> =A0void __init omap_serial_init(void)
>> =A0{
>> - =A0 =A0 struct omap_uart_state *uart;
>> =A0 =A0 =A0 struct omap_board_data bdata;
>> + =A0 =A0 u8 i;
>>
>> - =A0 =A0 list_for_each_entry(uart, &uart_list, node) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 bdata.id =3D uart->num;
>> + =A0 =A0 for (i =3D 0; i < num_uarts; i++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 bdata.id =3D i;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 bdata.flags =3D 0;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 bdata.pads =3D NULL;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 bdata.pads_cnt =3D 0;
>> diff --git a/arch/arm/plat-omap/include/plat/omap-serial.h b/arch/arm/pl=
at-omap/include/plat/omap-serial.h
>> index 307cd6f..0f061b4 100644
>> --- a/arch/arm/plat-omap/include/plat/omap-serial.h
>> +++ b/arch/arm/plat-omap/include/plat/omap-serial.h
>> @@ -59,9 +59,9 @@
>> =A0struct omap_uart_port_info {
>> =A0 =A0 =A0 bool =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dma_enabled; =A0=
 =A0/* To specify DMA Mode */
>> =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0uartclk; =A0 =A0 =A0 =A0=
/* UART clock rate */
>> - =A0 =A0 void __iomem =A0 =A0 =A0 =A0 =A0 =A0*membase; =A0 =A0 =A0 /* i=
oremap cookie or NULL */
>> - =A0 =A0 resource_size_t =A0 =A0 =A0 =A0 mapbase; =A0 =A0 =A0 =A0/* res=
ource base */
>> =A0 =A0 =A0 upf_t =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 flags; =A0 =A0 =A0=
 =A0 =A0/* UPF_* flags */
>> +
>> + =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 errata;
>> =A0};
>>
>> =A0struct uart_omap_dma {
>> diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-=
serial.c
>> index 5e713d3..6c2ea54 100644
>> --- a/drivers/tty/serial/omap-serial.c
>> +++ b/drivers/tty/serial/omap-serial.c
>> @@ -1275,10 +1275,16 @@ static int serial_omap_probe(struct platform_dev=
ice *pdev)
>> =A0 =A0 =A0 up->port.ops =3D &serial_omap_pops;
>> =A0 =A0 =A0 up->port.line =3D pdev->id;
>>
>> - =A0 =A0 up->port.membase =3D omap_up_info->membase;
>> - =A0 =A0 up->port.mapbase =3D omap_up_info->mapbase;
>> + =A0 =A0 up->port.mapbase =3D mem->start;
>> + =A0 =A0 up->port.membase =3D ioremap(mem->start, resource_size(mem));
>> +
>> + =A0 =A0 if (!up->port.membase) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "can't ioremap UART\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err;
>> + =A0 =A0 }
>> +
>> =A0 =A0 =A0 up->port.flags =3D omap_up_info->flags;
>> - =A0 =A0 up->port.irqflags =3D omap_up_info->irqflags;
>> =A0 =A0 =A0 up->port.uartclk =3D omap_up_info->uartclk;
>> =A0 =A0 =A0 up->uart_dma.uart_base =3D mem->start;
>
> Kevin
> --
> To unsubscribe from this list: send the line "unsubscribe linux-serial" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
