From: Mark Brown <broonie@kernel.org>
Subject: Re: Query on Audio DMA using DMAEngine
Date: Thu, 4 Jul 2013 11:53:42 +0100
Message-ID: <20130704105342.GW27646@sirena.org.uk>
References: <083BC63EECB6FD41B8E81CF7FD87CC0F2E4F1488@DLEE08.ent.ti.com>
 <51D01F31.3010602@metafoo.de> <51D11D64.3070805@topic.nl>
 <51D24A01.2050709@ti.com> <51D26A18.8040903@topic.nl>
 <20130702121345.GL27646@sirena.org.uk>
 <51D3EA42.3040205@metafoo.de>
 <20130703094307.GE27646@sirena.org.uk> <51D46598.6070005@ti.com>
 <51D510EA.1030809@topic.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3593270413390286312=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <51D510EA.1030809@topic.nl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: Joel Fernandes <joelf@ti.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, davinci-linux-open-source@linux.davincidsp.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--===============3593270413390286312==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="K5FRBbPSksISZ1JK"
Content-Disposition: inline


--K5FRBbPSksISZ1JK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 04, 2013 at 08:06:34AM +0200, Mike Looijmans wrote:

> In any case, using the IRAM directly might have some use, because
> you don't have to compete for the DDRRAM with other devices. But I
> never understood what the ping-ping via IRAM was supposed to
> accomplish, I don't see why McASP -> IRAM -> DDRRAM (or the other
> way around) would be better than just McASP -> DDRRAM. Especially
> since the McASP has a built-in 256 byte FIFO buffer on both
> channels. In all my measurements, using the IRAM ping-pong only made
> things worse in terms of overruns and underruns, not better.

> Anyone who know why the ping-pong was implemented and what kind of
> usage it was intended for?

Pushing the audio through some static RAM is normally implemented in
order to save power - when doing this you can put the dynamic RAM into a
lower power state for more of the time, only waking it up to burst data
to or from the static RAM (assuming an otherwise idle system).  This is
more normally used for playback than for capture but the same idea
applies in both cases.

--K5FRBbPSksISZ1JK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR1VQyAAoJELSic+t+oim9PAIP/1TBJa7sX5UyRVbAy/5Yn9ON
Nsaa/hRtISemCVnXGbH8L/tWMNgfyOfQmOlFiyRX/7rDGgkKxcd0Ou7/pysGMjIq
jRPhcNeTqCWnXIZqOMi+8Yd+VsGrPpzXKowJNIAp1etb9RAfoXXZrT8p9J7cY20F
ZdaercTxyrq31QRH8hLJuhciU8DWEPopNxeNj2L8Zn+jD3XT+DKIcH+nwQNuIUjw
LoWi4iQgE7qJBuiyehd2mJP0bUaa7Sf4CXAkmCPdlkjbB20ACsd6bgx6iJVBstKB
WuNDQ6qm697Sat9Vv9uwwd5dX0ImOlguQkkX6hndgKZL2oqSynLOhfF0bjBurxe9
fgFJqOfRDRj0EzZD7Lxz10mbkZmPrxST3wcUn730GGKb8oESVosAIl8OjaB+tGBU
Ptd5sKi1BDPDQZ8CI5g4Kh0KsNO5qulT48bEduEETA04fgfeBVP6b1DXTun/YQ2n
4gP5UvuU1cxMI0HoBAX5AbtK35dceL+LHwuZgxt0vwIzmhIAmFKiczEO6FIGh0xP
uuD2tF+KqMKaefCaZJJjE2uIXIAvowJB0dpPCu08TS8Q6hopYv96bmuRbNW423+m
Lbun7aqYQ/Yw0V4oh5UnsKyW8+Qz4hirDpwC00IjjOf72F1xdU8IjkiqRPRLTQUj
SoHYLHNTItos3AT5s109
=RqX7
-----END PGP SIGNATURE-----

--K5FRBbPSksISZ1JK--

--===============3593270413390286312==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3593270413390286312==--
