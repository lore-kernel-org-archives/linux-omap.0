From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [RESEND PATCH v3 03/11] ASoC: davinci-mcasp: Add DMA register
 locations to DT
Date: Thu, 10 Oct 2013 20:29:59 +0300
Message-ID: <5256E417.7010403@ti.com>
References: <cover.1379590035.git.jsarha@ti.com> <66bdda0c0b75d737d649260b9ec10f9f870c20cd.1379590036.git.jsarha@ti.com> <20131007214718.GA2976@kartoffel> <20131008004641.GV21581@sirena.org.uk> <20131010165959.GB3910@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39485 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755433Ab3JJRaR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Oct 2013 13:30:17 -0400
In-Reply-To: <20131010165959.GB3910@e106331-lin.cambridge.arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@kernel.org>
Cc: "jsarha@ti.com" <jsarha@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, "bcousson@baylibre.com" <bcousson@baylibre.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "joelf@ti.com" <joelf@ti.com>, "Hebbar, Gururaja" <gururaja.hebbar@ti.com>, Darren Etheridge <detheridge@ti.com>

On 10/10/2013 07:59 PM, Mark Rutland wrote:
>> No, they're not actually of much practical use to us at the minute b=
ut
>> it was generally felt better to include the information and not use =
it
>> so that if someone does come up with a use for them then the trees f=
or
>> deployed systems already have the information.
>=20
> Sure, but if this device can generate multiple interrupts, we should
> make it possible to describe all of them, unambiguously.

This is why Jyri added them to the DT. They are not used by the Linux d=
river,
but the HW have interrupt lines (two of them: TX and RX).

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
