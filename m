From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAP: Beagle: fix TFP410 powerdown GPIO init
Date: Thu, 14 Jun 2012 11:13:33 +0300
Message-ID: <1339661613.2229.6.camel@deskari>
References: <1339579215-24098-1-git-send-email-tomi.valkeinen@ti.com>
	 <CA+Bv8XZHOhD1sdJvEzwwup+igWpkCf8twxWzrf2zhSd4_aj9MQ@mail.gmail.com>
	 <1339658290.2236.5.camel@deskari>
	 <CA+Bv8XbwWbdTFFo9KHoOk7Tq8XBWDOWhkEqq7Pz6by_8sE_ngA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-pZYlDaMn+aQTMEq3D4nP"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:53914 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751899Ab2FNINj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 14 Jun 2012 04:13:39 -0400
Received: by lbbgh12 with SMTP id gh12so2744923lbb.39
        for <linux-omap@vger.kernel.org>; Thu, 14 Jun 2012 01:13:36 -0700 (PDT)
In-Reply-To: <CA+Bv8XbwWbdTFFo9KHoOk7Tq8XBWDOWhkEqq7Pz6by_8sE_ngA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russ Dill <Russ.Dill@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Robert Nelson <robertcnelson@gmail.com>, Jason Kridner <jkridner@beagleboard.org>


--=-pZYlDaMn+aQTMEq3D4nP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-06-14 at 00:59 -0700, Russ Dill wrote:
> On Thu, Jun 14, 2012 at 12:18 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> =
wrote:
> > On Wed, 2012-06-13 at 23:58 -0700, Russ Dill wrote:
> >> On Wed, Jun 13, 2012 at 2:20 AM, Tomi Valkeinen <tomi.valkeinen@ti.com=
> wrote:
> >> > Commit e813a55eb9c9bc6c8039fb16332cf43402125b30 ("OMAP: board-files:
> >> > remove custom PD GPIO handling for DVI output") moved TFP410 chip's
> >> > powerdown-gpio handling from the board files to the tfp410 driver. O=
ne
> >> > gpio_request_one(powerdown-gpio, ...) was mistakenly left unremoved =
in
> >> > the Beagle board file. This causes the tfp410 driver to fail to requ=
est
> >> > the gpio on Beagle, causing the driver to fail and thus the DVI outp=
ut
> >> > doesn't work.
> >>
> >> Can you take the one I sent earlier instead?
> >>
> >> http://www.spinics.net/lists/linux-omap/msg69913.html
> >
> > Hmm, that probably doesn't apply. The power-down GPIO is now handled in
> > the tfp410 driver, not in the board files.
>=20
> Give me a branch to rebase it onto and I will.

v3.5-rc2

> > Looking more closely at the board file, what are these nDVI_PWR_EN,
> > DVI_LDO_EN and DVI_PU gpios? There's no "enable line" on tfp410. Only
> > the power-down gpio, which is none of the above...
>=20
> On my schematic, DVI_LDO_EN is labeled more sanely, DVI_PU. I'm not
> sure of the history of that. My patch does remove any reference to
> DVI_LDO_EN.
>=20
> nDVI_PWR_EN is labeled AUX_3V3_DIS on my schematic. AUX_3V3_DIS is
> connected to the disable pin of an LDO that provides power for the DVI
> transceiver.

Okay. These are a bit problematic, because we're in the process of
removing these kinds of things from the board file, as they cannot be
supported with device tree. The tfp410 driver in v3.5 doesn't even have
the platform_enable/disable callback anymore.

Those do not belong to tfp410 driver, but I don't really know how they
should be handled. This is one of the questions about device tree that
is unclear to me...

 Tomi


--=-pZYlDaMn+aQTMEq3D4nP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJP2Z0tAAoJEPo9qoy8lh71Kj0P/ibQTYMErvrHKxqYEf6ZK9TH
T/S8nYwFp7+BUm2doaGaKIgTWD63kp+YsE9WRJT7fKe0cAU44k3t6Y50NB9O8f12
+6QKJC3wsDlcsNods1a88eXaMAplzKREqkWL+7eLjqrSlIDuNiE0G0/SJeO5TEL1
MoGbj0qwyZRcpvSuczoeKR25C1Xz+Kb3olfqXq0EtdvPZAPESWRo+771NW6M5Q5M
ojnsoD+hennGvXJUl6UcqmlJVoxsq1meR60s8vcHEe2P9ntriu1W4zkcvo6iMYai
pStsydPPyROYML2Ovs0ysbpO6zHPB3x5XrwFCGMnrNKztOnvLctVp9Fzv96eQaM8
p/cjr6P36WkvoajWOZiWkdwS0uKVzEhkzT8Kd3U3c/EUd2SAK2JrOuRpAjIIwwRL
K+IGc6pdFr2gZiJAhVdvSSLFdOj+Ot6cFxdr6LxldI/mYuOqVO4YMRN21ya61CHS
Cht8vv8w+zO32bhyr/9BUUcO0t6q8+37Ncmnsn9gCbnxjINQoBL02RT/jSNMUaqN
NFkSbSMtHGHYPLfL9SiwCKuq4sbblSAL5SiIr16IMsL1tA4T5tzHnobIGWIR5srH
GkOMZPaCFDg4AcspL3Wqwv6m/njKCkesdN+Zh5zmxJn19NIRfkRv79PscMf+8Emk
D250wBjKN8UTmLUPmMQE
=9zky
-----END PGP SIGNATURE-----

--=-pZYlDaMn+aQTMEq3D4nP--

