From: Mark Brown <broonie@kernel.org>
Subject: Re: PM regression in next
Date: Mon, 15 Jan 2018 17:56:26 +0000
Message-ID: <20180115175626.GC12018@sirena.org.uk>
References: <20180112210706.GE4821@atomide.com>
 <20180112211535.GH21458@sirena.org.uk>
 <20180112215010.GG4821@atomide.com>
 <20180112221126.GK21458@sirena.org.uk>
 <20180112224959.GH4821@atomide.com>
 <20180112225947.GL21458@sirena.org.uk>
 <87wp0jzyig.wl%kuninori.morimoto.gx@renesas.com>
 <20180115165050.GJ4821@atomide.com>
 <20180115171917.GB12018@sirena.org.uk>
 <20180115175220.GK4821@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0681711664510073454=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180115175220.GK4821@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


--===============0681711664510073454==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bKyqfOwhbdpXa4YI"
Content-Disposition: inline


--bKyqfOwhbdpXa4YI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 15, 2018 at 09:52:20AM -0800, Tony Lindgren wrote:
> * Mark Brown <broonie@kernel.org> [180115 17:19]:

> > Did anyone actually try testing the fix I posted yet?

> Hmm I don't seem to have anything in my inbox. What might
> be the subject for it?

Sorry, I didn't actually post it - just suggested adding the
snd_soc_codec_set_regmap() call.

--bKyqfOwhbdpXa4YI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlpc60kACgkQJNaLcl1U
h9C49gf8DPUUGNkwn/XQlL0+CTgTPH70Luwurpw2REFinu4HTIbljPSWrYOGpbjO
l6ZLkyokIa9vpzhhFhmUg5GZhcokFrTmHDs82oZnWZ+6yYIRnrCtuTbhlNON5JIb
nnZr0rFfmGdv+HJjyo/F5v0CGaFERrPkSX3ZVTpO/Isl9LBHmALGXWqWeATEDzus
ghPyE7JYohGQpb/eF6+LaGlczXdlXUtqyy0gpDxvmqrT58Co3QBKMpKxP6Pv8hV7
DTtMB1xU0Si6fhkGzIC3zIcJkQKzX4RXLKS7l4vCNgGjqpOA3KceW9fKXWQo8Aa1
So/bN96boT+9IMo8numSfHEHunazAQ==
=laBm
-----END PGP SIGNATURE-----

--bKyqfOwhbdpXa4YI--


--===============0681711664510073454==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0681711664510073454==--
