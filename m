From: Sebastian Reichel <sre@ring0.de>
Subject: runtime check for omap-aes bus access permission (was: Re: 3.13-rc3
 (commit 7ce93f3) breaks Nokia N900 DT boot)
Date: Sat, 7 Dec 2013 19:49:59 +0100
Message-ID: <20131207184958.GB3704@earth.universe>
References: <20131206213613.GA19648@earth.universe>
 <201312070918.32471@pali>
 <20131207134818.GA933@earth.universe>
 <201312071457.38836@pali>
 <20131207165104.GD11015@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ADZbWkCsHQ7r3kzd"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ring0.de ([91.143.88.219]:48827 "EHLO smtp.ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754630Ab3LGSuF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 7 Dec 2013 13:50:05 -0500
Content-Disposition: inline
In-Reply-To: <20131207165104.GD11015@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, linux-omap@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>, Joel Fernandes <joelf@ti.com>


--ADZbWkCsHQ7r3kzd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 07, 2013 at 08:51:04AM -0800, Tony Lindgren wrote:
> * Pali Roh=E1r <pali.rohar@gmail.com> [131207 05:58]:
> > On Saturday 07 December 2013 14:48:20 Sebastian Reichel wrote:
> > > On Sat, Dec 07, 2013 at 09:18:32AM +0100, Pali Roh=E1r wrote:
> > > > On Saturday 07 December 2013 01:00:27 Sebastian Reichel=20
> > wrote:
> > > > > On Fri, Dec 06, 2013 at 02:27:25PM -0800, Tony Lindgren=20
> > wrote:
> > > > > > * Sebastian Reichel <sre@debian.org> [131206 13:37]:
> > > > > > > Nokia N900 DT boot breaks for me using 3.13-rc3. You
> > > > > > > can see the relevant kernel output below. Disabling
> > > > > > > the AES module in the omap3-n900.dts with status =3D
> > > > > > > "disabled" fixed the boot for me.
> > > > > >=20
> > > > > > OK thanks for letting me know. How about the following
> > > > > > patch to fix it?
> > > > >=20
> > > > > That's basically what I did to fix the problem.
> > > > >=20
> > > > > I guess the proper fix would be a runtime check if the
> > > > > device can be accessed (if that's possible). AFAIK it is
> > > > > possible to use the AES module on the N900 if the
> > > > > bootloader is slightly patched.
> > > > >=20
> > > > > Pali, can you elaborate more about this? I've seen, that
> > > > > you added a section about this on [0].
> > > > >=20
> > > > > [0] http://elinux.org/N900#M-Shield
> > > > >=20
> > > > > -- Sebastian
> > > >=20
> > > > Yes, if you want to use M-Shield on Nokia N900, you need to
> > > > use new version of signed Nokia X-Loader which enable
> > > > M-Shield usage outside secure world.
> > > >=20
> > > > Because this updated X-Loader is not official and I think
> > > > nobody has it in n900, please disable using these M-Shield
> > > > crypto modules on n900.
> > >=20
> > > Is the updated X-Loader available somewhere?
> > >=20
> >=20
> > It was on mediafire server linked from this thread:=20
> > http://maemo.org/community/maemo-developers/n900_aes_and_sha1-md5_hw_ac=
celeration_drivers/
> >
> > Now it is deleted from that server, but I have copy on my HDD.
>=20
> Hmm OK let's hope there's some working link still around for those.
> It seems like we should eventually cover both options, but for
> the -rc cycle, we need to just disable those hardware modules in
> the .dtsi files.

Yes. I think for -rc cycle disabling the AES module is the right
way. It has been disabled before anyway. I will test your patch
later.

> I think we can check the configuration from the L3 registers.
> Looks like we no longer have those defined after purging the
> unused defines a while back, but I think the registers for the
> configuration are L3_PM_READ_PERMISSION etc registers.

I asked Pali to send me his copy of the updated NOLO bootloader,
so that I can test this. I just checked the omap documentation
(I only have access to the public one) and crypto related stuff
is not documented for the L3_PM_READ_PERMISSION register. There
are a couple of reserved bits, which may be used for this, though.

I also CC'd Joel Fernandes, since he worked on the driver before and
may have access to the documentation.

-- Sebastian

--ADZbWkCsHQ7r3kzd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBCAAGBQJSo23WAAoJENju1/PIO/qal78P/2PAeH1g371QTJaN7kvqAH9e
WjcvH5AktyLF6kRMxlkPWZV9SZ6huAwn94aIiP/FhN6ay0B0xnFsJtjI3KhLE0iu
1MZI72N1v4rqwIZH+57zjqRdSgquWfcwJ7KduXYD1IOtPj1ib9XCv03o3y+RSxa0
8qm7Y4rW1CuAz3MIxOwEy/Oe5QEdgRTUM6pUx3FCi1uhl5dE4bRK3zTIyH+/di2S
wwlPIlroOiQTfvBzuhcm2QBLU0QPbNr+ojBCVtF1PVcPkJU6EJcpR15IFqJVkUGz
ilTugU3eK+0fmBnntHJU5eo1s9eSM9J455eWfQ3JHPLgtJsr9x1nBu7WthAXMs+Y
TqrEel/UYsng36ecMvfgw1L/nFE7ftK5FDbTatktkz3T+TtDdG5ULErvE/mkK2fh
aqd6Wx2i92fbgf5qb3Wy5/XUKab0RdOD7tj+/6gl95YEEV73KUY2zfm5B00UFpeJ
97F1HtN3r1Kmoy9j2NzHfYbml4Ga8EMrPSg6vzpGnhwWEEente/ioJmvN/ckgieV
9UobFN75YnJYMKEI5Wvg5ocGwdpCOa84sbKjin+JH/oQg5VcVEPsZDQAFT2n3oyT
g7DmwiGzCI5CnzDaI0rwfQo+XVncMGMVHoHKmcxPVgo1HiOaAd4pbe7mz6BeiUjE
MHXa9wqNMF4mL5pYZDAV
=vdHD
-----END PGP SIGNATURE-----

--ADZbWkCsHQ7r3kzd--
