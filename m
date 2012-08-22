From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC] ASoC: snd_soc_jack for HDMI audio: does it
 make	sense?
Date: Wed, 22 Aug 2012 17:40:57 +0100
Message-ID: <20120822164056.GS7995@opensource.wolfsonmicro.com>
References: <5032E8A5.8070108@ti.com> <s5hlih895kt.wl%tiwai@suse.de>
 <20120821120511.GB7995@opensource.wolfsonmicro.com>
 <50337F7B.1060501@canonical.com>
 <20120821131625.GD7995@opensource.wolfsonmicro.com>
 <503434DD.8030003@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3922958154336964893=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <503434DD.8030003@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ricardo Neri <ricardo.neri@ti.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Peter Ujfalusi <peter.ujfalusi@ti.com>, "Valkeinen,
 Tomi" <tomi.valkeinen@ti.com>, "Guiriec, Sebastien" <s-guiriec@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Liam Girdwood <lrg@ti.com>, David Henningsson <david.henningsson@canonical.com>
List-Id: linux-omap@vger.kernel.org


--===============3922958154336964893==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ISCXPd1dR6/8kjof"
Content-Disposition: inline


--ISCXPd1dR6/8kjof
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 21, 2012 at 08:24:45PM -0500, Ricardo Neri wrote:

> So, it seems that the way to go is extcon. I guess that ALSA will
> use extcon just like today snd_jack uses the input driver. is this
> correct? Is there any chance that ctrljack will propagate the events
> through extcon? Is there any early implementation that I could look
> at? I am asking to know how feasible is to use ctljack today and be
> compatible with extcon in the future.

The ctljack API doesn't really map onto the other jack APIs at the
minute since the in kernel representation is that it exposes the
booleans directly to the callers rather than grouping them together into
the overall jack.

--ISCXPd1dR6/8kjof
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQNQuRAAoJEFJkBDiqVpZ4HKEQAKUk6DIc22eiqSSb6FSGY8RO
lvcTcGrEyt9fc953ZbOHvzeMosEdzkmabaXPGiwNgmkHN1xhXeW+fkld/aUxBJ+3
6SZ0YtiXSVpM/sRtbu7whUl87QFRcmKd8klDSGfxhI+4Q8ECw4UvHKiReTQMPG3s
nc0dIoWF7R+qGjohlhRnmUWF6QpbBba3hLRKZJGOsVJqyys0SYMTGtYfMPkmU4/I
v8bdlOJ22HD+sJpsHbhYzoW/KpyWIq05Y6KO3X0NWhBKfPZYs4mrxizqIli/9D1a
BClknYZaTS7vuyOLZtTDr07wzoUIcAhn1y8Eqn8AJlCStqb1YfNZKh4NtxZdyXku
1VHO+fc/KeEwzUzi8N4m930Vbe/1o0yHo127/AcyyjUEbgXUJhKFpzdWzFZI+Dg9
nhXPM3f1igsyJCc16D7RlkVHnIAhPRA96J6OvjU0d3PEGP6fZ7FBpvp0RljbJWin
w/kzeIIQjK39wA6cy+dM0C2sycHd1YOTzCMf+LMBmpI37KOG54mCwX7QNASVp4Fr
k+cp0PvjnbSuVyCUQZ6se9mjxiU0ZDYt4Nz+oFdGWO3yzANArBCKlcw2exp/qmM+
KRlSEkjF+qhEw4iz9zJ0aeLOlRDpf8+zO3X1urWkeLl0HvWPKnqF+V7YOYOvFYrQ
dm8gbOHeTUiDZ2z+eF0m
=7Yr5
-----END PGP SIGNATURE-----

--ISCXPd1dR6/8kjof--

--===============3922958154336964893==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3922958154336964893==--
