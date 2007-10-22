From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 01/01] arch/arm/plat-omap/mcbsp.c
Date: Sun, 21 Oct 2007 17:00:50 -0700
Message-ID: <20071022000047.GC6984@atomide.com>
References: <ae36f8040709252025o3325b001k75d133411812f923@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <ae36f8040709252025o3325b001k75d133411812f923@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: =?iso-8859-1?Q?Lu=EDs?= Cargnini <lvcargnini@gmail.com>
Cc: OMAP <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

* Lu=EDs Cargnini <lvcargnini@gmail.com> [070925 20:26]:
> this patch modify the McBSP interrupt handling behavior turning the irq=
 of
> McBSP ports shared and it is working, I'm deveolping a device driver an=
d
> percepted that this is a change necessary for new device drivers could =
been
> implemented to tak advantage of McBSP and could use it, example is ADC
> communications throw McBSP interface for example, this modification do =
not
> harm the kernel and add more felxibility and functionality to the kerne=
l.
>=20
> -- linux-omap-2.6/arch/arm/plat-omap/mcbsp.c   2007-03-12
> 16:44:03.501890844-0300
> +++ linux-omap-2.6-instramed/arch/arm/plat-omap/mcbsp.c 2007-09-25 23:5=
8:
> 39.324154145 -0300
>=20
>  static irqreturn_t omap_mcbsp_tx_irq_handler(int irq, void *dev_id)
> @@ -304,7 +320,7 @@ int omap_mcbsp_request(unsigned int id)
>=20
>         if (mcbsp[id].io_type =3D=3D OMAP_MCBSP_IRQ_IO) {
>                 /* We need to get IRQs here */
> -               err =3D request_irq(mcbsp[id].tx_irq,
> omap_mcbsp_tx_irq_handler, 0,
> +               err =3D request_irq(mcbsp[id].tx_irq,
> omap_mcbsp_tx_irq_handler, IRQF_SHARED,
>                                   "McBSP",
>                                   (void *) (&mcbsp[id]));
>                 if (err !=3D 0) {
> @@ -315,8 +331,7 @@ int omap_mcbsp_request(unsigned int id)
>=20
>                 init_completion(&(mcbsp[id].tx_irq_completion));
>=20
> -
> -               err =3D request_irq(mcbsp[id].rx_irq,
> omap_mcbsp_rx_irq_handler, 0,
> +               err =3D request_irq(mcbsp[id].rx_irq,
> omap_mcbsp_rx_irq_handler, IRQF_SHARED,
>                                   "McBSP",
>                                   (void *) (&mcbsp[id]));
>                 if (err !=3D 0) {

Let's consider this once there's something else actually something using
the interrupt.

Tony
