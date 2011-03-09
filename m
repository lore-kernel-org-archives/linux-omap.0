From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH 2/7] OMAP2+: mux: Enable wakeup for wakeup enable
 requested pads
Date: Wed, 9 Mar 2011 20:15:29 +0530
Message-ID: <AANLkTimGdDrJvyyFFz6T_WFhVkbUhVMd-+iiMqAKNNh6@mail.gmail.com>
References: <1299064343-28534-1-git-send-email-govindraj.raja@ti.com>
 <87lj0u8mrf.fsf@ti.com> <AANLkTin2f7n-v5Hg7NHB8a4fEmpzt_07xy-M1wjnKHtU@mail.gmail.com>
 <87mxl5m6wp.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <87mxl5m6wp.fsf@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>
List-Id: linux-omap@vger.kernel.org

On Wed, Mar 9, 2011 at 6:44 AM, Kevin Hilman <khilman@ti.com> wrote:
> Govindraj <govindraj.ti@gmail.com> writes:
>
>> Module level wakeup doesn't seem to work and only
>> way it seem to wakeup is through using resume_idle
>> from sram_idle.
>
> Have you verified if the module wakeups themselves are not working, o=
r
> just that the wakeup is not propagating to a device IRQ?
>

Actually the wakeup happens but control never moves to uart isr
Gets looped for ever in clearing wakeup status in prcm_irq_handler
path.

--> omap2_cm_rmw_mod_reg_bits
     ---> prcm_clear_mod_irqs
          ---> prcm_interrupt_handler

it gets looped here forever.


> As a quick test, I did a suspend-only test shows that module-level
> wakeups (at least from PER UART) are working.
>
> On 3530/Beagle, which has console on UART3 (in PER), I successfully
> tested module level wakeups from suspend.
>
> First, I added a simple debug printk[1] to show the wakeup source.
> Then, I ensure CORE stays 'ON' during suspend. =A0If CORE stays on, t=
he IO
> ring is never armed, so only module wakeups can happen:
>
> =A0 # echo 3 > /debug/pm_debug/core_pwrdm/suspend
>
> then I suspend
>
> =A0 # echo mem > /sys/power/state
>
> and type a key on the console to wakeup, and I see:
>
> =A0 PRCM IRQ: mod 0x800: WKST=3D0x00000800

Yes Correct, here seems to work.


>
> Which shows PER wakeup from UART3. =A0If you do the same without sett=
ing
> CORE to ON, you'll see that the first wakeup is in the WKUP powerdoma=
in
> from the IO ring.
>
> So module-level wakeups are indeed working.
>
> The problem is actually not that module wakeups are working, but rath=
er
> that the module does not generate an interrupt upon wakeup if it is
> idle. =A0The resume_from_idle hack works because as soon as clocks ar=
e
> enabled, the module generates the interrupt (special thanks to Paul
> Walmsley for helping me understand this.)
>
>>
>> One simple way to reproduce the problem with
>> existing code base also is adding this patch which
>> will enable module level wakeup always.
>>
>> https://patchwork.kernel.org/patch/501211/
>>
>> and with below change.
>>
>> govindraj@Linux-BSP-Server:~/clones/linux-omap-2.6$ gd
>> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/seri=
al.c
>> index 47eef48..6343773 100644
>> --- a/arch/arm/mach-omap2/serial.c
>> +++ b/arch/arm/mach-omap2/serial.c
>> @@ -380,6 +380,7 @@ static void omap_uart_allow_sleep(struct
>> omap_uart_state *uart)
>> =A0 =A0 =A0 =A0 omap_uart_smart_idle_enable(uart, 1);
>> =A0 =A0 =A0 =A0 uart->can_sleep =3D 1;
>> =A0 =A0 =A0 =A0 del_timer(&uart->timer);
>> + =A0 =A0 =A0 omap_uart_disable_clocks(uart);
>> =A0}
>>
>> We can see module level wakeup doesn't wakeup the uart.
>> once we set sleep_timeout for uart and timer starts.
>
> The above change alone can never work. =A0I'm pretty sure you wouldn'=
t see
> IO-ring wakeups will not happen with this change either because the
> kernel will probably hang.
>
> If you disable the clocks here, then any console usage between the
> timeout and the idle path will hang the kernel. =A0You can't do this
> without taking the console lock. =A0Doing that will be much easier in=
 your
> new driver.

sorry forgot to specify here, to avoid above scenario I am suppressing
complete printk's using sysfs interface.
echo 0 > /proc/sys/kernel/printk
so by applying this patch and booting up and then suppressing printks
then setting uart timeout, after timeout hitting any key.
Similar behavior of always in loop to clear wakeup status.

--
Thanks,
Govindraj.R


>
> Kevin
>
>
> [1]
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34x=
x.c
> index 6e2bd38..677a235 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -219,6 +219,8 @@ static int prcm_clear_mod_irqs(s16 module, u8 reg=
s)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0iclk =3D omap2_cm_read_mod_reg(module,=
 iclk_off);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fclk =3D omap2_cm_read_mod_reg(module,=
 fclk_off);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0while (wkst) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk("PRCM IRQ: mod 0=
x%x: WKST=3D0x%08x\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0module, =
wkst);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0clken =3D wkst;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap2_cm_set_mod_reg_b=
its(clken, module, iclk_off);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
