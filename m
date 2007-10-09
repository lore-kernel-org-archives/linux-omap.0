From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 00/01] include/asm-arm/arch-omap/mcbsp.h
Date: Tue, 9 Oct 2007 15:11:41 -0700
Message-ID: <20071009221140.GC4151@atomide.com>
References: <ae36f8040709252018h58fd7078p5d44246da2ec1b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <ae36f8040709252018h58fd7078p5d44246da2ec1b@mail.gmail.com>
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

Hi,

* Lu=EDs Cargnini <lvcargnini@gmail.com> [070925 20:19]:
> this patch add the function prototype of set I/O to the header file os =
it
> could be used outside since it is exported, but not defined in the head=
er
> previously
>=20
> --- linux-omap-2.6/include/asm-arm/arch-omap/mcbsp.h    2007-06-22 02:4=
3:
> 08.127752533 -0300
> +++ linux-omap-2.6-instramed/include/asm-arm/arch-omap/mcbsp.h  2007-09=
-19
> 10:54:11.584496814 -0300
> @@ -83,7 +83,7 @@
>  #define AUDIO_DMA_TX           OMAP_DMA_MCBSP1_TX
>  #define AUDIO_DMA_RX           OMAP_DMA_MCBSP1_RX
>=20
>   #define OMAP_MCBSP_REG_DRR2    0x00
>  #define OMAP_MCBSP_REG_DRR1    0x04
> @@ -318,5 +318,6 @@ void omap_mcbsp_set_spi_mode(unsigned in
>  /* Polled read/write functions */
>  int omap_mcbsp_pollread(unsigned int id, u16 * buf);
>  int omap_mcbsp_pollwrite(unsigned int id, u16 buf);
> -
> +int omap_mcbsp_set_io_type(unsigned int id, omap_mcbsp_io_type_t io_ty=
pe);
>  #endif

Can you please respond with your Signed-off-by so I can apply this?

Tony
