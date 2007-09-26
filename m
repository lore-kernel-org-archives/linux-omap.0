From: "=?ISO-8859-1?Q?Lu=EDs_Cargnini?=" <lvcargnini@gmail.com>
Subject: [PATCH 00/01] include/asm-arm/arch-omap/mcbsp.h
Date: Wed, 26 Sep 2007 00:18:59 -0300
Message-ID: <ae36f8040709252018h58fd7078p5d44246da2ec1b@mail.gmail.com>
Reply-To: lvcargnini@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: OMAP <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

this patch add the function prototype of set I/O to the header file os it
could be used outside since it is exported, but not defined in the header
previously

--- linux-omap-2.6/include/asm-arm/arch-omap/mcbsp.h    2007-06-22 02:43:
08.127752533 -0300
+++ linux-omap-2.6-instramed/include/asm-arm/arch-omap/mcbsp.h  2007-09-19
10:54:11.584496814 -0300
@@ -83,7 +83,7 @@
 #define AUDIO_DMA_TX           OMAP_DMA_MCBSP1_TX
 #define AUDIO_DMA_RX           OMAP_DMA_MCBSP1_RX

  #define OMAP_MCBSP_REG_DRR2    0x00
 #define OMAP_MCBSP_REG_DRR1    0x04
@@ -318,5 +318,6 @@ void omap_mcbsp_set_spi_mode(unsigned in
 /* Polled read/write functions */
 int omap_mcbsp_pollread(unsigned int id, u16 * buf);
 int omap_mcbsp_pollwrite(unsigned int id, u16 buf);
-
+int omap_mcbsp_set_io_type(unsigned int id, omap_mcbsp_io_type_t io_type);
 #endif


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
