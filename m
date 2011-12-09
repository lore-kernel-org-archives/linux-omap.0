From: Tony Lindgren <tony@atomide.com>
Subject: Re: Re: [PATCH v2 1/2] OMAP2+: DMA: Workaround for invalid source
 position
Date: Thu, 8 Dec 2011 16:42:01 -0800
Message-ID: <20111209004201.GI31337@atomide.com>
References: <1320658387-21067-1-git-send-email-peter.ujfalusi@ti.com>
 <4EBBC79E.30701@bitmer.com>
 <4EBBCB4C.9030202@bitmer.com>
 <1857964.6c1BL8cmCX@barack>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:49352 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751094Ab1LIAmH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Dec 2011 19:42:07 -0500
Content-Disposition: inline
In-Reply-To: <1857964.6c1BL8cmCX@barack>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?utf-8?B?UMOpdGVy?= Ujfalusi <peter.ujfalusi@ti.com>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* P=C3=A9ter Ujfalusi <peter.ujfalusi@ti.com> [111129 04:26]:
> On Thursday 10 November 2011 15:02:04 Jarkko Nikula wrote:
> > On 11/10/2011 02:46 PM, Jarkko Nikula wrote:
> > > On 11/07/2011 11:33 AM, Peter Ujfalusi wrote:
> > >=20
> > > I think this is enough:
> > >=20
> > > if (unlikely(p->dma_read(CDAC, lch) =3D=3D 0))
> > > offset =3D p->dma_read(CSSA, lch);
> > >=20
> > > I suppose offset is ok for normal case as it is already read (twi=
se)
> > > above.
> > Or actually my proposal could have a race if CDAC changes between C=
SAC
> > read and CDAC read. In that case it's better to re-read CSAC as you=
r
> > patch does after CDAC test and give to both:
> >=20
> > Reviewed-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
>=20
> Tony, have you taken this patch? I failed to find it in the l-o tree.=
=2E.

Sorry for the delay, applying both into fixes-non-critical.

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
