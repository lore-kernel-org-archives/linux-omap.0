From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH v2 11/12] OMAP: Serial: Use resume call from prcm to
 enable uart
Date: Thu, 5 May 2011 17:16:37 +0530
Message-ID: <BANLkTi=32NfMr7exWpOoPHX7_-Jc0i5LqA@mail.gmail.com>
References: <1304080796-625-1-git-send-email-govindraj.raja@ti.com>
 <1304080796-625-12-git-send-email-govindraj.raja@ti.com> <87pqnym2f2.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <87pqnym2f2.fsf@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>
List-Id: linux-omap@vger.kernel.org

On Thu, May 5, 2011 at 5:41 AM, Kevin Hilman <khilman@ti.com> wrote:
> "Govindraj.R" <govindraj.raja@ti.com> writes:
>
>> Use resume idle call from prcm_irq to enable uart_port from low powe=
r states.
>> Add api to check pad wakeup status which will we used from uart_resu=
me func.
>> to enable back uart port if a wakeup event occurred.
>>
>> UART_Resume func. can be removed once we have irq_chaining functiona=
lity
>> available.
>>
>> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
>
> The part adding a new hwmod API needs to be separated out into a
> separate patch which is not dependent on the rest of this series.
>

ok. fine

>> ---
>> =A0arch/arm/mach-omap2/mux.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 | =A0 23 +++++++++++++++++++++++
>> =A0arch/arm/mach-omap2/mux.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 | =A0 13 +++++++++++++
>> =A0arch/arm/mach-omap2/omap_hwmod.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 13 +++++++++++++
>> =A0arch/arm/mach-omap2/pm24xx.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0 =A02 ++
>> =A0arch/arm/mach-omap2/pm34xx.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0 =A02 ++
>> =A0arch/arm/mach-omap2/serial.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0 23 +++++++++++++++++++++++
>> =A0arch/arm/plat-omap/include/plat/omap-serial.h | =A0 =A02 ++
>> =A0arch/arm/plat-omap/include/plat/omap_hwmod.h =A0| =A0 =A01 +
>> =A0arch/arm/plat-omap/include/plat/serial.h =A0 =A0 =A0| =A0 =A01 +
>> =A0drivers/tty/serial/omap-serial.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 23 +++++++++++++++++++++++
>> =A010 files changed, 103 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
>> index a4ab1e3..7149671 100644
>> --- a/arch/arm/mach-omap2/mux.c
>> +++ b/arch/arm/mach-omap2/mux.c
>> @@ -348,6 +348,29 @@ err1:
>> =A0 =A0 =A0 return NULL;
>> =A0}
>>
>> +/* Gets the wakeup status of given pad from omap-hwmod.
>> + * Returns the wake_up status bit of available pad mux pin
>> + */
>
> fix multi-line comment style
>

ok.

>> +bool omap_hwmod_mux_wakeup(struct omap_hwmod_mux_info *hmux)
>
> The name here should be more descriptive: like _get_wake_status or
> something.
>
>> +{
>> + =A0 =A0 int i;
>> + =A0 =A0 unsigned int val;
>> + =A0 =A0 u8 ret =3D 0;
>> +
>> + =A0 =A0 for (i =3D 0; i < hmux->nr_pads; i++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct omap_device_pad *pad =3D &hmux->pad=
s[i];
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 val =3D omap_mux_read(pad->partition,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 pad->mux->reg_offset);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (val & OMAP_WAKEUP_EVENT) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return ret;
>> +}
>> +
>> =A0/* Assumes the calling function takes care of locking */
>> =A0void omap_hwmod_mux(struct omap_hwmod_mux_info *hmux, u8 state)
>> =A0{
>> diff --git a/arch/arm/mach-omap2/mux.h b/arch/arm/mach-omap2/mux.h
>> index 137f321..379fb6e 100644
>> --- a/arch/arm/mach-omap2/mux.h
>> +++ b/arch/arm/mach-omap2/mux.h
>> @@ -225,8 +225,21 @@ omap_hwmod_mux_init(struct omap_device_pad *bpa=
ds, int nr_pads);
>> =A0 */
>> =A0void omap_hwmod_mux(struct omap_hwmod_mux_info *hmux, u8 state);
>>
>> +
>> +/**
>> + * omap_hwmod_mux_wakeup - omap hwmod check given pad had wakeup ev=
ent
>> + * @hmux: =A0 =A0 =A0 =A0 =A0 =A0Pads for a hwmod
>> + *
>> + * Called only from omap_hwmod.c, do not use.
>> + */
>
> Please put the kerneldoc comments in the C file instead of the header=
=2E
>

ok.

>> +bool omap_hwmod_mux_wakeup(struct omap_hwmod_mux_info *hmux);
>> =A0#else
>>
>> +static inline bool omap_hwmod_mux_wakeup(struct omap_hwmod_mux_info=
 *hmux)
>> +{
>> + =A0 =A0 return 0;
>> +}
>> +
>> =A0static inline int omap_mux_init_gpio(int gpio, int val)
>> =A0{
>> =A0 =A0 =A0 return 0;
>> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/=
omap_hwmod.c
>> index 4a12336..86cb8c4 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod.c
>> @@ -2403,3 +2403,16 @@ int omap_hwmod_enable_ioring_wakeup(struct om=
ap_hwmod *oh, bool enable)
>>
>> =A0 =A0 =A0 return ret;
>> =A0}
>> +
>> +/**
>> + * omap_hwmod_pad_wakeup_status - get pad wakeup status if mux is a=
vailable.
>
> How about _get_pad_wakeup_status()
>

Yes fine will update.

>> + * @oh: struct omap_hwmod *
>> + *
>> + * Returns the wake_up status bit of available pad mux pin.
>
> or on error... ?

-EINVAL. Will update the comments.

>
>> + */
>> +int omap_hmwod_pad_wakeup_status(struct omap_hwmod *oh)
>> +{
>> + =A0 =A0 if (oh->mux)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return omap_hwmod_mux_wakeup(oh->mux);
>> + =A0 =A0 return -EINVAL;
>> +}
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
>> index ce0ecdc..3960330 100644
>> --- a/arch/arm/mach-omap2/pm34xx.c
>> +++ b/arch/arm/mach-omap2/pm34xx.c
>> @@ -216,6 +216,8 @@ static int prcm_clear_mod_irqs(s16 module, u8 re=
gs)
>>
>> =A0 =A0 =A0 wkst =3D omap2_prm_read_mod_reg(module, wkst_off);
>> =A0 =A0 =A0 wkst &=3D omap2_prm_read_mod_reg(module, grpsel_off);
>> +
>> + =A0 =A0 c +=3D omap_uart_resume_idle();
>
> No...
>
> [...]
>
>> diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/o=
map-serial.c
>> index 9ed993c..eea478c 100644
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
>
> ...indeed...
>
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
>
> ... this is just putting back basically the same thing that was remov=
ed in
> patch 1. =A0IOW, this is now being checked for *every* PRCM wakeup, w=
hich
> is no different than having it in the idle path.
>
> I thought I understood that you had the SW IRQ triggering working, so
> this part should not be necessary.

Actually I tried few experiments but couldn't get it working.

Tried below but didn't help.

------------------------------------
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.=
c
index 3960330..2c1dfc2 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -288,6 +288,16 @@ static irqreturn_t prcm_interrupt_handler (int
irq, void *dev_id)
        do {
                if (irqstatus_mpu & (OMAP3430_WKUP_ST_MASK |
                                     OMAP3430_IO_ST_MASK)) {
+#if 1
+                       /*
+                        * EXP-1: SET UART1 SOFT IRQ BIT
+                        * 3430 -SDP UART1 console.
+                        * M_IRQ_72, INTCPS_ISR_SET
+                        * 0x4820 0090 + (0x20 * n)
+                        * bit-8 n =3D 2
+                        */
+                       __raw_writel(0x100 , 0x482000D0);
+#endif
                        c =3D _prcm_int_handle_wakeup();

                        /*

-----------------------------------

Currently we are planning to integrate irq_chaining patches
on top uart_runtime patches which is work-in-progress.
Will remove resume_idle once we have irq_chaining patches available.

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
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
