From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: Re: [alsa-devel] [PATCH 11/20] OMAP: McBSP: Add link DMA mode
 selection
Date: Fri, 7 Aug 2009 16:11:02 +0300
Message-ID: <20090807131102.GA18380@esdhcp037198.research.nokia.com>
References: <1248958183-15015-1-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-12-git-send-email-eduardo.valentin@nokia.com>
 <20090805103900.5ad89efe.jhnikula@gmail.com>
 <200908051158.57440.peter.ujfalusi@nokia.com>
 <1FFEF31EBAA4F64B80D33027D4297760047F6AED01@NOK-EUMSG-02.mgdnok.nokia.com>
Reply-To: eduardo.valentin@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:34620 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755512AbZHGNXY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Aug 2009 09:23:24 -0400
Content-Disposition: inline
In-Reply-To: <1FFEF31EBAA4F64B80D33027D4297760047F6AED01@NOK-EUMSG-02.mgdnok.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>
Cc: "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "jhnikula@gmail.com" <jhnikula@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "alsa-devel@vger.kernel.org" <alsa-devel@vger.kernel.org>

Hello guys,

On Thu, Aug 06, 2009 at 08:15:40PM +0200, Nurkkala Eero.An (EXT-Offcode=
/Oulu) wrote:
>=20
> >>
> >> I would say the default mode for the omap34xx should be also eleme=
nt as
> >> it keeps the omap_pcm_pointer behavior the same than currently and
> >> avoids possible regression.
> >=20
> > Yes, the default mode should be the element mode in my opinion as w=
ell.
> >=20
> > --
> > P=E9ter
>=20
>=20
> Well, the element mode is fine for !McBSP2. One doesn't really loose =
the
> buffer pointer accuracy, because you can get the last DMA irq timesta=
mp
> with SNDRV_PCM_IOCTL_TTSTAMP (and compare that to current time).
> The accuracy is not far off from the element mode? (If you read the D=
MA
> portion of TRM, I think there were some issues as well)
>=20
> Don't want to be piccy, but McBSP2 with element mode is more or less =
like
> a "joke"? As there's a large HW bugger, why not take advantage of it.=
=2Ewhy=20
> "bypass"  it as default?
>=20
> For !McBSP2, it doesn't even pay to have the threshold mode at all, b=
ecause
> the effect on PM is actually adverse - too frequent wakeups will caus=
e more
> adverse net effect on PM (IIRC) @ VBAT.

I agree with Eero in this point. We can set mcbsp2 default op mode to t=
hreshold.

I think we are even here :) two believe that must be element mode by de=
fault,
while two want default threshold (at least for mcbsp2). We need another=
 opinion.

>=20
> - Eero --
> To unsubscribe from this list: send the line "unsubscribe alsa-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Eduardo Valentin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
