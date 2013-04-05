From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v3 1/4] ARM: OMAP4+: PM: Consolidate MPU subsystem PM
 code for re-use
Date: Fri, 5 Apr 2013 17:29:44 +0300
Message-ID: <20130405142944.GC12229@arwen.pp.htv.fi>
References: <1365166743-5940-1-git-send-email-santosh.shilimkar@ti.com>
 <1365166743-5940-2-git-send-email-santosh.shilimkar@ti.com>
 <20130405131935.GM11464@arwen.pp.htv.fi>
 <20130405133511.GA4143@kahuna>
 <20130405140420.GB12229@arwen.pp.htv.fi>
 <20130405141801.GA4270@kahuna>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2677036183587900478=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20130405141801.GA4270@kahuna>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nishanth Menon <nm@ti.com>
Cc: khilman@deeprootsystems.com, Felipe Balbi <balbi@ti.com>, tony@atomide.com, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============2677036183587900478==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KN5l+BnMqAQyZLvT"
Content-Disposition: inline

--KN5l+BnMqAQyZLvT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 05, 2013 at 09:18:02AM -0500, Nishanth Menon wrote:
> On 17:04-20130405, Felipe Balbi wrote:
> > Hi,
> >=20
> > On Fri, Apr 05, 2013 at 08:35:11AM -0500, Nishanth Menon wrote:
> > > On 16:19-20130405, Felipe Balbi wrote:
> > > > On Fri, Apr 05, 2013 at 06:29:00PM +0530, Santosh Shilimkar wrote:
> > > > > OMAP5 and future OMAP based SOCs has backward compatible MPUSS
> > > > > IP block with OMAP4. It's programming model is mostly similar.
> > > >=20
> > > > s/It's/Its/
> > > > s/mostly //
> > > >=20
> > > > (similar already expands to 'almost the same' :-)
> > > >=20
> > > > > @@ -355,6 +389,12 @@ int __init omap4_mpuss_init(void)
> > > > > =20
> > > > >  	save_l2x0_context();
> > > > > =20
> > > > > +	if (cpu_is_omap44xx()) {
> > > > > +		omap_pm_ops.finish_suspend =3D omap4_finish_suspend;
> > > > > +		omap_pm_ops.resume =3D omap4_cpu_resume;
> > > > > +		omap_pm_ops.scu_prepare =3D scu_pwrst_prepare;
> > > > > +	}
> > > >=20
> > > > why don't you just rename omap4_* into omap_* and add cpu-based che=
cks
> > > > there in order to handle differences between omap4 and omap5?
> > > >=20
> > > > If implementation will be almost the same for both, you might be ab=
le to
> > > > save on some more duplication, no ?
> > > Jeez NO! finish_suspend is assembly, further, it is the hottest path =
in
> > > cpuidle framework - for every WFI we invoke it. we definitely dont wa=
nt
> > > to add more overhead beyond what is necessary.
> >=20
> > alright, settle down ;-) whoever suggested that isn't here anymore
> hehe, Apologies, I was'nt that stressed as the wording might have
> indicated.. We spend tons of time evaluating with Lauterbach tracing to
> weed out hot paths - folks who have been bitten by these tend to feel a
> little defensive I guess and to have surprise regressions are painful to
> find and fix - esp when around not-so-obvious paths ;)

understood ;-)

--=20
balbi

--KN5l+BnMqAQyZLvT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRXt/YAAoJEIaOsuA1yqREYvAP/0MCo2iDnZCEKYe86ZwHsIXo
aSBqkyUxjKxfo+w/OZSPL9oJUqvo5ayvSnTzNiwyChJycjO8vSjNC5kQHtHeAYS2
ZkcGfetS8Lt9hlnJPJqwhSBvoaL1k99k/3h9k4EqcsgJnbJg/MQWaPRQyOuKxE7U
2XClJ/gTKDewDi0HLs4gc6soLvKqwKZR8REE4rFJYqPBrDDU3vl1PHDbQ37mnXiE
1G4FMo/43jK3EHxV1Xy7zrRTCN/YxxbA9+BPYR67p2pL0129cJzeeX5BNYEcHyxI
UQGJ4jpGTjNbjyrtdX2nhB3DBA4LRRb8L2jeo1WJbOU7bMglr+S9uPSLM7DmHRn1
dSoFCVSvlWPDqQljdh/eW7kYfWk452NJI2upyeYnOSEI9aunAepUocPCm6IpE2OU
LLOE6kTGIVJPFJrsNVjPv4pXxq1tXjUhZhpowI3kSM0WMHib24KSG06XN+uHTqVM
RrEy+Tnlu/tBy6ljqAoG9qsCYVRrpDc9ZS8dGOeoijqEF4Mn2XceYr44Su8a7SnD
pB8vYTOEAN6R4AZHGSl7pvEgKEV9nzj9Zj94GwlUUT+bKEtmMhtWW4i/sbjlciTN
WG1j2JIUOuqBTmx4FvTLkFsTVRu2Vpeq+zlzr3Xhba9UX+U7Zk0M4zGNYKJA0tvq
DNmPUgFY6SGNrzIoVpVH
=xHuQ
-----END PGP SIGNATURE-----

--KN5l+BnMqAQyZLvT--


--===============2677036183587900478==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2677036183587900478==--
