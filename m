From: Felipe Balbi <balbi@ti.com>
Subject: Re: OMAP baseline test results for v3.10-rc7
Date: Thu, 4 Jul 2013 20:41:27 +0300
Message-ID: <20130704174127.GC6687@arwen.pp.htv.fi>
References: <alpine.DEB.2.02.1307011946180.4358@utopia.booyaka.com>
 <20130701204236.GA805@arwen.pp.htv.fi>
 <alpine.DEB.2.02.1307041650170.6258@utopia.booyaka.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6261679131033308458=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <alpine.DEB.2.02.1307041650170.6258@utopia.booyaka.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

--===============6261679131033308458==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UPT3ojh+0CqEDtpF"
Content-Disposition: inline

--UPT3ojh+0CqEDtpF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 04, 2013 at 05:11:33PM +0000, Paul Walmsley wrote:
> Hi
>=20
> On Mon, 1 Jul 2013, Felipe Balbi wrote:
>=20
> > On Mon, Jul 01, 2013 at 07:48:50PM +0000, Paul Walmsley wrote:
> > > Boot to userspace:
> > >     FAIL ( 2/12): 37xxevm, am335xbonelt
> >=20
> > <quoting part of [1]>
> > | U-Boot# tftp 0x82000000 am335x-boneblack.dtb
> > | link up on port 0, speed 100, full duplex
> > | Using cpsw device
> > | TFTP from server 192.168.57.1; our IP address is 192.168.57.138
> > | Filename 'am335x-boneblack.dtb'.
> >=20
> > Where are you taking am335x-boneblack.dtb from ? It's not in mainline
> > v3.10-rc7 kernel:
>=20
> As mentioned in my earlier reply:
>=20
> http://www.spinics.net/lists/arm-kernel/msg255055.html
>=20
> my earlier test boots were with the am335x-boneblack.dtb from the=20
> ti-linux-3.8.y tree from Vaibhav's github, since that was the only DTB=20
> that I was able to get any kernel to boot with.
>=20
> The am33xx_only/appended DTB issues don't apply to this board since it's=
=20
> booted with detached DTB and omap2plus_defconfig.
>=20
> Anyway, just retried it with the mainline am335x-bone.dtb file with v3.10=
,=20
> and the board comes up now.  So that's good, will switch to=20
> am335x-bone.dtb for the testing restate jobs to be run for=20
> BeagleBone-white, and let's see what previous kernels it boots with now...

alright

--=20
balbi

--UPT3ojh+0CqEDtpF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJR1bPGAAoJEIaOsuA1yqRElOoP/RQ3ScwB0OguWyg2VExqg2SO
7AAZqokr7C1eQN4ERJNrwfWKZo7TQUgzQrFFhlA7qm/qZXjtlX5OWCfTTF7DslVB
70b/ndPL6kzTQZo0a9SMYED6CgfxI8JNaP/62eLl4998sAOMgjixptvz9G4QZW12
cH0h21ONeyYv9IftgnpXxOQO8H5KZkW9l535TtiZNATYCN9yW41FrxGl9YMT91k3
KH3dM4Z6XfDqRtIGEG0V6urAHLHONtJiKmLxZvf2czCS9VIy45586r/F+0hWo3Ej
7acdYhVfcJao5KYf4CUoL6Z3DRpY6r2ZenCtv+mi8bL/qM3qQiQGU+9I8ZjJJ39e
1SyuGLSDzq384Lp++fu/NNpFtg+x1H65fOi6tWySRxLmfCaCiDgW4mMf6k+wd9p4
gPjUhycDrkF91kyuBaMI7sgmJRl7CZt9JMHmP2hq0K9eWsUb+vQEee4V2lw/Rm0c
AJ53hpEESFLPcI9jF2ZJWlD0s9p4ct8WKHA6xOKKT+SNBUMrrlzqJLYJ+m4n/6To
ZDRvlbYg+D346hC2Y+CimOk4XFvEecGDMfkZrmLONTuH5mciKfne6YQl/qtP2ZvH
KAhMH0WAozlFs/94/XLAT8JekUkxVWBujQkLAXnes1s+nLL9t02uUYAuxPWjFIlA
2+o6sxXE/Bp9kDgqUXPu
=KxGG
-----END PGP SIGNATURE-----

--UPT3ojh+0CqEDtpF--


--===============6261679131033308458==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6261679131033308458==--
