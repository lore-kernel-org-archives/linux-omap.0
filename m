From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v3] ARM: dts: am335x-evmsk: enable display and lcd panel
 support
Date: Wed, 2 Jul 2014 14:04:17 +0300
Message-ID: <53B3E731.5030604@ti.com>
References: <1404248420-10086-1-git-send-email-detheridge@ti.com> <20140701210812.GN13396@saruman.home> <20140702074508.GT28884@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="s9RWwpXGIncgVmvBu1elqVuPtjawcTv17"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:32947 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750869AbaGBLEu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Jul 2014 07:04:50 -0400
In-Reply-To: <20140702074508.GT28884@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>
Cc: Darren Etheridge <detheridge@ti.com>, bcousson@baylibre.com, wsa@sang-engineering.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

--s9RWwpXGIncgVmvBu1elqVuPtjawcTv17
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 02/07/14 10:45, Tony Lindgren wrote:
> * Felipe Balbi <balbi@ti.com> [140701 14:10]:
>> Hi,
>>
>> On Tue, Jul 01, 2014 at 04:00:20PM -0500, Darren Etheridge wrote:
>>> Add the necessary nodes to enable the LCD controller and the
>>> LCD panel that is attached to the Texas Instruments AM335x
>>> EVMSK platform.  Also setup the necessary pin mux within the
>>> DT file to drive the LCD connector and add the correct
>>> pinmux settings for the lcd pins to be configured to when
>>> the SoC goes into sleep state for the minimum power
>>> consumption.
>>>
>>> For the sleep mode LCD pin settings, MUX_MODE7 is chosen as
>>> this corresponds to switching the pins into input GPIO's with
>>> an internal pulldown.  Which has been determined to offer the
>>> lowest power solution vs leaving the pins configured in LCD
>>> mode.
>>>
>>> Signed-off-by: Darren Etheridge <detheridge@ti.com>
>>> Acked-by: Wolfram Sang <wsa@sang-engineering.com>
>>
>> Tested-by: Felipe Balbi <balbi@ti.com>
>>
>> serial console capture: http://slexy.org/view/s200thiMb3
>>
>> note that v2 has been pending since May 9th:
>> http://marc.info/?l=3Dlinux-omap&m=3D139966159102339&w=3D2
>>
>>> ---
>>> Tony, Benoit,
>>>
>>> I didn't see this patch get applied anywhere, so I updated it and I a=
m
>>> resending it.  Please let me know if you need any more info before yo=
u will
>>> apply it.
>=20
> Tomi, do you want to ack this one or want to queue the panel .dts
> changes into a separate branch?

I don't really have experience with the LCDC used on AM335x SoC (it
doesn't have DSS), but the patch looks ok, so for what it's worth:

Acked-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

I don't have any .dts changes queued, so I think it's better if you pick
it up.

 Tomi



--s9RWwpXGIncgVmvBu1elqVuPtjawcTv17
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTs+cxAAoJEPo9qoy8lh715t8QAIk0uGDslys1hYSCKryJm9TZ
9a7q795PzcU6puzI/Q+M+BZI1A1+JyDUf/yCfeHzJw0dkFiMMgNJPHGnC/FGXnIr
q2mXToGMnuCujR1dlywMtoblq8yMUIcDXW5qPWe9ggUhPJRtTEZo7vcg8gygqNlV
gSZvUT54Q8R+0VafHgu6CJ706JLkvzZX3kmCK6tLt6RuBxaweoHniTo6Oh+QdN5V
8wc5DHVQctbEVxofjSDLa9UndOvvHnpKnfVsIMmgBwPcSBa7lxMdSY9HePR8B9xy
LxakHY84bl4gjGorfv6XTZL8G3QleKJKWGa0Z1Gh87GhI6RWXFE9zPyUQwvD7eGO
y2lvG7wh+cOrEN4R1x8QX4AsJF08MrvCZ6AS7iBOvYK0fnkPjVuL3nt0TFvMYv3W
/SRht8gQP5DpzmLUV2jFC3+w4ct9T2qVVFVaKjwZ8U/JnEKdRYIb1logyi2s/Rlg
lTbnxrkYUohhWge7g3IaQpFxeafO2pAqGWLMG7l+5PLsK6E6v40d6H9QfzhxyQ/E
rxhiu02SteTn4P0nsoZXo1bzNcj9HBqfQ4RR6GsLH1sHuZxV6YPsuc4A/YNk/R1K
WYL/QIS038Sc3reNIzLRpY5bbgyEvmdHTnuLCKfhHcg5PEZ0Y6yNPZrClW32wDMQ
2PIP/xXTjRDJpHZq4jPX
=ORpa
-----END PGP SIGNATURE-----

--s9RWwpXGIncgVmvBu1elqVuPtjawcTv17--
