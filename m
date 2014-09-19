From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [RFC] ARM: edma: unconditionally ack the error interrupt
Date: Sat, 20 Sep 2014 00:29:01 +0300
Message-ID: <541CA01D.1000006@ti.com>
References: <1410377960-26921-1-git-send-email-bigeasy@linutronix.de> <541AA900.4080506@ti.com> <20140918161225.GA10232@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140918161225.GA10232@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 09/18/2014 07:12 PM, Sebastian Andrzej Siewior wrote:
> * Peter Ujfalusi | 2014-09-18 12:42:24 [+0300]:
>=20
>> My hunch on what could be causing this that we might have unhandled =
dma event
>> and another comes. This will flag the EDMA_EMR register. Any change =
in this
>> register will assert error interrupt which can only be cleared by wr=
iting to
>> EDMA_EMRC register.
>> The EDMA_EMRC register bits also cleared on edma_start(), edma_stop(=
) and
>> edma_clean_channel() apart from the error interrupt handler.
>> So it is possible that we have missed event on one of the channels b=
ut a stop
>> might clear the event so in the interrupt hander we do not see this.
>> I think it would be good to understand what is going on the backroun=
d...
>> Can you print out the EDMA_EMCR just before we clear it in the place=
s I have
>> mentioned? We might get better understanding on which stage we clear=
 it and
>> probably we can understand how to fix this properly so we are not go=
ing to
>> have missed events on channels.
>=20
> Okay. For the protocol I applied this patch:
>=20
> diff --git a/arch/arm/common/edma.c b/arch/arm/common/edma.c
> index 160460ae3a49..16598625a4d1 100644
> --- a/arch/arm/common/edma.c
> +++ b/arch/arm/common/edma.c
> @@ -422,20 +422,24 @@ static irqreturn_t dma_ccerr_handler(int irq, v=
oid *data)
>  	int i;
>  	int ctlr;
>  	unsigned int cnt =3D 0;
> +	u32 emr0;
> =20
>  	ctlr =3D irq2ctlr(irq);
>  	if (ctlr < 0)
>  		return IRQ_NONE;
> =20
>  	dev_dbg(data, "dma_ccerr_handler\n");
> +	emr0 =3D edma_read_array(ctlr, EDMA_EMR, 0);
> =20
> -	if ((edma_read_array(ctlr, EDMA_EMR, 0) =3D=3D 0) &&
> +	if ((emr0 =3D=3D 0) &&
>  	    (edma_read_array(ctlr, EDMA_EMR, 1) =3D=3D 0) &&
>  	    (edma_read(ctlr, EDMA_QEMR) =3D=3D 0) &&
>  	    (edma_read(ctlr, EDMA_CCERR) =3D=3D 0)) {
>  		edma_write(ctlr, EDMA_EEVAL, 1);
> +		trace_printk("Unhandled\n");
>  		return IRQ_NONE;
>  	}
> +	trace_printk("emr0: %x\n", emr0);
> =20
>  	while (1) {
>  		int j =3D -1;
> @@ -1310,6 +1314,9 @@ int edma_start(unsigned channel)
>  		pr_debug("EDMA: ER%d %08x\n", j,
>  			edma_shadow0_read_array(ctlr, SH_ER, j));
>  		/* Clear any pending event or error */
> +		trace_printk("j%d mask%x EDMA_EMCR: %x\n",
> +			     j, mask,
> +			     edma_read_array(ctlr, EDMA_EMCR, j));
>  		edma_write_array(ctlr, EDMA_ECR, j, mask);
>  		edma_write_array(ctlr, EDMA_EMCR, j, mask);
>  		/* Clear any SER */
> @@ -1347,6 +1354,9 @@ void edma_stop(unsigned channel)
>  		edma_shadow0_write_array(ctlr, SH_EECR, j, mask);
>  		edma_shadow0_write_array(ctlr, SH_ECR, j, mask);
>  		edma_shadow0_write_array(ctlr, SH_SECR, j, mask);
> +		trace_printk("j%d mask%x EDMA_EMCR: %x\n",
> +			     j, mask,
> +			     edma_read_array(ctlr, EDMA_EMCR, j));
>  		edma_write_array(ctlr, EDMA_EMCR, j, mask);
> =20
>  		pr_debug("EDMA: EER%d %08x\n", j,
> @@ -1387,6 +1397,9 @@ void edma_clean_channel(unsigned channel)
>  				edma_read_array(ctlr, EDMA_EMR, j));
>  		edma_shadow0_write_array(ctlr, SH_ECR, j, mask);
>  		/* Clear the corresponding EMR bits */
> +		trace_printk("j%d mask%x EDMA_EMCR: %x\n",
> +			     j, mask,
> +			     edma_read_array(ctlr, EDMA_EMCR, j));
>  		edma_write_array(ctlr, EDMA_EMCR, j, mask);
>  		/* Clear any SER */
>  		edma_shadow0_write_array(ctlr, SH_SECR, j, mask);
>=20
> --
>=20
> and the result is something like this:
>=20
>            <idle>-0     [000] dnh.   303.356403: edma_start: j0 mask8=
000000 EDMA_EMCR: 0
>            <idle>-0     [000] d.h.   303.396721: edma_stop: j0 mask80=
00000 EDMA_EMCR: 0
>            <idle>-0     [000] dnh.   303.557103: edma_start: j0 mask8=
000000 EDMA_EMCR: 0
>            <idle>-0     [000] dnh.   303.557129: edma_stop: j0 mask40=
00000 EDMA_EMCR: 0
>            <idle>-0     [000] dnH.   303.557142: dma_ccerr_handler: U=
nhandled
>              less-2612  [000] d...   303.557237: edma_start: j0 mask4=
000000 EDMA_EMCR: 0
>              less-2612  [000] d.h.   303.562491: edma_stop: j0 mask40=
00000 EDMA_EMCR: 0
>              less-2612  [000] d...   303.564475: edma_start: j0 mask4=
000000 EDMA_EMCR: 0
>=20
> The full trace is at [0]. I haven't found a single entry where EDMA_E=
MCR
> was !=3D 0 at those spots. *If* there is a edma_stop() before the
> interrupt then the interrupt remains unhandled. If there is a
> edma_start() with mask 8000000 then we have dma_ccerr_handler() with =
a
> mask of 4000000.

mask 8000000 means URXEVT0 (UART0 rx), 4000000 is UTXEVT0 (UART0 tx) ev=
ents.
But it is clear that my theory was not even close to what's going on.
Do you have some tool which can be used to reproduce this issue?

>=20
> Fun fact: If I remove the write access to EDMA_EMCR register (the wri=
te
> access after the read out) then I haven't seen [1] a single error int=
errupt
> beeing "unhandled" out of 9. The former has three out of eight.

Hrm, this is interesting. Am I interpret it right:
if you clear the event missed register's bit for the event, you will re=
ceive
the interrupt, but there if you read the EMR bits, they are all 0.
if you do not clear the bit in the event missed register (even if it is=
 not
set) you will not receive the error interrupt. Right?

I think this can be due to the fact how edma (if I read the TRM right) =
works:
the error irq will be asserted if there is a transition from 0 to 1 in =
one of
the error registers. If you had error and you did not cleared the error=
 bit,
the next error will not going to cause another transition so no interru=
pt will
be triggered. Having said that, there should be at least one error inte=
rrupt
coming since at some point we should have had 0 -> 1 transition...

Can you print out also the EDMA_EMR at places you were printing EDMA_EM=
CR?

>=20
> [0] https://breakpoint.cc/edma_trace.txt.xz
> [1] https://breakpoint.cc/edma_trace_nowrite.txt.xz
>=20
> Sebastian
>=20


thanks,
P=C3=A9ter
