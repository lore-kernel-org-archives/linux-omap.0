From: Sebastian Reichel <sre@kernel.org>
Subject: Re: omap4: support for manually updated display
Date: Sat, 20 Oct 2018 00:58:27 +0200
Message-ID: <20181019225827.s76wapp3cxrmp5af@earth.universe>
References: <20180830090456.GA17277@amd>
 <797c13fa-7a5b-a809-7dd0-14b01a3046be@ti.com>
 <3205865.8O8aibZXye@avalon> <20180910174453.GV5662@atomide.com>
 <20181018221549.GB6364@amd> <20181019164450.GD43338@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1922808444=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20181019164450.GD43338@atomide.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Tony Lindgren <tony@atomide.com>
Cc: mpartap@gmx.net, merlijn@wizzup.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, nekit1000@gmail.com, Tomi Valkeinen <tomi.valkeinen@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Pavel Machek <pavel@ucw.cz>, linux-omap@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org


--===============1922808444==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ods5vlhnrkscav5l"
Content-Disposition: inline


--ods5vlhnrkscav5l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Oct 19, 2018 at 09:44:50AM -0700, Tony Lindgren wrote:
> * Pavel Machek <pavel@ucw.cz> [181018 22:15]:
> > Hi!
> >=20
> > > > I want to make it clear that I don't want to claim any privilege in=
 getting=20
> > > > patches merged first. I am however worried that, without an easy wa=
y to test=20
> > > > DSI support, and without enough time to focus on it, I would break =
whatever=20
> > > > would be merged now in future reworks. I would thus like to find ou=
t how to=20
> > > > collaborate on this task, hopefully to move towards usage of drm_br=
idge and=20
> > > > drm_panel for DSI-based pipelines.
> > >=20
> > > Real users with mainline kernel with a real product should
> > > always have priority over any ongoing clean-up.
> > >=20
> > > And for testing, a bunch of real users is something you can't
> > > beat for proper testing of code on ongoing basis!
> > >=20
> > > Naturally the burden of getting the patches ready is on the people
> > > using them for rebase and fixing comments. And Sebastian has
> > > already agreed help with maintaining it.
> > >=20
> > > I've been actually using DSI command mode support and testing
> > > Linux next several times a week to prevent regressions from
> > > sneaking into -rc1 in general. So now I can't test omapdrm with
> > > next until Sebastian is done with rebasing.. Back to headless
> > > testing then.
> > >=20
> > > Anyways, I'd say let's add the DSI command mode support ASAP after
> > > rebasing, there are at least Sebastian, Pavel and I then testing
> > > and helping with further ongoing panel conversion work.
> >=20
> > Are there any news here? Does someone have a patch set that actually
> > works?
>=20
> I was wondering about that too.. I only have the v4.19-rc1 based
> patches and can no longer test with Linux next. Sebastian, any
> update?
>=20
> > Are there any in-progress patches I could help with?
>=20
> I can put in some effort too if needed.

I have some in-progress patches, that are not yet working. The
reversal of display pipeline initialization introduced some
issues with DSI (since the panel cannot be fully initialized
without DSI controller). I got this resolved by registering
the DSI display before the DSI controller is fully intialized.
This is obviously racy and breaks for device with DSI backlight
(since display probe function tries to do DSI queries). I think
properly solving this mess requires full migration to
the common mipi_dsi_host/mipi_dsi_device infrastructure. This
should obviously be done anyways, but for now the hack should
be good enough. There is still some other issue, though. I do
not yet understand the origin of that one.

I uploaded my current status here. It's not based on the newest
-next, but contains the interesting patches from Laurent. Also
the last few patches are not yet cleaned up, sorry for the mess.

https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-n900.git/log/?h=
=3Ddroid4-display-omapdrm-4.20-next

-- Sebastian

--ods5vlhnrkscav5l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlvKYZAACgkQ2O7X88g7
+pq8ohAAhEEFx2TYo5+ggG/iV2L9x6LLEYojJyhtQ2xNi9lNxiDGRaYlgyboG7I6
E0TxGaV6znnhH0SWNLsG1aqHG1xA7fhDuLNshPTRZlQk/PBpS6waI7/X0ZBfCans
PEEWAandOfScvN/JHeLkxTP0Ak6CrXKUK1UeHR+vq4t3TGTwDKOgT8N6ob3Y3nHY
L+3mk1ZljQny7tXkUMgiiy+GGS81WIJy8DLYQ/Xa9zfL9aR156hc4aGnnnwrANIJ
X7+z4tvsEcZAZLHpYG6W7SWirXIghGXwptMrDXWazRNNutlS/9R0GNOSYku9z61b
a4DsUe6afmYx4MDLSubfYP+fquObv81gSOQEWEd35liG30CPDFWMtepUHWaLU1Om
GsqGINXx2CEAcmUv67DJ8ORfqUZiEhF6ECHfzsvTYNad1SA/oEGCydTFW9cyG9tp
WAq5kLJqINlW2nxLwmfeybKreSx2nym6B2ivx8KClniZp0LkzD6GvSzY4+4SGlz0
gWXJhU/CGPD/Qc6Csd2SQf+8qW1kLMS5lGLF9SNPbWWR3MZoRNjr1SXgWhPar7qa
bDJNDgHYEq1PVGtMXLz8HgTQOzpG2WW+Re6m+Ivus7n8ixlS+B6JZhpj+YEOfzy2
pEF4e+MisA9WJRhiKWeLXs9vG1l8kKOhw5Rsb6UoqWtg52Nlv5s=
=5BXb
-----END PGP SIGNATURE-----

--ods5vlhnrkscav5l--

--===============1922808444==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1922808444==--
