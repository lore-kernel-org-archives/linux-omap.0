From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/4] arm: omap: hwmod: 43xx: add DebugSS hwmod data
Date: Tue, 27 Jan 2015 11:18:43 -0600
Message-ID: <20150127171843.GD14878@saruman.tx.rr.com>
References: <1422054704-14915-1-git-send-email-balbi@ti.com>
 <1422054704-14915-2-git-send-email-balbi@ti.com>
 <alpine.DEB.2.02.1501260142590.5450@utopia.booyaka.com>
 <20150126165640.GA10679@saruman.tx.rr.com>
 <20150126194933.GG6660@saruman.tx.rr.com>
 <20150127160143.GH14623@saruman.tx.rr.com>
 <alpine.DEB.2.02.1501271652340.7149@utopia.booyaka.com>
 <20150127171532.GC14878@saruman.tx.rr.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8nsIa27JVQLqB7/C"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150127171532.GC14878-HgARHv6XitJaoMGHk7MhZQC/G2K4zDHf@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--8nsIa27JVQLqB7/C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 27, 2015 at 11:15:32AM -0600, Felipe Balbi wrote:
> On Tue, Jan 27, 2015 at 05:12:05PM +0000, Paul Walmsley wrote:
> > Hi
> >=20
> > On Tue, 27 Jan 2015, Felipe Balbi wrote:
> >=20
> > > On Mon, Jan 26, 2015 at 01:49:33PM -0600, Felipe Balbi wrote:
> > > > On Mon, Jan 26, 2015 at 10:56:40AM -0600, Felipe Balbi wrote:
> > > >
> > > > > hm... modulemode SWCTRL causes wait_target_ready to fail. Any hin=
ts ?
> > > >=20
> > > > gets stuck in transition state. PRCM_CM_WKUP_DBGSS_CLKCTRL is always
> > > > read as 0x 12510f00 which would translate into:
> > > >=20
> > > > - module disabled
> > > > - all opt clocks are on
> > > > - module is transitioning
> > > > - module in standby
> > > > - clkA as TPIU and STM trace clock
> > > > - all dividers set to 2
> > >=20
> > > just fyi, checking with HW folks, this might be a new bug, unless
> > > debugss needs something special.
> >=20
> > If that happens on DEBUGSS disable, it's probably the same issue as on=
=20
> > AM33xx:
> >=20
> > http://www.spinics.net/lists/arm-kernel/msg320801.html
> > http://www.spinics.net/lists/arm-kernel/msg321930.html
> > http://www.spinics.net/lists/arm-kernel/msg329151.html
> >=20
> > Does adding HWMOD_INIT_NO_IDLE fix the issue you're seeing?
>=20
> I'll try it out in a bit...

nope, same thing.

[   27.633235] omap_hwmod: debugss: _wait_target_disable failed

--=20
balbi

--8nsIa27JVQLqB7/C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUx8hzAAoJEIaOsuA1yqREo+oP/idOLxZNT6NRLcPcPm1cZhn5
c/J3Wp0pAzeUA04xvCCJgyx7jG4WYH8SimGNuRsMeMhC5tuZq+Woaf8r3JzcJTBn
RPKYGx65U+IOlGukaqjzEpqKZVIASIwMRdCUdaM76TSPkdIAXN/oZttIC4nKfUqz
9cBYgE5+CTXLavNLQXXwBxB4EaspDumQfEMonISyM27k5ubLRCuMRWk4hLfk+nd9
ygQU3dMz1fqNN6/81TrMhBQcSvuHgPjl6O62lXEzZOuW7UMX+4gFp5KxhFb/jdcO
ap98dYlVB2K/Qu9PfrtuKnwd9+RlQhxOkhW64BRNS2WHb0//rvocXOIr8Xj+u6bf
NBc+omJ9OOHzdU+tHu27pCIi2EXq9iN95zPOQAYj4xIdLwoBnjLNOEGjDjGXVV99
KPGfC8smdb/mJpionrrWgL4EXIvUzEdTKeLjiPA9Cw6p4//FaW9ccJCvShpJ19PR
ckVwSMXWgG/X73kZl+/hUrtVBUkiDHj3sVK3jaTQwk0eIMDAb7cK7VLF/247Ui19
OYgPuK74UdNZj2P0JpshbdGV6eznGe2V9cogyjgN3w8eytNAUduDl408q7w6lxTG
nd57egebVbdkFTttxfzwVPNGX030e5MafCobAU8Mzl2sppUz0rpHBiBRgfMwy/h4
c7VMm7/yIiZrxTPyttlv
=ZOLF
-----END PGP SIGNATURE-----

--8nsIa27JVQLqB7/C--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
