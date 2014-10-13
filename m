From: Frans Klaver <frans.klaver@xsens.com>
Subject: Re: [PATCH 09/16] tty: serial: 8250_dma: Add a TX trigger workaround
 for AM33xx
Date: Mon, 13 Oct 2014 16:55:34 +0200
Message-ID: <20141013145534.GB25389@ci00147.xsens-tech.local>
References: <541716DC.9020904@linutronix.de>
 <20140917102812.GA20438@ci00147.xsens-tech.local>
 <20140921204100.GA10111@linutronix.de>
 <20140922092853.GH20438@ci00147.xsens-tech.local>
 <20140925151403.GH19396@linutronix.de>
 <20140929085042.GA13952@ci00147.xsens-tech.local>
 <20140929095440.GB13142@linutronix.de>
 <20140929103042.GA31111@ci00147.xsens-tech.local>
 <20140930084416.GB31111@ci00147.xsens-tech.local>
 <20141002102723.GB23661@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20141002102723.GB23661@linutronix.de>
Sender: linux-serial-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Peter Hurley <peter@hurleysoftware.com>, tony@atomide.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, balbi@ti.com, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Alan Cox <alan@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

On Thu, Oct 02, 2014 at 12:27:23PM +0200, Sebastian Andrzej Siewior wro=
te:
> * Frans Klaver | 2014-09-30 10:44:16 [+0200]:
>=20
> >       uart_test-483   [000] dnh.    17.861018: serial8250_interrupt=
: irq 89
> >       uart_test-483   [000] dnh.    17.861026: serial8250_interrupt=
: 89 e
> e? Did was the routine invoked 0xe times or this a register?

No, this marks the end of serial8250_interrupt().


> >       uart_test-479   [000] d.H.    17.861124: serial8250_interrupt=
: irq 89
> >       uart_test-479   [000] d.H.    17.861133: serial8250_handle_ir=
q: l1 IIR cc LSR 61
> >       uart_test-479   [000] d.H.    17.861135: serial8250_handle_ir=
q: rx_dma(up, iir)
> >       uart_test-479   [000] d.H.    17.861139: serial8250_rx_dma: l=
1, UART_IIR_RX_TIMEOUT
> >       uart_test-479   [000] d.H.    17.861147: __dma_rx_do_complete=
: error: 1, uart_bug_dma: 32
> >       uart_test-479   [000] d.H.    17.861150: serial8250_handle_ir=
q: rx_chars(up, status)
> >       uart_test-479   [000] d.H.    17.861190: serial8250_handle_ir=
q: rx_dma(up, 0)
> timeout, manual purge. Do you have an idea how many bytes were manual=
ly
> received?

Here's an excerpt from a new trial using v10
(previous was v10_pre3). We manually read 10 bytes before we start
trying to get all bytes without dma.=20

       uart_test-483   [000] dnH.    18.182647: serial8250_interrupt: i=
rq 89
       uart_test-483   [000] dnH.    18.182653: omap_8250_dma_handle_ir=
q: rx_dma(up, iir)
       uart_test-483   [000] dnH.    18.182655: omap_8250_rx_dma: UART_=
IIR_RX_TIMEOUT
       uart_test-483   [000] dnH.    18.182657: omap_8250_rx_dma: rx wa=
s running
       uart_test-483   [000] dnH.    18.182662: __dma_rx_do_complete: c=
ount =3D 0
       uart_test-483   [000] dnH.    18.182666: omap_8250_dma_handle_ir=
q: rx_chars(up, status)
       uart_test-483   [000] dnH.    18.182683: serial8250_rx_chars: by=
tes read =3D 10
       uart_test-483   [000] dnH.    18.182685: omap_8250_dma_handle_ir=
q: rx_dma(up, 0)
       uart_test-483   [000] dnH.    18.182698: omap_8250_dma_handle_ir=
q: rpm_put(up)
       uart_test-483   [000] dnH.    18.182701: serial8250_interrupt: 8=
9 end
       uart_test-488   [000] ..s.    18.185353: __dma_rx_do_complete: c=
ount =3D 48
       uart_test-488   [000] ..s.    18.185366: __dma_rx_do_complete: r=
x_dma(p, 0)
     kworker/0:1-10    [000] d.H.    18.185486: serial8250_interrupt: i=
rq 89
     kworker/0:1-10    [000] d.H.    18.185496: omap_8250_dma_handle_ir=
q: rpm_put(up)
     kworker/0:1-10    [000] d.H.    18.185501: serial8250_interrupt: 8=
9 end
     kworker/0:1-10    [000] ..s.    18.185520: __dma_rx_do_complete: c=
ount =3D 48
     kworker/0:1-10    [000] ..s.    18.185526: __dma_rx_do_complete: r=
x_dma(p, 0)

Below things go downhill again.

     kworker/0:1-10    [000] ..s.    18.227273: __dma_rx_do_complete: r=
x_dma(p, 0)
       uart_test-483   [000] ..s.    18.227396: __dma_rx_do_complete: c=
ount =3D 48
       uart_test-483   [000] ..s.    18.227404: __dma_rx_do_complete: r=
x_dma(p, 0)
       uart_test-485   [000] .ns.    18.227540: __dma_rx_do_complete: c=
ount =3D 48
       uart_test-485   [000] .ns.    18.227547: __dma_rx_do_complete: r=
x_dma(p, 0)
     kworker/0:2-65    [000] ..s.    18.227660: __dma_rx_do_complete: c=
ount =3D 48
     kworker/0:2-65    [000] ..s.    18.227667: __dma_rx_do_complete: r=
x_dma(p, 0)
     kworker/0:1-10    [000] .ns.    18.227786: __dma_rx_do_complete: c=
ount =3D 48
     kworker/0:1-10    [000] .ns.    18.227793: __dma_rx_do_complete: r=
x_dma(p, 0)
       uart_test-477   [000] ..s.    18.227921: __dma_rx_do_complete: c=
ount =3D 48
       uart_test-477   [000] ..s.    18.227928: __dma_rx_do_complete: r=
x_dma(p, 0)
       uart_test-481   [000] ..s.    18.228051: __dma_rx_do_complete: c=
ount =3D 48
       uart_test-481   [000] ..s.    18.228057: __dma_rx_do_complete: r=
x_dma(p, 0)
     kworker/0:1-10    [000] ..s.    18.228185: __dma_rx_do_complete: c=
ount =3D 48
     kworker/0:1-10    [000] ..s.    18.228191: __dma_rx_do_complete: r=
x_dma(p, 0)
       uart_test-485   [000] ..s.    18.228318: __dma_rx_do_complete: c=
ount =3D 48
       uart_test-485   [000] ..s.    18.228324: __dma_rx_do_complete: r=
x_dma(p, 0)
       uart_test-488   [000] d.h.    18.228445: serial8250_interrupt: i=
rq 89
       uart_test-488   [000] d.h.    18.228454: omap_8250_dma_handle_ir=
q: rpm_put(up)
       uart_test-488   [000] d.h.    18.228459: serial8250_interrupt: 8=
9 end
       uart_test-488   [000] d.H.    18.228472: serial8250_interrupt: i=
rq 89
       uart_test-488   [000] d.H.    18.228477: omap_8250_dma_handle_ir=
q: rx_dma(up, iir)
       uart_test-488   [000] d.H.    18.228479: omap_8250_rx_dma: UART_=
IIR_RX_TIMEOUT
       uart_test-488   [000] d.H.    18.228480: omap_8250_rx_dma: rx wa=
s running
       uart_test-488   [000] d.H.    18.228487: __dma_rx_do_complete: c=
ount =3D 48
       uart_test-488   [000] d.H.    18.228500: omap_8250_dma_handle_ir=
q: rx_chars(up, status)
       uart_test-488   [000] d.H.    18.228517: serial8250_rx_chars: by=
tes read =3D 10
       uart_test-488   [000] d.H.    18.228519: omap_8250_dma_handle_ir=
q: rx_dma(up, 0)
       uart_test-488   [000] d.H.    18.228534: omap_8250_dma_handle_ir=
q: rpm_put(up)
       uart_test-488   [000] d.H.    18.228540: serial8250_interrupt: 8=
9 end
     kworker/0:1-10    [000] dnh.    18.234930: serial8250_interrupt: i=
rq 89
     kworker/0:1-10    [000] dnh.    18.235074: omap_8250_dma_handle_ir=
q: rx_dma(up, iir)
     kworker/0:1-10    [000] dnh.    18.235123: omap_8250_rx_dma: UART_=
IIR_RX_TIMEOUT
     kworker/0:1-10    [000] dnh.    18.235159: omap_8250_rx_dma: rx wa=
s running
     kworker/0:1-10    [000] dnh.    18.235334: __dma_rx_do_complete: c=
ount =3D 48
     kworker/0:1-10    [000] dnh.    18.235455: omap_8250_dma_handle_ir=
q: rx_chars(up, status)
     kworker/0:1-10    [000] dnh.    18.238523: serial8250_rx_chars: by=
tes read =3D 256
     kworker/0:1-10    [000] dnh.    18.238566: omap_8250_dma_handle_ir=
q: rx_dma(up, 0)
     kworker/0:1-10    [000] dnh.    18.239169: omap_8250_dma_handle_ir=
q: rx_dma(up, iir)
     kworker/0:1-10    [000] dnh.    18.239223: omap_8250_rx_dma: UART_=
IIR_RX_TIMEOUT
     kworker/0:1-10    [000] dnh.    18.239256: omap_8250_rx_dma: rx wa=
s running
     kworker/0:1-10    [000] dnh.    18.239377: __dma_rx_do_complete: c=
ount =3D 0
     kworker/0:1-10    [000] dnh.    18.239449: omap_8250_dma_handle_ir=
q: rx_chars(up, status)
     kworker/0:1-10    [000] dnh.    18.242576: serial8250_rx_chars: by=
tes read =3D 256
     kworker/0:1-10    [000] dnh.    18.242620: omap_8250_dma_handle_ir=
q: rx_dma(up, 0)
     kworker/0:1-10    [000] dnh.    18.242878: omap_8250_dma_handle_ir=
q: rx_dma(up, iir)
     kworker/0:1-10    [000] dnh.    18.242921: omap_8250_rx_dma: UART_=
IIR_RX_TIMEOUT
     kworker/0:1-10    [000] dnh.    18.242954: omap_8250_rx_dma: rx wa=
s running
     kworker/0:1-10    [000] dnh.    18.243064: __dma_rx_do_complete: c=
ount =3D 0
     kworker/0:1-10    [000] dnh.    18.243127: omap_8250_dma_handle_ir=
q: rx_chars(up, status)
     kworker/0:1-10    [000] dnh.    18.246238: serial8250_rx_chars: by=
tes read =3D 256
     kworker/0:1-10    [000] dnh.    18.246283: omap_8250_dma_handle_ir=
q: rx_dma(up, 0)
     kworker/0:1-10    [000] dnh.    18.246524: omap_8250_dma_handle_ir=
q: rx_dma(up, iir)
     kworker/0:1-10    [000] dnh.    18.246563: omap_8250_rx_dma: UART_=
IIR_RX_TIMEOUT
     kworker/0:1-10    [000] dnh.    18.246599: omap_8250_rx_dma: rx wa=
s running
     kworker/0:1-10    [000] dnh.    18.246702: __dma_rx_do_complete: c=
ount =3D 0

> >     kworker/0:1-10    [000] dnH.    20.027093: serial8250_interrupt=
: serial8250: too much work for irq89
> >     kworker/0:1-10    [000] dnH.    20.027181: serial8250_interrupt=
: 89 e
> >
> >This clogs the entire system until I disconnect the communication li=
nes.
> >
> >So we get an RX timeout. The receiver fifo trigger level was not rea=
ched
> >and 8250_core is left to copy the remaining data. I would expect tha=
t if
> >the trigger level wasn't reached, we wouldn't need to be doing this =
that
> >often. On the other hand, could we be trapped reading data from rx
> >without dma helping us? And how could we resolve this?
>=20
> So if I understand you correct, then you enter serial8250_interrupt()
> and then you enter multiple times omap_8250_dma_handle_irq() and
> you always get a TIMEOUT event and fetch byte(s) manualy via
> serial8250_rx_chars(). And after one iteration UART_IIR_NO_INT is not
> set and you do it again, right?

That's what it looks like, yes.


> I have no idea when exactly the timeout-interrupt fires. The manual
> says: "=E2=80=A6 the count is reset when there is activity on uarti_r=
x =E2=80=A6" but it
> does not say how often it increments before the level is reached.
> It also might be that you have a small gap between two bytes and this
> high baud rate the gap is considered as a timeout event.
>=20
> Another thing could be that if the we enqueue a RX transfer from the
> dma_completion callback then we have too many bytes in the FIFO alrea=
dy
> becahse the callback is invoked from softirq. What happens if we cut =
the
> middle man via
>=20
>=20
> diff --git a/drivers/dma/virt-dma.c b/drivers/dma/virt-dma.c
> index 6f80432..21b04bd 100644
> --- a/drivers/dma/virt-dma.c
> +++ b/drivers/dma/virt-dma.c
> @@ -63,8 +63,9 @@ static void vchan_complete(unsigned long arg)
>  	dma_async_tx_callback cb =3D NULL;
>  	void *cb_data =3D NULL;
>  	LIST_HEAD(head);
> +	unsigned long flags;
> =20
> -	spin_lock_irq(&vc->lock);
> +	spin_lock_irqsave(&vc->lock, flags);
>  	list_splice_tail_init(&vc->desc_completed, &head);
>  	vd =3D vc->cyclic;
>  	if (vd) {
> @@ -72,7 +73,7 @@ static void vchan_complete(unsigned long arg)
>  		cb =3D vd->tx.callback;
>  		cb_data =3D vd->tx.callback_param;
>  	}
> -	spin_unlock_irq(&vc->lock);
> +	spin_unlock_irqrestore(&vc->lock, flags);
> =20
>  	if (cb)
>  		cb(cb_data);
> diff --git a/drivers/dma/virt-dma.h b/drivers/dma/virt-dma.h
> index 181b952..7632338 100644
> --- a/drivers/dma/virt-dma.h
> +++ b/drivers/dma/virt-dma.h
> @@ -92,7 +92,10 @@ static inline void vchan_cookie_complete(struct vi=
rt_dma_desc *vd)
>  		 vd, cookie);
>  	list_add_tail(&vd->node, &vc->desc_completed);
> =20
> -	tasklet_schedule(&vc->task);
> +	if (vd->tx.my_uart)
> +		vc->task.func(vc);
> +	else
> +		tasklet_schedule(&vc->task);
>  }
> =20
>  /**
> diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial=
/8250/8250_omap.c
> index 57a8b12..5d7ee92 100644
> --- a/drivers/tty/serial/8250/8250_omap.c
> +++ b/drivers/tty/serial/8250/8250_omap.c
> @@ -728,6 +728,7 @@ static int omap_8250_rx_dma(struct uart_8250_port=
 *p, unsigned int iir)
>  	dma->rx_running =3D 1;
>  	desc->callback =3D __dma_rx_complete;
>  	desc->callback_param =3D p;
> +	desc->my_uart =3D 1;
> =20
>  	dma->rx_cookie =3D dmaengine_submit(desc);
> =20
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index 1f9e642..0f5fbe1 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -459,6 +459,7 @@ struct dmaengine_unmap_data {
>  struct dma_async_tx_descriptor {
>  	dma_cookie_t cookie;
>  	enum dma_ctrl_flags flags; /* not a 'long' to pack with cookie */
> +	u32 my_uart;
>  	dma_addr_t phys;
>  	struct dma_chan *chan;
>  	dma_cookie_t (*tx_submit)(struct dma_async_tx_descriptor *tx);
>=20

[  251.363111] BUG: spinlock recursion on CPU#0, swapper/0
[  251.368394]  lock: 0xcf151dc4, .magic: dead4ead, .owner: swapper/0, =
=2Eowner_cpu: 0
[  251.375920] CPU: 0 PID: 0 Comm: swapper Not tainted 3.17.0-rc5-00141=
-geccc467-dirty #35
[  251.384012] [<c0013454>] (unwind_backtrace) from [<c00113b0>] (show_=
stack+0x10/0x14)
[  251.391811] [<c00113b0>] (show_stack) from [<c0055cdc>] (do_raw_spin=
_lock+0x48/0x110)
[  251.399703] [<c0055cdc>] (do_raw_spin_lock) from [<c04dbef0>] (_raw_=
spin_lock_irqsave+0x10/0x18)
[  251.408544] [<c04dbef0>] (_raw_spin_lock_irqsave) from [<c0221f74>] =
(vchan_complete+0x1c/0xe8)
[  251.417207] [<c0221f74>] (vchan_complete) from [<c0222f54>] (edma_ca=
llback+0x138/0x274)
[  251.425259] [<c0222f54>] (edma_callback) from [<c001a844>] (dma_irq_=
handler+0x154/0x190)
[  251.433406] [<c001a844>] (dma_irq_handler) from [<c005b2dc>] (handle=
_irq_event_percpu+0x2c/0x130)
[  251.442331] [<c005b2dc>] (handle_irq_event_percpu) from [<c005b41c>]=
 (handle_irq_event+0x3c/0x5c)
[  251.451254] [<c005b41c>] (handle_irq_event) from [<c005d940>] (handl=
e_level_irq+0xd0/0x108)
[  251.459655] [<c005d940>] (handle_level_irq) from [<c005acc0>] (gener=
ic_handle_irq+0x20/0x30)
[  251.468144] [<c005acc0>] (generic_handle_irq) from [<c000ee2c>] (han=
dle_IRQ+0x60/0x80)
[  251.476109] [<c000ee2c>] (handle_IRQ) from [<c0008654>] (omap3_intc_=
handle_irq+0x64/0x8c)
[  251.484337] [<c0008654>] (omap3_intc_handle_irq) from [<c0011dc0>] (=
__irq_svc+0x40/0x54)
[  251.492466] Exception stack(0xc0725f68 to 0xc0725fb0)
[  251.497549] 5f60:                   00000000 c0757160 00000000 c0018=
fc0 c0724000 c0724038
[  251.505772] 5f80: c078de40 c072c040 c0714124 cfefc4c0 00000000 00000=
000 c0757160 c0725fb0
[  251.513989] 5fa0: c000ef40 c000ef44 60000013 ffffffff
[  251.519077] [<c0011dc0>] (__irq_svc) from [<c000ef44>] (arch_cpu_idl=
e+0x2c/0x38)
[  251.526517] [<c000ef44>] (arch_cpu_idle) from [<c005255c>] (cpu_star=
tup_entry+0x9c/0xf0)
[  251.534664] [<c005255c>] (cpu_startup_entry) from [<c06e5b34>] (star=
t_kernel+0x308/0x360)

I should probably take out the spin_lock calls if vd->tx.my_uart is 1?

Thanks,
=46rans
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
