From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH 1/4] OMAP: DMA: Cleanup of DMA Request Lines
Date: Wed, 21 Nov 2007 10:42:18 +0530
Message-ID: <010C7BAE6783F34D9AC336EE5A01A08804DC0E4B@dbde01.ent.ti.com>
References: <20071031131059.GG32547@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <20071031131059.GG32547@atomide.com>
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
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,=20

> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com]=20
> Sent: Wednesday, October 31, 2007 6:41 PM

> > +#ifndef CONFIG_ARCH_OMAP3
> >  #define OMAP24XX_DMA_CWT		8	/* S_DMA_7 */
> > +#endif
> > +
> >  #define OMAP24XX_DMA_AES_TX		9	/* S_DMA_8 */
> >  #define OMAP24XX_DMA_AES_RX		10	/* S_DMA_9 */
> >  #define OMAP24XX_DMA_DES_TX		11	/* S_DMA_10 */
> >  #define OMAP24XX_DMA_DES_RX		12	/* S_DMA_11 */
> > +
> > +#ifdef CONFIG_ARCH_OMAP3
> > +#define OMAP34XX_DMA_SHA2MD5_RX		13	/* S_DMA_12 */
> > +#else
> >  #define OMAP24XX_DMA_SHA1MD5_RX		13	/* S_DMA_12 */
> > +#endif
> > +
> > +#ifdef CONFIG_ARCH_OMAP2420
> >  #define OMAP24XX_DMA_EXT_DMAREQ2	14	/* S_DMA_13 */
> >  #define OMAP24XX_DMA_EXT_DMAREQ3	15	/* S_DMA_14 */
> >  #define OMAP24XX_DMA_EXT_DMAREQ4	16	/* S_DMA_15 */
>=20
> Let's remove the #ifdefs here, we want to be able to compile=20
> support for
> 24xx and 34xx into the same kernel eventually. It's OK to=20
> have the same
> DMA request channel defined in different way for 24xx and 34xx.

I've just started re-working this patch. Let me check if I have =
understood
you correctly. Do you want me to remove only the #ifdefs around the
OMAP34XX_DMA_SHA2MD5_RX/OMAP24XX_DMA_SHA1MD5_RX?

If this is the case, then wouldn't we run into trouble when we try to =
use a
request line with the same name but a different number - as is the case =
with
OMAP24XX_DMA_SHA1MD5_RX (13 on 24XX and 69 on 34XX)

Also when you say "we want to be able to compile support for 24xx and =
34xx into
the same kernel...", do you mean there will be a CONFIG_ARCH_OMAP2 as =
well as a
CONFIG_ARCH_OMAP3 defined at the same time?

--
Anand
