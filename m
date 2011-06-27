From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH v3 10/12] OMAP: Serial: Use resume call from prcm to
 enable uart
Date: Mon, 27 Jun 2011 20:33:48 +0530
Message-ID: <BANLkTi=jyrt6+vXikdH0RdeOxEAkasigLw@mail.gmail.com>
References: <1307532194-13039-1-git-send-email-govindraj.raja@ti.com>
 <1307532194-13039-11-git-send-email-govindraj.raja@ti.com> <87aad6rc6z.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <87aad6rc6z.fsf@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>, Tero Kristo <t-kristo@ti.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

On Sat, Jun 25, 2011 at 5:53 AM, Kevin Hilman <khilman@ti.com> wrote:
> "Govindraj.R" <govindraj.raja@ti.com> writes:
>
>> Use resume idle call from prcm_irq to enable uart_port from low powe=
r states.
>
> Comment is valid for OMAP3 but not for OMAP2. =A0Maybe [01/12] should=
 just
> leave this call in for OMAP2 instead of having to add it back here?
>
>> Add api to check pad wakeup status which will we used from uart_resu=
me func.
>> to enable back uart port if a wakeup event occurred.
>
> s/api/API/ =A0(same for PRCM, UART, int subject)
>
>> UART_Resume func. can be removed once we have irq_chaining functiona=
lity
>> available.
>
> Have you tested removing this when using with Tero's series?

I added Tero's v3 patch 1,2,3,4 on top of my runtime changes

console gets looped with below prints during bootup [1]
not sure whats happening need to look into it.

[1]:
http://pastebin.com/C55gtGhp

<<SNIP>>

[    2.740692] Registering the dns_resolver key type
[    2.746490] VFP support v0.3: implementor 41 architecture 3 part 30
variant c rev 1
[    2.754669] ThumbEE CPU extension supported.
[    2.772583] irq 368, desc: c0635540, depth: 1, count: 0, unhandled: =
0
[    2.779388] ->handle_irq():  c00e494c, handle_bad_irq+0x0/0x260
[    2.785675] ->irq_data.chip(): c067f254, no_irq_chip+0x0/0x5c
[    2.791748] ->action():   (null)
[    2.795166]    IRQ_NOPROBE set
[    2.798370]  IRQ_NOREQUEST set
[    2.801605] irq 368, desc: c0635540, depth: 1, count: 0, unhandled: =
0
[    2.808380] ->handle_irq():  c00e494c, handle_bad_irq+0x0/0x260
[    2.814636] ->irq_data.chip(): c067f254, no_irq_chip+0x0/0x5c
[    2.820709] ->action():   (null)
[    2.824127]    IRQ_NOPROBE set
[    2.827331]  IRQ_NOREQUEST set
[    2.830566] irq 368, desc: c0635540, depth: 1, count: 0, unhandled: =
0
[    2.837371] ->handle_irq():  c00e494c, handle_bad_irq+0x0/0x260
[    2.843627] ->irq_data.chip(): c067f254, no_irq_chip+0x0/0x5c
[    2.849700] ->action():   (null)

<<SNIP>>

--
Thanks,
Govindraj.R

>
>> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/pm24xx.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0 =A02 ++
>> =A0arch/arm/mach-omap2/pm34xx.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0 =A02 ++
>> =A0arch/arm/mach-omap2/serial.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0 23 +++++++++++++++++++++++
>> =A0arch/arm/plat-omap/include/plat/omap-serial.h | =A0 =A02 ++
>> =A0arch/arm/plat-omap/include/plat/serial.h =A0 =A0 =A0| =A0 =A01 +
>> =A0drivers/tty/serial/omap-serial.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 23 +++++++++++++++++++++++
>> =A06 files changed, 53 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24=
xx.c
>> index c405bda..ba58a1d 100644
>> --- a/arch/arm/mach-omap2/pm24xx.c
>> +++ b/arch/arm/mach-omap2/pm24xx.c
>> @@ -137,6 +137,8 @@ static void omap2_enter_full_retention(void)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP_SDRC_REGADDR=
(SDRC_DLLA_CTRL),
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP_SDRC_REGADDR=
(SDRC_POWER));
>>
>> + =A0 =A0 omap_uart_resume_idle();
>> +
>> =A0no_sleep:
>> =A0 =A0 =A0 if (omap2_pm_debug) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long long tmp;
>> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34=
xx.c
>> index ac7b7f8..3997e92 100644
>> --- a/arch/arm/mach-omap2/pm34xx.c
>> +++ b/arch/arm/mach-omap2/pm34xx.c
>> @@ -216,6 +216,8 @@ static int prcm_clear_mod_irqs(s16 module, u8 re=
gs)
>>
>> =A0 =A0 =A0 wkst =3D omap2_prm_read_mod_reg(module, wkst_off);
>> =A0 =A0 =A0 wkst &=3D omap2_prm_read_mod_reg(module, grpsel_off);
>> +
>> + =A0 =A0 c +=3D omap_uart_resume_idle();
>> =A0 =A0 =A0 if (wkst) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 iclk =3D omap2_cm_read_mod_reg(module, i=
clk_off);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 fclk =3D omap2_cm_read_mod_reg(module, f=
clk_off);
>> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/seri=
al.c
>> index 6ac078f..4bc5914 100644
>> --- a/arch/arm/mach-omap2/serial.c
>> +++ b/arch/arm/mach-omap2/serial.c
>> @@ -199,6 +199,28 @@ static void omap_serial_fill_default_pads(struc=
t omap_board_data *bdata)
>> =A0 =A0 =A0 }
>> =A0}
>>
>> +/* TBD: Will be removed once we have irq-chaing mechanism */
>
> s/TBD/FIXME/
>
>> +static bool omap_uart_chk_wakeup(struct platform_device *pdev)
>> +{
>> + =A0 =A0 struct omap_uart_port_info *up =3D pdev->dev.platform_data=
;
>> + =A0 =A0 struct omap_device *od;
>> + =A0 =A0 u32 wkst =3D 0;
>> + =A0 =A0 bool ret =3D false;
>> +
>> + =A0 =A0 od =3D to_omap_device(pdev);
>> + =A0 =A0 if (omap_hmwod_pad_get_wakeup_status(od->hwmods[0]))
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D true;
>> +
>> + =A0 =A0 /* Check for normal UART wakeup (and clear it) */
>> + =A0 =A0 wkst =3D __raw_readl(up->wk_st) & up->wk_mask;
>> + =A0 =A0 if (wkst) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(wkst, up->wk_st);
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D true;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return ret;
>> +}
>> +
>> =A0static void omap_uart_wakeup_enable(struct platform_device *pdev,=
 bool enable)
>> =A0{
>> =A0 =A0 =A0 struct omap_uart_port_info *up =3D pdev->dev.platform_da=
ta;
>> @@ -369,6 +391,7 @@ void __init omap_serial_init_port(struct omap_bo=
ard_data *bdata,
>> =A0 =A0 =A0 pdata->uartclk =3D OMAP24XX_BASE_BAUD * 16;
>> =A0 =A0 =A0 pdata->flags =3D UPF_BOOT_AUTOCONF;
>> =A0 =A0 =A0 pdata->enable_wakeup =3D omap_uart_wakeup_enable;
>> + =A0 =A0 pdata->chk_wakeup =3D omap_uart_chk_wakeup;
>> =A0 =A0 =A0 pdata->dma_enabled =3D info->dma_enabled;
>> =A0 =A0 =A0 pdata->dma_rx_buf_size =3D info->dma_rx_buf_size;
>> =A0 =A0 =A0 pdata->dma_rx_poll_rate =3D info->dma_rx_poll_rate;
>> diff --git a/arch/arm/plat-omap/include/plat/omap-serial.h b/arch/ar=
m/plat-omap/include/plat/omap-serial.h
>> index c5f4dd9..b5117bd 100644
>> --- a/arch/arm/plat-omap/include/plat/omap-serial.h
>> +++ b/arch/arm/plat-omap/include/plat/omap-serial.h
>> @@ -75,6 +75,7 @@ struct omap_uart_port_info {
>> =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0auto_sus_timeout; /*=
 Auto_suspend timeout */
>>
>> =A0 =A0 =A0 void (*enable_wakeup)(struct platform_device *, bool);
>> + =A0 =A0 bool (*chk_wakeup)(struct platform_device *);
>> =A0 =A0 =A0 void __iomem *wk_st;
>> =A0 =A0 =A0 void __iomem *wk_en;
>> =A0 =A0 =A0 u32 wk_mask;
>> @@ -132,6 +133,7 @@ struct uart_omap_port {
>> =A0 =A0 =A0 unsigned long =A0 =A0 =A0 =A0 =A0 port_activity;
>> =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0errata;
>> =A0 =A0 =A0 void (*enable_wakeup)(struct platform_device *, bool);
>> + =A0 =A0 bool (*chk_wakeup)(struct platform_device *);
>> =A0};
>>
>> =A0#endif /* __OMAP_SERIAL_H__ */
>> diff --git a/arch/arm/plat-omap/include/plat/serial.h b/arch/arm/pla=
t-omap/include/plat/serial.h
>> index ee758d4..44a42aa 100644
>> --- a/arch/arm/plat-omap/include/plat/serial.h
>> +++ b/arch/arm/plat-omap/include/plat/serial.h
>> @@ -109,6 +109,7 @@ extern void omap_serial_init(void);
>> =A0extern void omap_serial_board_init(struct omap_uart_port_info *pl=
atform_data);
>> =A0extern void omap_serial_init_port(struct omap_board_data *bdata,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct omap_uart_port_info *platform_dat=
a);
>> +extern u32 omap_uart_resume_idle(void);
>> =A0#endif
>>
>> =A0#endif
>> diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/o=
map-serial.c
>> index 307b7c6..c3561dd 100644
>> --- a/drivers/tty/serial/omap-serial.c
>> +++ b/drivers/tty/serial/omap-serial.c
>> @@ -43,6 +43,7 @@
>> =A0#include <plat/dmtimer.h>
>> =A0#include <plat/omap-serial.h>
>> =A0#include <plat/omap_device.h>
>> +#include <plat/serial.h>
>>
>> =A0static struct uart_omap_port *ui[OMAP_MAX_HSUART_PORTS];
>>
>> @@ -108,6 +109,27 @@ static inline void serial_omap_port_enable(stru=
ct uart_omap_port *up)
>> =A0 =A0 =A0 pm_runtime_get_sync(&up->pdev->dev);
>> =A0}
>>
>> +/* TBD: Should be removed once we irq-chaining mechanism in place *=
/
>> +u32 omap_uart_resume_idle()
>> +{
>> + =A0 =A0 int i;
>> + =A0 =A0 u32 ret =3D 0;
>> +
>> + =A0 =A0 for (i =3D 0; i < OMAP_MAX_HSUART_PORTS; i++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct uart_omap_port *up =3D ui[i];
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!up)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (up->chk_wakeup(up->pdev)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 serial_omap_port_enable(up=
);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 serial_omap_port_disable(u=
p);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret++;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 }
>> + =A0 =A0 return ret;
>> +}
>> +
>> =A0static void serial_omap_stop_rxdma(struct uart_omap_port *up)
>> =A0{
>> =A0 =A0 =A0 if (up->uart_dma.rx_dma_used) {
>> @@ -1392,6 +1414,7 @@ static int serial_omap_probe(struct platform_d=
evice *pdev)
>> =A0 =A0 =A0 up->uart_dma.uart_base =3D mem->start;
>> =A0 =A0 =A0 up->errata =3D omap_up_info->errata;
>> =A0 =A0 =A0 up->enable_wakeup =3D omap_up_info->enable_wakeup;
>> + =A0 =A0 up->chk_wakeup =3D omap_up_info->chk_wakeup;
>>
>> =A0 =A0 =A0 if (omap_up_info->dma_enabled) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->uart_dma.uart_dma_tx =3D dma_tx->sta=
rt;
>
> Kevin
> --
> To unsubscribe from this list: send the line "unsubscribe linux-seria=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
