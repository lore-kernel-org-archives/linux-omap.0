From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 0/7] usb: dwc3: pm_runtime implementation
Date: Wed, 18 Dec 2013 09:36:14 -0600
Message-ID: <20131218153614.GB1593@saruman.home>
References: <1386884325-11440-1-git-send-email-balbi@ti.com>
 <20131217233140.GA21267@psi-dev26.jf.intel.com>
 <20131217233554.GB21267@psi-dev26.jf.intel.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3525671993730475100=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20131217233554.GB21267@psi-dev26.jf.intel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: David Cohen <david.a.cohen@linux.intel.com>
Cc: kgene.kim@samsung.com, w-kwok2@ti.com, Linux USB Mailing List <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, linux-samsung-soc@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

--===============3525671993730475100==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LyciRD1jyfeSSjG0"
Content-Disposition: inline

--LyciRD1jyfeSSjG0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Dec 17, 2013 at 03:35:54PM -0800, David Cohen wrote:
> On Tue, Dec 17, 2013 at 03:31:40PM -0800, David Cohen wrote:
> > On Thu, Dec 12, 2013 at 03:38:38PM -0600, Felipe Balbi wrote:
> > > hi all,
> > >=20
> > > these patches add pm_runtime support for all glue layers.
> > >=20
> > > I plan to add pm_runtime support for dwc3 after these
> > > patches are merged upstream.
> > >=20
> > > Please test.
> >=20
> > At first time I failed to notice you were removing #ifdef's around pm
> > callback functions. Instead of saying DWC3 will start to have warnings
> > when CONFIG_PM is not selected, I'd say your patch set is now a
> > dependence of my RFC :)
>=20
> I guess I said it in wrong order :P
> Your patch set depends on my RFC.

Or I just modify my patchset a little bit for now ;-)

--=20
balbi

--LyciRD1jyfeSSjG0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSscDuAAoJEIaOsuA1yqREumMP/29DtHPYLle6cj0DBD936nqL
8BHCCqWQNNUQeoZUJRdnbNDr5GATT4y6vop7RjBnmKEURLYmGjk0h6E3XtzRbVh5
Q7dujpivXAEKkCMcKmNOgR2E5fzcCGQtISAumFoaF9wjDwCPoeHT7Vv1PMiqASN7
ElBs/0LWZsFYcs65rjkrBiWcVjmiSiGAzUW+uuD0W/K8BWZTW+e18w/txYd/+n8Y
t47upOIXv5cfxAX5jqo683GvItn/Za80bPPlOm7ZX4W66kRxm7kYkH75aQe/PEps
EDk6ncr4SWCRmJsrwAKaSKcpdCp8a3tgDib9HSwIKIOHsTR6k2J7qsw0VTzXitXN
ZJXfG/fo0OKsGp7z3wdX4NdxpNUFZO2p8tN0LYeSPVP8lwt74KAuj/x8jqwgREXg
Xy6mOzQf1aaw9RLxY47dXVND6eYIukjN+23JX9DnKSP14R5edzsUxo8+Hh172SCA
PbVAEpwodZmLxyNvJRgxDv6UbyW01LPFk1p5eFeKRTMViCU6oQrNJMTZ8uLQtR5h
PsHi5/eTkC5Sugy2K+97DzojwcVEDakd+eAlh8rLPm7+TuTOxX9RGJucTBdbFvEb
We1yjbUaMroKRz1iKbxFuuReiJdV6PluDFtf8CwMSlglt7wTncfy7PfWQZGvjRXU
/QZ5nBCkm+gvEhPCypun
=Kmfo
-----END PGP SIGNATURE-----

--LyciRD1jyfeSSjG0--


--===============3525671993730475100==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3525671993730475100==--
