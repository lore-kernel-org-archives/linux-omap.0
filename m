From: "=?ISO-8859-1?Q?Lu=EDs_Cargnini?=" <lvcargnini@gmail.com>
Subject: Re: [PATCH 00/01] include/asm-arm/arch-omap/mcbsp.h
Date: Tue, 9 Oct 2007 21:44:42 -0300
Message-ID: <ae36f8040710091744l55a108a0xfc340aabf962c164@mail.gmail.com>
References: <ae36f8040709252018h58fd7078p5d44246da2ec1b@mail.gmail.com>
	<20071009221140.GC4151@atomide.com>
Reply-To: lvcargnini@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20071009221140.GC4151@atomide.com>
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
To: Tony Lindgren <tony@atomide.com>
Cc: OMAP <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

yep 8-)


On 10/9/07, Tony Lindgren <tony@atomide.com> wrote:
>
> Hi,
>
> * Lu=EDs Cargnini <lvcargnini@gmail.com> [070925 20:19]:
> > this patch add the function prototype of set I/O to the header file os
> it
> > could be used outside since it is exported, but not defined in the
> header
> > previously
> >
> > --- linux-omap-2.6/include/asm-arm/arch-omap/mcbsp.h    2007-06-22
> 02:43:
> > 08.127752533 -0300
> > +++ linux-omap-2.6-instramed
> /include/asm-arm/arch-omap/mcbsp.h  2007-09-19
> > 10:54:11.584496814 -0300
> > @@ -83,7 +83,7 @@
> >  #define AUDIO_DMA_TX           OMAP_DMA_MCBSP1_TX
> >  #define AUDIO_DMA_RX           OMAP_DMA_MCBSP1_RX
> >
> >   #define OMAP_MCBSP_REG_DRR2    0x00
> >  #define OMAP_MCBSP_REG_DRR1    0x04
> > @@ -318,5 +318,6 @@ void omap_mcbsp_set_spi_mode(unsigned in
> >  /* Polled read/write functions */
> >  int omap_mcbsp_pollread(unsigned int id, u16 * buf);
> >  int omap_mcbsp_pollwrite(unsigned int id, u16 buf);
> > -
> > +int omap_mcbsp_set_io_type(unsigned int id, omap_mcbsp_io_type_t
> io_type);
> >  #endif
>
> Can you please respond with your Signed-off-by so I can apply this?
>
> Tony
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
