From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH-next 2/4] arm: boot: dts: am4372: add ARM timers and SCU
 nodes
Date: Thu, 13 Aug 2015 10:01:14 -0500
Message-ID: <20150813150114.GH27560@saruman.tx.rr.com>
References: <1439409416-32673-1-git-send-email-balbi@ti.com>
 <1439409416-32673-3-git-send-email-balbi@ti.com>
 <20150813083215.GY4215@atomide.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5741280885157240101=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20150813083215.GY4215@atomide.com>
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
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

--===============5741280885157240101==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="it/zdz3K1bH9Y8/E"
Content-Disposition: inline

--it/zdz3K1bH9Y8/E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2015 at 01:32:15AM -0700, Tony Lindgren wrote:
> * Felipe Balbi <balbi@ti.com> [150812 13:00]:
> > AM437x devices sport SCU, TWD and Global timers,
> > let's add them to DTS so they have a chance to
> > probe and be used by Linux.
>=20
> Applying this one into omap-for-v4.3/dt-v2. Not sure
> if it will get merged as we're getting close to the
> merge window. The rest we can patch once Russell has
> reverted the bogus SMP dependency.

I'm just waiting for Russell's "it's okay to post on patch system".

--=20
balbi

--it/zdz3K1bH9Y8/E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVzLE6AAoJEIaOsuA1yqREU8kP/A80b9G+TN9sN+FCJe5jStu4
TacXNdKzFd31K/A6Ba/ZYiyVqWBD31KobL3oyW/Gj0DVmECAZrAz3TPrS6wGJ+Vq
U6yy7eGBOMKgZnI0/chxBkU8MI0CxJYGHIN5FP+E9bGPevgAufhe+zPjoMb67Q5Y
BNdfNdB8CkaGkZ7P41lzO8sSwMDA52GfmGqs2iqa4swk2BukDi+vYKccXZWa7bC6
H9omFqzWHeEq6VhJsPlU7zu6jnXqEc30ZnSSXbXehg+tdgnP16TCiA7hwbBN3ZfN
F059WpuPTXvllxtrrv/ymRhBPW2/cEOx/HJspufBVK5Dt9tXaIiKZs++VtgyoEPc
S1GhEwvnkkrXJ6YxJvxl/mrv1iY1CJQtNGnSBaIV/Cui1CxRN1vuYZ64ncm++hyU
jPMwlr1s6ytQ06ikKgrvaEYUX0vzUxq3W4OVkGXYyU+V3yviUWOoW6c0wwv8RgFn
0fYdHO1ZAPFycFFul5Zj/hMLU7+NWFMxCGtS60Seb81Y5TXxIJuz8KgGpkdKerUZ
Flo5YM1WLSCsQTlsVKW/rpZZe97ud2vpaJEo+eUbvteCcmaioIDZW5YEv469weh1
1Q7zUNvr9hobX/mme+11pvkbecbNIkCr2ECpId+Q88c5ElHF8wLRXmy1/GYxJCqr
TWC+WJ8g8sAN4ze1ng3X
=2LTA
-----END PGP SIGNATURE-----

--it/zdz3K1bH9Y8/E--


--===============5741280885157240101==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5741280885157240101==--
