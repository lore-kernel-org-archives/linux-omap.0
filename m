From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [alsa-devel] [RFC PATCH 5/5] ASoC: omap-mcbsp: Place correct constraints for streams
Date: Tue, 1 Jun 2010 14:34:51 +0300
Message-ID: <201006011434.51789.peter.ujfalusi@nokia.com>
References: <1275293810-31984-1-git-send-email-peter.ujfalusi@nokia.com> <201006011330.11044.peter.ujfalusi@nokia.com> <20100601142047.c6a549a8.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:17514 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752915Ab0FALfR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Jun 2010 07:35:17 -0400
In-Reply-To: <20100601142047.c6a549a8.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Jarkko Nikula <jhnikula@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, Girdwood <lrg@slimlogic.co.uk>

On Tuesday 01 June 2010 14:20:47 ext Jarkko Nikula wrote:
> On Tue, 1 Jun 2010 13:30:10 +0300
>=20
> Peter Ujfalusi <peter.ujfalusi@nokia.com> wrote:
> > Because, if you want to transfer in one SDMA burst more than the sp=
ace
> > free in the McBSP FIFO, than where would the rest go?
>=20
> I would have expected peripheral to deassert the DMA request but I
> haven't read the TRM so detail and experimenting with bigger period
> sizes didn't work so some /dev/null effect was obviously happening :-=
)

And for exchange I have tried the following:
in element mode (DMA is set to transfer 1 word on DMA request).
I have configured the McBSP threshold to max - 4 words.
It does not work either. Playback did not start.
I think McBSP is waiting to receive max - 4 samples, while only one wor=
d arrived
Or something, don't know...

>=20
> > I guess it could be better than having 128 word long periods on McB=
SP1,
> > 3, 4, and 5. With small period size the applications also need to b=
e
> > woken up, but if we silently handling the DMA IRQs, and the applica=
tion
> > is only woken up by every 10. DMA IRQ, it might still save some pow=
er?
>=20
> This is worth to experiment. Probably more interrupts with or without
> application wakeup reduction does not increase power as much as the
> savings are from core clocks being more idle.

Although application can also configure the avail_min, so it will be no=
t woken=20
up for every period....

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
