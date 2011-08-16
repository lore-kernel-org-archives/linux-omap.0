From: "Maximilian Schwerin" <Maximilian.Schwerin@tigris.de>
Subject: ALSA SoC TWL4030 driver
Date: Tue, 16 Aug 2011 15:33:09 +0200
Message-ID: <5448984682E7954C9BFF27F747A9C6CA4EAEF5@dolphin.TIGRIS.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="=-1pwuaG0WXpLif2SX8cIE"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from www45.your-server.de ([213.133.104.45]:37876 "EHLO
	www45.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751983Ab1HPOBg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Aug 2011 10:01:36 -0400
Received: from [217.91.135.48] (helo=IT_AstaroMailGateway)
	by www45.your-server.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.72)
	(envelope-from <prvs=02097756b3=maximilian.schwerin@tigris.de>)
	id 1QtJlk-0007ha-0X
	for linux-omap@vger.kernel.org; Tue, 16 Aug 2011 15:33:24 +0200
Received: from dolphin.tigris.local ([192.168.0.10]:3528)
	by IT_AstaroMailGateway with esmtp (Exim 4.69)
	(envelope-from <Maximilian.Schwerin@tigris.de>)
	id 1QtJlV-0003v8-17
	for linux-omap@vger.kernel.org; Tue, 16 Aug 2011 15:33:09 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

--=-1pwuaG0WXpLif2SX8cIE
Content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

I'm currently working on a beagle board clone.

I've got some problems getting the micbias1 output on the TPS65950 to =
work. I can record audio coming from a line out or if I connect micbias1 =
to an extern 1.8V supply.=20

/sys/devices/platform/soc-audio/TWL4030/dapm_widget shows Mic Bias 1 to =
be off at all times. Is there something I have to do to enable this =
other than to start recording? Or could this be a bug in the driver? =
Does anyone have experience with the mic input of the TPS65950?

Thanks, Maximilian

____________________________________________________________

Maximilian Schwerin                     mailto:mvs@tigris.de
Tigris Elektronik GmbH                  http://www.tigris.de
Wikingerufer 7                         Tel: +49-30-301048-30
10555 Berlin, Germany                  Fax: +49-30-301048-59
____________________________________________________________
=20
Gesch=E4ftsf=FChrer:              Henry Westphal, Guido Kuhlmann
Sitz der Gesellschaft:                                Berlin
Amtsgericht:                Berlin-Charlottenburg, HRB 71737
____________________________________________________________


--=-1pwuaG0WXpLif2SX8cIE
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.8 (GNU/Linux)

iEYEABECAAYFAk5KcaAACgkQ6nqkzTWctv7dyACgrkVwSXxYJJWg4WpKxZHYyBDX
O+cAoMNLtYztIX8EeDfgX4RXMR+MoNQn
=g8qb
-----END PGP SIGNATURE-----

--=-1pwuaG0WXpLif2SX8cIE--
