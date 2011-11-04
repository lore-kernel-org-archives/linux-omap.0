From: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: Re: [PATCH 1/2] OMAP2+: DMA: Workaround for invalid source position
Date: Fri, 04 Nov 2011 11:35:26 +0200
Message-ID: <2603119.amz7RjSE3J@barack>
References: <1320070817-9638-1-git-send-email-peter.ujfalusi@ti.com> <1320070817-9638-2-git-send-email-peter.ujfalusi@ti.com> <20111103212756.GZ31337@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:60397 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751371Ab1KDJfb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 4 Nov 2011 05:35:31 -0400
Received: by mail-fx0-f54.google.com with SMTP id r19so3610823faa.13
        for <linux-omap@vger.kernel.org>; Fri, 04 Nov 2011 02:35:30 -0700 (PDT)
In-Reply-To: <20111103212756.GZ31337@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>, linux-omap@vger.kernel.org

On Thursday 03 November 2011 14:27:56 Tony Lindgren wrote:
> * Peter Ujfalusi <peter.ujfalusi@ti.com> [111031 06:46]:
> > If the DMA source position has been asked before the
> > first actual data transfer has been done, the CSAC
> > register does not contain valid information.
> > We can identify this situation by checking the CDAC
> > register:
> > CDAC !=3D 0 indicates that the DMA transfer on the channel has
> > been started already.
> > When CDAC =3D=3D 0 we can not trust the CSAC value since it has
> > not been updated, and can contain random number.
> > Return the start address in case the DMA has not jet started.
> >=20
> > Note: The CDAC register has been initialized to 0 at dma_start
> > time.
> >=20
> > Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> > ---
> >=20
> >  arch/arm/plat-omap/dma.c |   15 +++++++++++++--
> >  1 files changed, 13 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
> > index c22217c..38b0d44 100644
> > --- a/arch/arm/plat-omap/dma.c
> > +++ b/arch/arm/plat-omap/dma.c
> > @@ -1024,12 +1024,23 @@ EXPORT_SYMBOL(omap_set_dma_callback);
> >=20
> >   */
> > =20
> >  dma_addr_t omap_get_dma_src_pos(int lch)
> >  {
> >=20
> > +	u32 cdac;
> >=20
> >  	dma_addr_t offset =3D 0;
> >  =09
> >  	if (cpu_is_omap15xx())
> >  =09
> >  		offset =3D p->dma_read(CPC, lch);
> >=20
> > -	else
> > -		offset =3D p->dma_read(CSAC, lch);
> > +	else {
> > +		/*
> > +		 * CDAC =3D=3D 0 indicates that the DMA transfer on the channel =
has
> > +		 * not been started (no data has been transferred so far).
> > +		 * Return the programmed source start address in this case.
> > +		 */
> > +		cdac =3D p->dma_read(CDAC, lch);
> > +		if (likely(cdac))
> > +			offset =3D p->dma_read(CSAC, lch);
> > +		else
> > +			offset =3D p->dma_read(CSSA, lch);
> > +	}
> >=20
> >  	if (IS_DMA_ERRATA(DMA_ERRATA_3_3) && offset =3D=3D 0)
> >  =09
> >  		offset =3D p->dma_read(CSAC, lch);
>=20
> Should these tests be done only after the errata re-read for both
> src and dst patches? Otherwise the errata will not be handled?

Yes that might be a good idea.
I was trying to locate the original errata description for DMA_ERRATA_3=
_3, but=20
it does not exist, or at least I can not find it. This only been mentio=
ned in=20
the kernel's comment.
I'm not sure when this DMA_ERRATA_3_3 would have been in force. My gues=
s would=20
be that if someone wants to read the src/dst position right after the c=
hannel=20
is disabled, but what would we expect it to return when the channel has=
 been=20
disabled?
I mean what is the reasonable src/dst for a disabled channel? 0 is as g=
ood as=20
any other number, probably the programmed start of the DMA transfer wou=
ld be=20
my best bet.
I think the errata description for DMA_ERRATA_3_3 is not correct, and i=
t is in=20
fact to handle the case I'm also handling: Before the first DMA request=
 the=20
CDAC is 0 (since we configured it to be), the CSAC contains _something_=
 (most=20
of the time 0, but can be random number).
In some situation re-reading the src/dst position will give enough time=
 to=20
receive the first DMA request, which will update CDAC/CSAC registers.

What do you think?

--
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
