From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH 2/2] tty: serial: OMAP: transmit FIFO threshold interrupts
 don't wake the chip
Date: Mon, 23 Jan 2012 15:20:16 +0530
Message-ID: <CAAL8m4z=eN8CN4f81PBmVPLcCm52s7Qf4SiOfafBm65SRdx7Pg@mail.gmail.com>
References: <20120121071934.18707.64258.stgit@dusk> <20120121072740.18707.87632.stgit@dusk>
 <CAAL8m4xAzAJWFZXaTeQQpTE2DbadH4zovSGcQsLjP=43GNiRiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:44576 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752971Ab2AWJuj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Jan 2012 04:50:39 -0500
In-Reply-To: <CAAL8m4xAzAJWFZXaTeQQpTE2DbadH4zovSGcQsLjP=43GNiRiA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Govindraj Raja <govindraj.raja@ti.com>, Kevin Hilman <khilman@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, alan@linux.intel.com

On Mon, Jan 23, 2012 at 2:20 PM, Govindraj <govindraj.ti@gmail.com> wro=
te:
> On Sat, Jan 21, 2012 at 12:57 PM, Paul Walmsley <paul@pwsan.com> wrot=
e:
>> It seems that when the transmit FIFO threshold is reached on OMAP
>> UARTs, it does not result in a PRCM wakeup. =A0This appears to be a
>> silicon bug. =A0This means that if the MPU powerdomain is in a low-p=
ower
>> state, the MPU will not be awakened to refill the FIFO until the nex=
t
>> interrupt from another device.
>>
>> The best solution, at least for the short term, would be for the OMA=
P
>> serial driver to call a OMAP subarchitecture function to prevent the
>> MPU powerdomain from entering a low power state while the FIFO has
>> data to transmit. =A0However, we no longer have a clean way to do th=
is,
>> since patches that add platform_data function pointers have been
>> deprecated by the OMAP maintainer. =A0So we attempt to work around t=
his
>> as well. =A0The workarounds depend on the setting of CONFIG_CPU_IDLE=
=2E
>>
>> When CONFIG_CPU_IDLE=3Dn, the driver will now only transmit one byte=
 at
>> a time. =A0This causes the transmit FIFO threshold interrupt to stay
>> active until there is no more data to be sent. =A0Thus, the MPU
>> powerdomain stays on during transmits. =A0Aside from that energy
>> consumption penalty, each transmitted byte results in a huge number =
of
>> UART interrupts -- about five per byte. =A0This wastes CPU time and =
is
>> quite inefficient, but is probably the most expedient workaround in
>> this case.
>>
>> When CONFIG_CPU_IDLE=3Dy, there is a slightly more direct workaround=
:
>> the PM QoS constraint can be abused to keep the MPU powerdomain on.
>> This results in a normal number of interrupts, but, similar to the
>> above workaround, wastes power by preventing the MPU from entering
>> WFI.
>>
>> Future patches are planned for the 3.4 merge window to implement mor=
e
>> efficient, but also more disruptive, workarounds to these problems.
>>
>
> With these two patches number of interrupts seems to increase by 24x
> after boot up.
>
> [...]
>
> / # cat /proc/interrupts | grep "UART2"
> =A074: =A0 =A0 =A0 3902 =A0 =A0 =A0INTC =A0OMAP UART2
> / #
> [...]
>
> without these two patches + cpu_idle enabled
>
> [...]
>
> / #
> / # cat /proc/interrupts | grep "UART2"
> =A074: =A0 =A0 =A0 =A0158 =A0 =A0 =A0INTC =A0OMAP UART2
> / #
>
> [...]
>
>
> I am using beagle xm and 3.3rc1
>
> Looks like there are far two many uart irqs which
> keeps the mpu busy and thus preventing uart sluggishness.
>

after looking in closely,
looks like every byte is getting transferred in case
of non cpu_idle cases causing 1 irq for each tx.


> --
> Thanks,
> Govindraj.R
>
>
>> DMA operation is unaffected by this patch.
>>
>> Signed-off-by: Paul Walmsley <paul@pwsan.com>
>> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
>> Cc: Govindraj Raja <govindraj.r@ti.com>
>> Cc: Kevin Hilman <khilman@ti.com>
>> ---
>> =A0arch/arm/plat-omap/include/plat/omap-serial.h | =A0 =A01
>> =A0drivers/tty/serial/omap-serial.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 51 +++++++++++++++++++++++++
>> =A02 files changed, 51 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/plat-omap/include/plat/omap-serial.h b/arch/ar=
m/plat-omap/include/plat/omap-serial.h
>> index 9ff4444..12a64eb 100644
>> --- a/arch/arm/plat-omap/include/plat/omap-serial.h
>> +++ b/arch/arm/plat-omap/include/plat/omap-serial.h
>> @@ -131,6 +131,7 @@ struct uart_omap_port {
>> =A0 =A0 =A0 =A0u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 context_l=
oss_cnt;
>> =A0 =A0 =A0 =A0u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 errata;
>> =A0 =A0 =A0 =A0u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0wakeups=
_enabled;
>> + =A0 =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0max_tx_c=
ount;
>>
>> =A0 =A0 =A0 =A0struct pm_qos_request =A0 pm_qos_request;
>> =A0 =A0 =A0 =A0u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 latency;
>> diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/o=
map-serial.c
>> index 9de7d71..621fde5 100644
>> --- a/drivers/tty/serial/omap-serial.c
>> +++ b/drivers/tty/serial/omap-serial.c
>> @@ -88,6 +88,49 @@ static inline void serial_omap_clear_fifos(struct=
 uart_omap_port *up)
>> =A0 =A0 =A0 =A0serial_out(up, UART_FCR, 0);
>> =A0}
>>
>> +/**
>> + * serial_omap_block_cpu_low_power_state - prevent MPU pwrdm from l=
eaving ON
>> + * @up: struct uart_omap_port *
>> + *
>> + * Prevent the MPU powerdomain from entering a power state lower th=
an
>> + * ON. =A0(It should be sufficient to prevent it from entering INAC=
TIVE,
>> + * but there is presently no easy way to do this.) =A0This works ar=
ound
>> + * a suspected silicon bug in the OMAP UART IP blocks. =A0The UARTs=
 should
>> + * wake the PRCM when the transmit FIFO threshold interrupt is rais=
ed, but
>> + * they do not. =A0 See also serial_omap_allow_cpu_low_power_state(=
). =A0No
>> + * return value.
>> + */
>> +static void serial_omap_block_cpu_low_power_state(struct uart_omap_=
port *up)
>> +{
>> +#ifdef CONFIG_CPU_IDLE
>> + =A0 =A0 =A0 up->latency =3D 1;
>> + =A0 =A0 =A0 schedule_work(&up->qos_work);
>> +#else
>> + =A0 =A0 =A0 up->max_tx_count =3D 1;
>> +#endif
>> +}
>> +
>> +/**
>> + * serial_omap_allow_cpu_low_power_state - remove power state restr=
iction on MPU
>> + * @up: struct uart_omap_port *
>> + *
>> + * Cancel the effects of serial_omap_block_cpu_low_power_state().
>> + * This should allow the MPU powerdomain to enter a power state low=
er
>> + * than ON, assuming the rest of the kernel is not restricting it.
>> + * This works around a suspected silicon bug in the OMAP UART IP
>> + * blocks. =A0The UARTs should wake the PRCM when the transmit FIFO
>> + * threshold interrupt is raised, but they do not. =A0No return val=
ue.
>> + */
>> +static void serial_omap_allow_cpu_low_power_state(struct uart_omap_=
port *up)
>> +{
>> +#ifdef CONFIG_CPU_IDLE
>> + =A0 =A0 =A0 up->latency =3D up->calc_latency;
>> + =A0 =A0 =A0 schedule_work(&up->qos_work);
>> +#else
>> + =A0 =A0 =A0 up->max_tx_count =3D up->port.fifosize / 4;
>> +#endif
>> +}
>> +
>> =A0/*
>> =A0* serial_omap_get_divisor - calculate divisor value
>> =A0* @port: uart port info
>> @@ -163,6 +206,9 @@ static void serial_omap_stop_tx(struct uart_port=
 *port)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0serial_out(up, UART_IER, up->ier);
>> =A0 =A0 =A0 =A0}
>>
>> + =A0 =A0 =A0 if (!up->use_dma)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 serial_omap_allow_cpu_low_power_state(=
up);
>> +
>> =A0 =A0 =A0 =A0pm_runtime_mark_last_busy(&up->pdev->dev);
>> =A0 =A0 =A0 =A0pm_runtime_put_autosuspend(&up->pdev->dev);
>> =A0}
>> @@ -264,7 +310,7 @@ static void transmit_chars(struct uart_omap_port=
 *up)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0serial_omap_stop_tx(&up->port);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
>> =A0 =A0 =A0 =A0}
>> - =A0 =A0 =A0 count =3D up->port.fifosize / 4;
>> + =A0 =A0 =A0 count =3D up->max_tx_count;
>> =A0 =A0 =A0 =A0do {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0serial_out(up, UART_TX, xmit->buf[xmi=
t->tail]);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0xmit->tail =3D (xmit->tail + 1) & (UA=
RT_XMIT_SIZE - 1);
>> @@ -297,6 +343,7 @@ static void serial_omap_start_tx(struct uart_por=
t *port)
>>
>> =A0 =A0 =A0 =A0if (!up->use_dma) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pm_runtime_get_sync(&up->pdev->dev);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 serial_omap_block_cpu_low_power_state(=
up);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0serial_omap_enable_ier_thri(up);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pm_runtime_mark_last_busy(&up->pdev->=
dev);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pm_runtime_put_autosuspend(&up->pdev-=
>dev);
>> @@ -1421,6 +1468,8 @@ static int serial_omap_probe(struct platform_d=
evice *pdev)
>> =A0 =A0 =A0 =A0up->port.fifosize =3D 64;
>> =A0 =A0 =A0 =A0up->port.ops =3D &serial_omap_pops;
>>
>> + =A0 =A0 =A0 up->max_tx_count =3D up->port.fifosize / 4;
>> +
>> =A0 =A0 =A0 =A0if (pdev->dev.of_node)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0up->port.line =3D of_alias_get_id(pde=
v->dev.of_node, "serial");
>> =A0 =A0 =A0 =A0else
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-seri=
al" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
