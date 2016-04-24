From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c/omap: drop the lock hard irq context
Date: Sun, 24 Apr 2016 22:37:06 +0200
Message-ID: <20160424203706.GB4317@katana>
References: <1459778123-16267-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LpQ9ahxlCli8rRTG"
Return-path: <linux-i2c-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1459778123-16267-1-git-send-email-grygorii.strashko@ti.com>
Sender: linux-i2c-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Sekhar Nori <nsekhar@ti.com>, Tony Lindgren <tony@atomide.com>, linux-i2c@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
List-Id: linux-omap@vger.kernel.org


--LpQ9ahxlCli8rRTG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 04, 2016 at 04:55:23PM +0300, Grygorii Strashko wrote:
> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>=20
> The lock is taken while reading two registers. On RT the first lock is
> taken in hard irq where it might sleep and in the threaded irq.
> The threaded irq runs in oneshot mode so the hard irq does not run until
> the thread the completes so there is no reason to grab the lock.
>=20
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> [grygorii.strashko@ti.com: drop locking from isr completely and remove
> lock field from struct omap_i2c_dev]
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Applied to for-next, thanks!


--LpQ9ahxlCli8rRTG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXHS5yAAoJEBQN5MwUoCm2v1IP+QFf7LQ3Sh9xXRzX4EsoG0dw
p5o2YpEFBAaDkOszMBRspw/vwbWIVLwJbGv2zuTHL4FwnskuFzSTpHMQIJL/oW4X
7E+mRqFIlrmSeN7+1TawOVK/LvCniAAuxXdJKiSXKhdm0hnoRKCMvA+yn2HNh451
v5GzjqoB8oGOrUO+iWktx6eQtk1PolXiLUamL/J6OJeH/11Smi/3rduuTtcgbs3o
ln93U+knUlzYuCmTRlQ3s8dU+IAgES43x59u9tfWardcqDtZF+qoSdceVhsDuu/q
smsbgXhOxV6gR/81Gi6Q2oBYEQHPQfmE4dbbuBfkMOvcaJI/fd2sGuEZErVgEXhL
p1AgzubhxTt6nQHSzTPbGQVDhvf50GqMg1mvb5u8F8sxrfErgLodSQtocyFxLX2W
B3uxCV4SUIZqSscfgSCvrls1vSx1+cDlFZRvP6UCqhuNDQtKd1LfUxMCQIgyLWkk
ApMTL8E5jXxL7kz9Hmdu4r6k2c/GwtaRHCvKQbK0AyzjkeLOB4O6MtfNhmNsZ24S
7nGVaOSdQ+XPf3SDhpuKtCRL52SUADFrNRS4Sn0WfOi3Bb9udQj0dUadbUNdsqZe
VPJVmVYFb0onmWxfhnMQLBxTh6aYaxV4fP63Y5zcM/IhML6vtI1C9Uo0x3jIAqew
mFZ320UkGgZ1lHcS9ZJ6
=pXlJ
-----END PGP SIGNATURE-----

--LpQ9ahxlCli8rRTG--
