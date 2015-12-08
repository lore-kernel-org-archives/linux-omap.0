From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v2] irqchip: omap-intc: add support for spurious irq handling
Date: Tue, 8 Dec 2015 07:45:51 -0600
Message-ID: <87mvtlm4ts.fsf@saruman.tx.rr.com>
References: <0958510b69cf679fef64ccf535b1cdc43c5ffccc.1449572109.git.nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-="; micalg=pgp-sha1;
	protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0958510b69cf679fef64ccf535b1cdc43c5ffccc.1449572109.git.nsekhar@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>, Tony Lindgren <tony@atomide.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>
Cc: John Ogness <john.ogness@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Sekhar Nori <nsekhar@ti.com> writes:
> Under some conditions, irq sorting procedure used
> by INTC can go wrong resulting in a spurious irq
> getting reported.
>
> If this condition is not handled, it results in
> endless stream of:
>
>     unexpected IRQ trap at vector 00
>
> messages from ack_bad_irq()
>
> Handle the spurious interrupt condition in omap-intc
> driver to prevent this.
>
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> ---
> v2: increment error irq counter, use pr_err_once,
>     add a comment on tips to debug spurious irq
>     condition.
>
> This patch results in a checkpatch warning about
> extern definition of irq_err_count, but looks like
> thats the prevalent method of accessing that counter.
>
>  drivers/irqchip/irq-omap-intc.c | 27 ++++++++++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/irqchip/irq-omap-intc.c b/drivers/irqchip/irq-omap-i=
ntc.c
> index 8587d0f8d8c0..639708de5529 100644
> --- a/drivers/irqchip/irq-omap-intc.c
> +++ b/drivers/irqchip/irq-omap-intc.c
> @@ -47,6 +47,7 @@
>  #define INTC_ILR0		0x0100
>=20=20
>  #define ACTIVEIRQ_MASK		0x7f	/* omap2/3 active interrupt bits */
> +#define SPURIOUSIRQ_MASK	(0x1ffffff << 7)
>  #define INTCPS_NR_ILR_REGS	128
>  #define INTCPS_NR_MIR_REGS	4
>=20=20
> @@ -330,11 +331,35 @@ static int __init omap_init_irq(u32 base, struct de=
vice_node *node)
>  static asmlinkage void __exception_irq_entry
>  omap_intc_handle_irq(struct pt_regs *regs)
>  {
> +	extern unsigned long irq_err_count;
>  	u32 irqnr;
>=20=20
>  	irqnr =3D intc_readl(INTC_SIR);
> +
> +	/*
> +	 * A spurious IRQ can result if interrupt that triggered the
> +	 * sorting is no longer active during the sorting (10 INTC
> +	 * functional clock cycles after interrupt assertion). Or a
> +	 * change in interrupt mask affected the result during sorting
> +	 * time. There is no special handling required except ignoring
> +	 * the SIR register value just read and retrying.
> +	 * See section 6.2.5 of AM335x TRM Literature Number: SPRUH73K
> +	 *
> +	 * Many a times, a spurious interrupt situation has been fixed
> +	 * by adding a flush for the posted write acking the IRQ in
> +	 * the device driver. Typically, this is going be the device
> +	 * driver whose interrupt was handled just before the spurious
> +	 * IRQ occurred. Pay attention to those device drivers if you
> +	 * run into hitting the spurious IRQ condition below.
> +	 */
> +	if ((irqnr & SPURIOUSIRQ_MASK) =3D=3D SPURIOUSIRQ_MASK) {

sounds like unlikely() wouldn't hurt here.

> +		pr_err_once("%s: spurious irq!\n", __func__);
> +		irq_err_count++;
> +		omap_ack_irq(NULL);
> +		return;
> +	}
> +
>  	irqnr &=3D ACTIVEIRQ_MASK;
> -	WARN_ONCE(!irqnr, "Spurious IRQ ?\n");
>  	handle_domain_irq(domain, irqnr, regs);

care to run kernel function profiler against omap_intc_handle_irq()
before and after this patch ?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWZt8QAAoJEIaOsuA1yqRE9uUP/0U2GfIKS3iAXw4J4+2j2DRg
Wne/Y6avZccgOt8JF4eyZUM6hNjd3lXc/YxRc5c4lyDIMhVvHIOivRdj2nFQvE/C
iqrQFpGSljc3OVUgmLhmOiVLGrVD21jFKHkWEfwA1gVIwilJzeXKIwrYEUudSCJ1
SGv6b1qsXdfHoRTMjQRbBeQBUiYVZBFZQTsTe8NZmdkPL7FD2dnptWuMOTa6g7GU
dfGl28FSVzkzlwQ9QzoEDYkwcq8I19GpwTZnltKGsh2XE2r7uR96ZHYhUZ681H3+
q1Geryye26iv9fV2WZ6rxGEnc3Y89+hXQBQaUt5Rfo6f92ShUDiJn3ClD+Xn/CIn
WXxBmpDn/ljOU+kUuPZ6D4EAqPo1A6OHpMN1/0kGErOHlVXGiLFGOVYViJQ3vUV7
HV/C8cc24TIGQPBHSDJ1Bav31w67ay0XKaQuxFDHCnVADnQxy6dh7ic52Iq/gktm
HryGqi4rzsXtbTrULYdAzsLoClmlals26soXGbosyHKq5qvHk58qvol2LMKDtJ8k
Rz0kkCUc4ASxHG6JIb5HfzSf2Tcbhv8EByxmMk7bHtMbfJUSbDUSqnTYxwxSwiuR
oaX/6s5g22lDH9GQctCVj//6RxeeT90BVDqIYjA9Co1ezpg7rvOwzM0o7L5/SYbS
JNxgXSn7zutEhbA1VtWN
=oDLi
-----END PGP SIGNATURE-----
--=-=-=--
