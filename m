From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: RE: McBSP
Date: Sat, 22 Sep 2007 05:49:22 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C4701D27E29@dlee13.ent.ti.com>
References: <ae36f8040709190556n24a04e87vc1ec1a0f094b8b51@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <ae36f8040709190556n24a04e87vc1ec1a0f094b8b51@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: lvcargnini@gmail.com, OMAP <Linux-omap-open-source@linux.omap.com>
Cc: dspgateway-devel@lists.sourceforge.net
List-Id: linux-omap@vger.kernel.org

>Dear fellows,
>Please i want to change mcbsp.c, in omap_mcbsp_request() change the
>functions of irq from:
>
>err =3D request_irq(mcbsp[id].tx_irq, omap_mcbsp_tx_irq_handler, 0,
>                  "McBSP",
>                  (void *) (&mcbsp[id]));
>
>to:
>err =3D request_irq(mcbsp[id].tx_irq,
>omap_mcbsp_tx_irq_handler,IRQF_NODELAY|IRQF_SHARED,
>                  "McBSP",
>                  (void *) (&mcbsp[id]));
>

I don't see "IRQF_NODELAY" in include/linux/interrupt.h, how did you get =
this one?

I think shared "IRQF_SHARED" is fine.=20

>and the same for rx_irq, then my device driver for example, could =
attach an
>irq_handler for my mcbsp2, where I plugin and ADC.
>I need to plug an ADC, in McBSP 2 and read and write it, using McBSP TI
>protocol to communicate with a McBSP.
>Can I made this modification inside arch/arm/plat-omap/mcbsp.c ?
>I'm running a kernel with this modification and are testing the device
>driver, could this modification been permanent in main tree ?
>Or there is any problem ?
>
You should submit a patch to Tony, if it meets patch standards, then it =
will get into to OMAP GIT tree.

Regards,
Khasim
