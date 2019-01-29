From: Mark Brown <broonie@kernel.org>
Subject: Re: New underflow of regulator enable count warnings in v5.0-rc1
Date: Tue, 29 Jan 2019 17:01:27 +0000
Message-ID: <20190129170127.GG10524@sirena.org.uk>
References: <20190129164813.GA5720@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3574133752279171937=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190129164813.GA5720@atomide.com>
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
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Douglas Anderson <dianders@chromium.org>, linux-arm-kernel@lists.infradead.org, Sebastian Reichel <sre@kernel.org>
List-Id: linux-omap@vger.kernel.org


--===============3574133752279171937==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/Zw+/jwnNHcBRYYu"
Content-Disposition: inline


--/Zw+/jwnNHcBRYYu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 29, 2019 at 08:48:13AM -0800, Tony Lindgren wrote:

> regulator-dummy: Underflow of regulator enable count

> Are these bogus warnings for dummy regulator or do we have
> real unpaired regulator calls or somewhere?

Given that this is a new warning my first guess would be that it's
legitimate...

--/Zw+/jwnNHcBRYYu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxQhucACgkQJNaLcl1U
h9DvNgf/afV1Q9dfKEBi5X3uqIODf6E85oTYa+NZvgVWnAWdwnUWzNtkeevo/L7z
kbDoRiyhz8txKBiwZqyh46yWeTDKJepSfunaqT/1ZQfbkr2SnNDDncEB0W/TOk8g
PMLIGlK5rw9Y1P2TGWuCel/XAXF64fdlMz7HiM0PJco6RFbZgnMa85i8IfYCL6p0
IzC/dC3XQ6NeczMa9qLnrNHMp4iMF27OsNKgB1VLLzcb7TePFJDQUJAB4GDWvl4s
WrKl/MqQhQNfWPsQ+DRSYVnAphWyQZe+6RPInZOEVEBVZ8AKpAXnYz8g/aSyyQpU
L9r597E1hN+WOn4igpiu7y8UTEle7w==
=waLs
-----END PGP SIGNATURE-----

--/Zw+/jwnNHcBRYYu--


--===============3574133752279171937==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3574133752279171937==--
