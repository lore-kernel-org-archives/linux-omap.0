From: "Koyamangalath, Abhilash" <abhilash.kv@ti.com>
Subject: RE: [QUERY] [AUDIO][OMAP3 EVM] arecord not working on OMAP3 EVM
Date: Fri, 21 Jan 2011 19:30:38 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC356087035F9B2821@dbde02.ent.ti.com>
References: <FCCFB4CDC6E5564B9182F639FC356087035F9B2239@dbde02.ent.ti.com>
 <4D393C42.1070503@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45010 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752053Ab1AUOAo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Jan 2011 09:00:44 -0500
In-Reply-To: <4D393C42.1070503@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "alsa-devel@vger.kernel.org" <alsa-devel@vger.kernel.org>

Thanks Peter,=20
Your comment helped.

> -----Original Message-----
> From: Peter Ujfalusi [mailto:peter.ujfalusi@nokia.com]
> Sent: Friday, January 21, 2011 1:27 PM
> To: Koyamangalath, Abhilash
> Cc: linux-omap@vger.kernel.org; alsa-devel@vger.kernel.org
> Subject: Re: [QUERY] [AUDIO][OMAP3 EVM] arecord not working on OMAP3 =
EVM
>=20
> On 01/20/11 17:26, ext Koyamangalath, Abhilash wrote:
> > Hi all
> > While testing audio capture (using arecord e,g.),I'm getting only n=
oise
> in the (zeroed out) output buffers on the OMAP3 EVM.
> > I have enabled AUXL and AUXR mic inputs through alsamixer, which
> according to the schematics are connected to the "Audio In"
> > connector on the board, even though the TWL4030 reg list does not a=
llow
> me any ways ( or so I think) to specify mic-bias for
> > these aux inputs.
>=20
> Well, it is auxiliary input (line in). You do not need bias for it.
> I do not have access to OMAP3 EVM documentation, but Beagle also have
> AUXL/R as input.
> I guess you need to use correct cable, and correct source for the inp=
ut
> (stereo jack I suppose).
No need of bias precludes using a MIC, so I tried by connecting a Line-=
in/out audio cable (a cable with a 3.5 mm audio jack on each end) fed f=
rom the PC and it worked, thanks. Originally, I had connected a head-ph=
one mic directly to the audio-in port, which it seems, rather expects a=
 dc-biased and/or a pre-amplified signal.

>=20
> > With AUXL and AUXR muted - I get only silence, which seems to make
> sense.
> > Is there any basic startup setting I'm missing, maybe specific to O=
MAP3
> EVM?
>=20
> Beagle?
>=20
> > Has anyone seen anything like this before, and could provide pointe=
rs?
>=20
> My bet goes for the wrong cable/accessory pair.
Bang On.
>=20
> --
> P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
