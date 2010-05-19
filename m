From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: Re: [PATCH 0/4] McBSP smart idle and DMA op mode updates for ASoC
Date: Wed, 19 May 2010 13:52:27 +0300
Message-ID: <20100519105227.GL4265@besouro.research.nokia.com>
References: <1274213594-26554-1-git-send-email-lrg@slimlogic.co.uk>
 <20100519081325.6e341075.jhnikula@gmail.com>
 <201005191131.58167.peter.ujfalusi@nokia.com>
Reply-To: eduardo.valentin@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:59472 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752457Ab0ESKq7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 May 2010 06:46:59 -0400
Content-Disposition: inline
In-Reply-To: <201005191131.58167.peter.ujfalusi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>
Cc: ext Jarkko Nikula <jhnikula@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tony Lindgren <tony@atomide.com>

On Wed, May 19, 2010 at 10:31:57AM +0200, Ujfalusi Peter (Nokia-D/Tampe=
re) wrote:
> On Wednesday 19 May 2010 08:13:25 ext Jarkko Nikula wrote:
> > On Tue, 18 May 2010 21:13:10 +0100
> >=20
> > Liam Girdwood <lrg@slimlogic.co.uk> wrote:
> > > I've also added a patch to remove the mcbsp DMA op mode sysfs set
> > > functionality. I think DMA op mode is very specific to the mcbsp =
client
> > > driver _only_ and shouldn't really be changed by userspace. Pleas=
e let
> > > me know if you use this feature and I'll drop this patch.
> >=20
> > I've used to say that the DMA op mode is more like use-case not mac=
hine
> > specific but I'm not sure is my point valid onemore. I've used to t=
hink
> > that low-latency processing would need accurate DMA pointer (op
> > mode =3D=3D element) while mp3 playback would need low power consum=
ption
> > (op mode =3D=3D threshold).
>=20
> Yeah, it used to be so clear ;)
> I see these:
> element mode: if user want to have constant latency [1]
> threshold mode: variable latency, but possibility to save power [2]
>=20
> [1] The McBSP is kept full during playback (and empty during capture)
> The DMA pointer moves word-by-word
>=20
> [2] The McBSP FIFO fill rate changes (full, drain, refill, full, drai=
n...)
> The DMA pointer moves in bursts.
> Between burst memories can relax, core, MPU also in theory.
> Smart idle helps to conserve more power here
>=20
> > Peter: what's the status today how well can we do low-latency
> > processing with threshold mode? IRCC, with your FIFO delay query
> > patches, can we estimate the DMA pointer position with enough accur=
acy?
>=20
> The DMA pointer is easy, and it was know before as well, but accordin=
g to my=20
> tests, the McBSP FIFO caused delay reporting is fairly accurate.
> I'll ask my users, if they have done some additional tests.

OK. fair enough. What if you really want to avoid the delay at all?

>=20
> --=20
> P=E9ter
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
