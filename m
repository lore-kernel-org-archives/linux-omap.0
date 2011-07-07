From: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: Re: [PATCH 1/3] ASoC: omap-mcpdm: Replace legacy driver
Date: Thu, 7 Jul 2011 20:19:09 +0300
Message-ID: <1349557.nxjzoW6muP@barack>
References: <1310041672-18634-1-git-send-email-peter.ujfalusi@ti.com> <4E15DFAA.7030508@ti.com> <20110707165329.GG16325@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53218 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755125Ab1GGR3V convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jul 2011 13:29:21 -0400
In-Reply-To: <20110707165329.GG16325@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "Girdwood, Liam" <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Lopez Cruz, Misael" <misael.lopez@ti.com>, "Guiriec, Sebastien" <s-guiriec@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>

On Thursday 07 July 2011 18:53:29 Mark Brown wrote:
> Sounds like runtime PM ought to be able to handle this, though?  If y=
ou
> need to sync with the ABE can the ABE take PM references to the DAIs
> it's talking to?

It is not (just?) the ABE, but rather the twl6040 codec, which needs th=
is=20
deferred stopping of the PDM interface. AFAIK.

> I guess the ABE will be happier if everything it's
> talking to runs for longer than it does.  Or the DAI could switch int=
o
> autosuspend mode when it goes idle to do the delay.

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
