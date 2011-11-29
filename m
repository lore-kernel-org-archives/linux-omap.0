From: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: Re: [PATCH v2 1/2] OMAP2+: DMA: Workaround for invalid source position
Date: Tue, 29 Nov 2011 15:01:57 +0200
Message-ID: <1857964.6c1BL8cmCX@barack>
References: <1320658387-21067-1-git-send-email-peter.ujfalusi@ti.com> <4EBBC79E.30701@bitmer.com> <4EBBCB4C.9030202@bitmer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:38171 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753479Ab1K2NBu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 29 Nov 2011 08:01:50 -0500
Received: by ggnp4 with SMTP id p4so7855851ggn.31
        for <linux-omap@vger.kernel.org>; Tue, 29 Nov 2011 05:01:47 -0800 (PST)
In-Reply-To: <4EBBCB4C.9030202@bitmer.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thursday 10 November 2011 15:02:04 Jarkko Nikula wrote:
> On 11/10/2011 02:46 PM, Jarkko Nikula wrote:
> > On 11/07/2011 11:33 AM, Peter Ujfalusi wrote:
> >> If the DMA source position has been asked before the
> >> first actual data transfer has been done, the CSAC
> >> register does not contain valid information.
> >> We can identify this situation by checking the CDAC
> >> register:
> >> CDAC !=3D 0 indicates that the DMA transfer on the channel has
> >> been started already.
> >> When CDAC =3D=3D 0 we can not trust the CSAC value since it has
> >> not been updated, and can contain random number.
> >> Return the start address in case the DMA has not jet started.
> >>=20
> >> Note: The CDAC register has been initialized to 0 at dma_start
> >> time.
> >>=20
> >> Signed-off-by: Peter Ujfalusi<peter.ujfalusi@ti.com>
> >> ---
> >> arch/arm/plat-omap/dma.c | 12 ++++++++++++
> >> 1 files changed, 12 insertions(+), 0 deletions(-)
> >>=20
> >> diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
> >> index c22217c..a9983b6 100644
> >> --- a/arch/arm/plat-omap/dma.c
> >> +++ b/arch/arm/plat-omap/dma.c
> >> @@ -1034,6 +1034,18 @@ dma_addr_t omap_get_dma_src_pos(int lch)
> >> if (IS_DMA_ERRATA(DMA_ERRATA_3_3)&& offset =3D=3D 0)
> >> offset =3D p->dma_read(CSAC, lch);
> >>=20
> >> + if (!cpu_is_omap15xx()) {
> >> + /*
> >> + * CDAC =3D=3D 0 indicates that the DMA transfer on the channel h=
as
> >> + * not been started (no data has been transferred so far).
> >> + * Return the programmed source start address in this case.
> >> + */
> >> + if (likely(p->dma_read(CDAC, lch)))
> >> + offset =3D p->dma_read(CSAC, lch);
> >> + else
> >> + offset =3D p->dma_read(CSSA, lch);
> >> + }
> >> +
> >=20
> > I think this is enough:
> >=20
> > if (unlikely(p->dma_read(CDAC, lch) =3D=3D 0))
> > offset =3D p->dma_read(CSSA, lch);
> >=20
> > I suppose offset is ok for normal case as it is already read (twise=
)
> > above.
> Or actually my proposal could have a race if CDAC changes between CSA=
C
> read and CDAC read. In that case it's better to re-read CSAC as your
> patch does after CDAC test and give to both:
>=20
> Reviewed-by: Jarkko Nikula <jarkko.nikula@bitmer.com>

Tony, have you taken this patch? I failed to find it in the l-o tree...

--
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
