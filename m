From: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: Re: [PATCH v6 08/18] mfd: twl6040: Add initial support
Date: Mon, 4 Jul 2011 16:09:30 +0300
Message-ID: <4014234.U3Af1Vqyz9@barack>
References: <1308663556-29120-1-git-send-email-peter.ujfalusi@ti.com> <1308663556-29120-9-git-send-email-peter.ujfalusi@ti.com> <20110704125330.GI2820@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <20110704125330.GI2820@legolas.emea.dhcp.ti.com>
Sender: linux-input-owner@vger.kernel.org
To: "Balbi, Felipe" <balbi@ti.com>
Cc: "Girdwood, Liam" <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Samuel Ortiz <sameo@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Lopez Cruz, Misael" <misael.lopez@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Felipe, Samuel,

On Monday 04 July 2011 14:53:30 Balbi, Felipe wrote:
> > +		ret =3D twl6040_request_irq(twl6040, TWL6040_IRQ_READY,
> > +					  twl6040_naudint_handler, 0,
> > +					  "twl6040_irq_ready", twl6040);
>=20
> why don't you use the normal request_threaded_irq() ?? This is a bit =
of
> obfuscation IMO.

I have left this 'macro' in since it is also used within the twl6040-vi=
bra,=20
and twl6040 ASoC codec driver to request the irq for them.
But if you think it is better to replace the twl6040_request_irq with d=
irect=20
request_threaded_irq in those drivers as well, I'll do that.

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
