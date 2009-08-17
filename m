From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH 3/3 v3] ASoC: OMAP: Enhance OMAP1510 DMA progress
 software counter
Date: Mon, 17 Aug 2009 12:26:05 +0300
Message-ID: <20090817122605.0b240ea7.jhnikula@gmail.com>
References: <200908101050.08074.jkrzyszt@tis.icnet.pl>
	<200908110107.11485.jkrzyszt@tis.icnet.pl>
	<200908112144.30731.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f214.google.com ([209.85.219.214]:56222 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932165AbZHQJYe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Aug 2009 05:24:34 -0400
In-Reply-To: <200908112144.30731.jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Tony Lindgren <tony@atomide.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Tue, 11 Aug 2009 21:44:29 +0200
Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> wrote:

> Enhance period_index accuracy, particularly just before buffer rewind=
, by
> making use of DMA interrupt status flags in addition to simply counti=
ng up
> interrupts.
>=20
> Changes since v2:
> > > > -=A0=A0=A0}
> > > > +=A0=A0=A0} else if (stat =3D=3D OMAP_DMA_LAST_IRQ)
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return;
> > >
> > > Is this test needed? This interrupt is set only for playback on
> > > omap1510 so this looks null-op.
> >
> > You're right, I have put it here before limiting the flag request t=
o
> > playback on OMAP1510 only. So it can be omitted...
>=20
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0omap_enable_dma_irq(prtd->dma=
_ch, OMAP_DMA_FRAME_IRQ |
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0OMAP_DMA_LAST_IRQ);
> > >
> > > Indent OMAP_DMA_LAST_IRQ with tab(s) and spaces to the same colum=
n
> > > than OMAP_DMA_FRAME_IRQ. Looks nicer then.
> >
> > OK, will fix it.
> >
> > > Should the
> > > OMAP_DMA_BLOCK_IRQ to be set since it is handled in omap_pcm_dma_=
irq?
> >
> > This one is already requested from inside omap_request_dma() and us=
ed
> > inside omap1_dma_handle_ch() in addition to passing it to us.
> But for less confusion, it'll be better if requested from here too.
>=20
I'm fine with this 3rd version. Probably Mark would like to have git
format-patch formatted version for avoiding manual commit log editing.

Acked-by: Jarkko Nikula <jhnikula@gmail.com>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
