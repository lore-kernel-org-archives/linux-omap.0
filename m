From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAP: Beagle: fix TFP410 powerdown GPIO init
Date: Thu, 14 Jun 2012 15:20:35 +0300
Message-ID: <1339676435.2229.28.camel@deskari>
References: <1339579215-24098-1-git-send-email-tomi.valkeinen@ti.com>
	 <CA+Bv8XZHOhD1sdJvEzwwup+igWpkCf8twxWzrf2zhSd4_aj9MQ@mail.gmail.com>
	 <1339658290.2236.5.camel@deskari>
	 <CA+Bv8XbwWbdTFFo9KHoOk7Tq8XBWDOWhkEqq7Pz6by_8sE_ngA@mail.gmail.com>
	 <1339661613.2229.6.camel@deskari>
	 <CA+Bv8Xbqi7y3v2O7u8B31tv4JCTfQq3wWFojfK4UuAqDoYhB-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-jahM9H2nrWzWEUKWnq7X"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog134.obsmtp.com ([74.125.149.83]:37422 "EHLO
	na3sys009aog134.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750961Ab2FNMUl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 14 Jun 2012 08:20:41 -0400
Received: by lagy4 with SMTP id y4so1337763lag.29
        for <linux-omap@vger.kernel.org>; Thu, 14 Jun 2012 05:20:38 -0700 (PDT)
In-Reply-To: <CA+Bv8Xbqi7y3v2O7u8B31tv4JCTfQq3wWFojfK4UuAqDoYhB-Q@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russ Dill <Russ.Dill@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Robert Nelson <robertcnelson@gmail.com>, Jason Kridner <jkridner@beagleboard.org>


--=-jahM9H2nrWzWEUKWnq7X
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-06-14 at 04:40 -0700, Russ Dill wrote:
> On Thu, Jun 14, 2012 at 1:13 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> w=
rote:
> > On Thu, 2012-06-14 at 00:59 -0700, Russ Dill wrote:
> >> On Thu, Jun 14, 2012 at 12:18 AM, Tomi Valkeinen <tomi.valkeinen@ti.co=
m> wrote:
> >> > On Wed, 2012-06-13 at 23:58 -0700, Russ Dill wrote:
> >> >> On Wed, Jun 13, 2012 at 2:20 AM, Tomi Valkeinen <tomi.valkeinen@ti.=
com> wrote:
> >> >> > Commit e813a55eb9c9bc6c8039fb16332cf43402125b30 ("OMAP: board-fil=
es:
> >> >> > remove custom PD GPIO handling for DVI output") moved TFP410 chip=
's
> >> >> > powerdown-gpio handling from the board files to the tfp410 driver=
. One
> >> >> > gpio_request_one(powerdown-gpio, ...) was mistakenly left unremov=
ed in
> >> >> > the Beagle board file. This causes the tfp410 driver to fail to r=
equest
> >> >> > the gpio on Beagle, causing the driver to fail and thus the DVI o=
utput
> >> >> > doesn't work.
> >> >>
> >> >> Can you take the one I sent earlier instead?
> >> >>
> >> >> http://www.spinics.net/lists/linux-omap/msg69913.html
> >> >
> >> > Hmm, that probably doesn't apply. The power-down GPIO is now handled=
 in
> >> > the tfp410 driver, not in the board files.
> >>
> >> Give me a branch to rebase it onto and I will.
> >
> > v3.5-rc2
>=20
> This one (v4) already applies to v3.5-rc2
>=20
> http://www.spinics.net/lists/linux-omap/msg70042.html

My ack for v4:

Acked-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

And I'd reword the description, "fix" instead of cleanup. The "boot
warnings" are errors. I don't think the DVI output works at all with
beagle in the current mainline.

Btw, please cc me when sending patches related to display.

 Tomi


--=-jahM9H2nrWzWEUKWnq7X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJP2dcTAAoJEPo9qoy8lh71ZvUP/jDfyuDiRfvD8nSx1J6KT6bG
doV1h486/uyh+icNaQ/dTpFMNua5ImuMfFmO40ZVQKGBAQxVv4zYUawDxr1KW/3t
SvsVCCOhYarPRvorrr7Q/I7ofG9vA8PJlJcjnShtiK6TKzbIvok2AWmEijwEqG1j
IcZrvxuSj77ys+TVwu6Zs9e2JCDGroSPkhNtcdu7rzSwT0FAdkmNux/uUC2Z7Nv8
7OlnmwhhxRXw7dxlYQxhqtJAOPxNL5NYKsWPlF2dWh4nwuPlYxSr9WyzwZ7e9I5y
Sdhr+hRBwI/xgZPrgC0EJ52XEHG/Zrtn3k0jXxKGft6Tyy4J9hdoeikhQwhexMHS
WtZ9UUxggkv6Hh/H9hAsllzFJid/xkbtqZe6VjtyWDNSUCHh6UapuVeKtFtIIKjC
yuskOjOjBpXeNofoW88DbOzCOnzblSxXUjUc0nNbw6l7Sz0YxVVwE3nPVXfb5vX5
YcJIa75LTXeIpWeK93G99m/dDqnm9pMSTFVFIQ4OzIerv/YIi7yx/Jc0GvQpE8Kd
Tf02AftJHqLGV4PmG7Tr6/0i/mN3RuKVn5kfvp/qBQXYv2uNxRvJHuxobyzJkQf5
V1GJinmBKdUuQhWh3Qg71lL30clcbl5/xRqU3FPi7r6CLup2vmquRrwCgDh4lPLh
HNGQObMtt2ooRBKMOfLu
=0n4H
-----END PGP SIGNATURE-----

--=-jahM9H2nrWzWEUKWnq7X--

