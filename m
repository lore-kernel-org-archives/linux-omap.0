From: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: Re: [PATCH 2/4] Fixes for "input: Add initial support for TWL6040 vibrator"
Date: Tue, 2 Aug 2011 15:37:11 +0300
Message-ID: <2946794.tnTk4EhRvS@barack>
References: <1312284526-1656-1-git-send-email-peter.ujfalusi@ti.com> <1312284526-1656-2-git-send-email-peter.ujfalusi@ti.com> <20110802123308.GF7951@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55890 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754345Ab1HBMhR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Aug 2011 08:37:17 -0400
In-Reply-To: <20110802123308.GF7951@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Balbi, Felipe" <balbi@ti.com>
Cc: "Girdwood, Liam" <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Lopez Cruz, Misael" <misael.lopez@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Guiriec, Sebastien" <s-guiriec@ti.com>

Hi Felipe,

On Tuesday 02 August 2011 14:33:09 Balbi, Felipe wrote:
> Hi,
>=20
> On Tue, Aug 02, 2011 at 02:28:42PM +0300, Peter Ujfalusi wrote:
> > @@ -145,7 +143,7 @@ static int vibra_play(struct input_dev *input, =
void
> > *data,>=20
> >  	ret =3D queue_work(info->workqueue, &info->play_work);
> >  	if (!ret) {
> >=20
> > -		dev_err(&input->dev, "work is already on queue\n");
> > +		dev_info(&input->dev, "work is already on queue\n");
>=20
> why ???

Please do not waste your valuable time on this series.
It was an error in my side to send it (just came back form vacation...)=
=2E
I have somehow ended up in a wrong directory when I typed git send-emai=
l, and=20
sent the wrong set of patches.
Not these, but the fixed/cleaned ones are already merged upstream.

Sorry for the inconvenience I have caused.

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
