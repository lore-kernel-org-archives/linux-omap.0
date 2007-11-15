From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH]include/asm-arm/arch-omap/omap24xx.h
Date: Thu, 15 Nov 2007 13:24:50 -0800
Message-ID: <20071115212449.GM20686@atomide.com>
References: <ae36f8040711062027k1456f262kfa9d72543d38b0cc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <ae36f8040711062027k1456f262kfa9d72543d38b0cc@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: =?iso-8859-1?Q?Lu=EDs?= Cargnini <lvcargnini@gmail.com>
Cc: OMAP <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

* Lu=EDs Cargnini <lvcargnini@gmail.com> [071106 20:27]:
> this patch only export two more functions to been used externally, for =
read
> and write in polled mode.without the need of irqs.
>=20
> Signed-off-by: Luis Vitorio Cargnini <lvcargnini@gmail.com>
>=20
> --- linux-omap-2.6/arch/arm/plat-omap/mcbsp.c   2007-03-12 16:44:
> 03.501890844 -0300
> +++ linux-omap-2.6.23/arch/arm/plat-omap/mcbsp.c        2007-11-07 02:1=
0:
> 44.093625034 -0200
> @@ -1022,6 +1022,8 @@ EXPORT_SYMBOL(omap_mcbsp_set_io_type);
>  EXPORT_SYMBOL(omap_mcbsp_free);
>  EXPORT_SYMBOL(omap_mcbsp_start);
>  EXPORT_SYMBOL(omap_mcbsp_stop);
> +EXPORT_SYMBOL(omap_mcbsp_pollread);
> +EXPORT_SYMBOL(omap_mcbsp_pollwrite);
>  EXPORT_SYMBOL(omap_mcbsp_xmit_word);
>  EXPORT_SYMBOL(omap_mcbsp_recv_word);
>  EXPORT_SYMBOL(omap_mcbsp_xmit_buffer);

Pushing today. Can you please check your mailer settings? The patch is
wrapped and base64 encoded...

Tony
