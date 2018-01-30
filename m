From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] sound/tlv320dac33: Add device tree support
Date: Tue, 30 Jan 2018 11:32:38 +0000
Message-ID: <20180130113238.GA10525@sirena.org.uk>
References: <20180129230539.GA18280@amd> <20180129232031.GA7695@lenoch>
 <20180129233301.GA18104@amd> <20180130083446.GA13498@lenoch>
 <20180130085314.GA4585@amd>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5425353166086858625=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20180130085314.GA4585@amd>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pavel Machek <pavel@ucw.cz>
Cc: mark.rutland@arm.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, tony@atomide.com, abcloriens@gmail.com, ivo.g.dimitrov.75@gmail.com, tiwai@suse.com, martijn@brixit.nl, Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>, patrikbachan@gmail.com, Ladislav Michl <ladis@linux-mips.org>, khilman@kernel.org, serge@hallyn.com, devicetree@vger.kernel.org, pali.rohar@gmail.com, robh+dt@kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, aaro.koskinen@iki.fi, linux-kernel@vger.kernel.org, clayton@craftyguy.net, sakari.ailus@linux.intel.com, sre@kernel.org, bhumirks@gmail.com
List-Id: linux-omap@vger.kernel.org


--===============5425353166086858625==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 30, 2018 at 09:53:14AM +0100, Pavel Machek wrote:

> Well, notice I'm converting existing driver to device tree. And that
> one already has GPIO dependency. It is possible that more work needs
> to be done there, but that should not be a reason to delay this. Feel
> free to help.

No, it's a very good reason to delay merging something.  A DT binding is
an ABI so we need to sort out interface issues and describe things as
well as we can, with board files it's not an ABI so we can just do any
old thing that happens to work and while it might not be ideal it
doesn't really matter since we can change it later if we need to.

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlpwV9QACgkQJNaLcl1U
h9AjzAf+MrrqV6SDQoxsxACv09qGVntDjrDp1/5iroH/gHKjWTCPSLlkmJacyyY/
ewMq30TKUotIusAtO/8gWWP6HBgr8TZcPq5BEUWgUNC76b6sO4fqPII90ZUnpW8I
f0wYTe6M5yfTWtO8BXC3vs5x8pJFCp7iypIb3Gacwh3aoYIUauVLZCJ4F+St9Dcy
df4dUX1PM/d4PcFCwxC7gUwFjmELexcOvVM2+BfBzVlvNeqTnKu//WqmrUEEy13s
Q94EmPZXyqrVpb4LaLFz1mSB+yegCxz+4otJh9QNAtARCf5TZo8aptT5o3HQd1xl
+GYlt/Pvh4LNea30lyvyMbjQwLMFnA==
=zGsm
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--

--===============5425353166086858625==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5425353166086858625==--
