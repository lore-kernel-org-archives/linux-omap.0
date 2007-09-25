From: "=?ISO-8859-1?Q?Lu=EDs_Cargnini?=" <lvcargnini@gmail.com>
Subject: Re: McBSP
Date: Mon, 24 Sep 2007 23:06:11 -0300
Message-ID: <ae36f8040709241906p626273b0r221b0bc394925143@mail.gmail.com>
References: <ae36f8040709190556n24a04e87vc1ec1a0f094b8b51@mail.gmail.com>
	<9C23CDD79DA20A479D4615857B2E2C4701D27E29@dlee13.ent.ti.com>
Reply-To: lvcargnini@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <9C23CDD79DA20A479D4615857B2E2C4701D27E29@dlee13.ent.ti.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Cc: dspgateway-devel@lists.sourceforge.net, OMAP <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

the "IRQF_NODELAY" are inside interrupt.h I thinking in set the irq flags a=
s

IRQF_PROBE|IRQF_SHARED

to probe if irq line is active high or down

On 9/22/07, Syed Mohammed, Khasim <x0khasim@ti.com> wrote:
>
> >Dear fellows,
> >Please i want to change mcbsp.c, in omap_mcbsp_request() change the
> >functions of irq from:
> >
> >err =3D request_irq(mcbsp[id].tx_irq, omap_mcbsp_tx_irq_handler, 0,
> >                  "McBSP",
> >                  (void *) (&mcbsp[id]));
> >
> >to:
> >err =3D request_irq(mcbsp[id].tx_irq,
> >omap_mcbsp_tx_irq_handler,IRQF_NODELAY|IRQF_SHARED,
> >                  "McBSP",
> >                  (void *) (&mcbsp[id]));
> >
>
> I don't see "IRQF_NODELAY" in include/linux/interrupt.h, how did you get
> this one?
>
> I think shared "IRQF_SHARED" is fine.
>
> >and the same for rx_irq, then my device driver for example, could attach
> an
> >irq_handler for my mcbsp2, where I plugin and ADC.
> >I need to plug an ADC, in McBSP 2 and read and write it, using McBSP TI
> >protocol to communicate with a McBSP.
> >Can I made this modification inside arch/arm/plat-omap/mcbsp.c ?
> >I'm running a kernel with this modification and are testing the device
> >driver, could this modification been permanent in main tree ?
> >Or there is any problem ?
> >
> You should submit a patch to Tony, if it meets patch standards, then it
> will get into to OMAP GIT tree.
>
> Regards,
> Khasim
>
>


--=20
---------------------------------------------------------------------------=
---
Thanks && Regards
Msc. Bsc. Lu=EDs Vit=F3rio Cargnini
IEEE Member
Electrical Engineer Faculty @ PUCRS
Ipiranga Avenue, 6681 =96 Building 30
P.O. Box: 90619-900 =96 Porto Alegre/RS
Phone: +55 51 3320 3500  extension: 7696
---------------------------------------------------------------------------=
------
