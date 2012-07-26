From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH V2] Add missing modules aliases to get
 sound working on omap devices
Date: Thu, 26 Jul 2012 23:00:50 +0100
Message-ID: <20120726220049.GK4560@opensource.wolfsonmicro.com>
References: <4FFECC40.5020502@free.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1301524147303685493=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <4FFECC40.5020502@free.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Guillaume Gardet <guillaume.gardet@free.fr>
Cc: peter.ujfalusi@ti.com, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, mans.rullgard@linaro.org, Liam Girdwood <lrg@ti.com>
List-Id: linux-omap@vger.kernel.org


--===============1301524147303685493==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hl1kWnBARzJiTscN"
Content-Disposition: inline


--hl1kWnBARzJiTscN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 12, 2012 at 03:08:16PM +0200, Guillaume Gardet wrote:
> This patch add missing modules aliases to get sound working on omap devices.

So, after a bunch of hand editing I applied this.  As I *repeatedly*
requested you should send patches in the format covered in
SubmittingPatches, the main reason it took me so long to get round to
applying this is that I had to strip things like this:

> From 18b1ba8becc3dd256bdaad2d825f46b551debda3 Mon Sep 17 00:00:00 2001
> From: Guillaume GARDET <guillaume.gardet@oliseo.fr>
> Date: Tue, 10 Jul 2012 13:47:16 +0200
> Subject: [PATCH] Add missing modules aliases to fix audio on omap devices

out of the commit message, plus the fact that since you hadn't used an
appropriate subject line for the subsystem your patch didn't turn up
when I searched my mail for patches to be handled.

--hl1kWnBARzJiTscN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQEb38AAoJEBus8iNuMP3duHIP+wfACPXfvx13c5xDwwblu7V2
qGGMwHwe224Eg55dqvtS+xshTewKkNz3iFIAOUxoiN0dbR4HY0SsdtKqoeNOLWqP
iN93QrVXkeXbW9009FYsPq+p8/tNqdcOXxacLKsGCefAesw5Hs9/3+dqeuicEGie
/1mVs1shM5n9q3/Qr+3q0uT2HLmUSo5Kbu8JlpqiBf4wxHFfVQmsOR3UtwGYG5rk
hd2yttrZiBj2tSPg+NqRCN6dmNiGEJK6nXCzTDXqqwhKv4z6ynkd+gHRcchkFOUE
UAvO8HAYDK3siOmoKvvC9bEwKX1dW31dX3cZqiiDVN0pwVDgmDx1dRlzsNxlu8iE
z+OOBklPb+4tTVs0QSA4AeoMm6BawdHsjGmErF2d/qX3ee0Kv/wVwiXpV9qwYwF0
nCAZcaOqVovy8/24U3/+PbkzQOKP0sXGF3ZilvwJGxwcumv1ciTiwZssk5SckjeV
lf726snEeEuPZ/q9FKqqnjWURQjran1/nrnuXJSQpaQIOUL75ZhmE3ahquNfylVG
kck/kGNExNgY6R+xc96tDk4wW0WPTvWpqbjBmm+F1hH9eW0UEZZNOi1MW9xMHDB5
14kjK1rFXOjgH5rDvfBLHCalmwu0IIbecJgcYCn2TZ9HMiSDBWeXH55plgszwbg4
iyH7t8TlWh+FIk7LcgAP
=reJn
-----END PGP SIGNATURE-----

--hl1kWnBARzJiTscN--

--===============1301524147303685493==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1301524147303685493==--
