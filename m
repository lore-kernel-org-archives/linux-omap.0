From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCHv8 1/9] dt-bindings: omap: add new binding for PRM instances
Date: Tue, 8 Oct 2019 17:46:55 +0200
Message-ID: <20191008154655.u34wkbqgmelv3aea@earth.universe>
References: <20191008125544.20679-1-t-kristo@ti.com>
 <20191008125544.20679-2-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8435942204498745943=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20191008125544.20679-2-t-kristo@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tero Kristo <t-kristo@ti.com>
Cc: devicetree@vger.kernel.org, tony@atomide.com, p.zabel@pengutronix.de, ssantosh@kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


--===============8435942204498745943==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ctyqydaobcxcfjee"
Content-Disposition: inline


--ctyqydaobcxcfjee
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Tue, Oct 08, 2019 at 03:55:36PM +0300, Tero Kristo wrote:
> +Example:
> +
> +prm_dsp2: prm@1b00 {
> +	compatible = "ti,omap-prm-inst", "ti,dra7-prm-inst";

Nit: compatible values are sorted the other way around (most
specific first).

-- Sebastian

--ctyqydaobcxcfjee
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl2cr2gACgkQ2O7X88g7
+pqWmxAAnbs6GjNR1+b2puQnzOpb3nsF6NWlckoiR/wBE5/utyC4v95yoB2Jm+sS
c7GlleJA5DmF8E40TuOq3HL/z+dt5P/vWX9egt0um6TtHZ3Z7rMWuwvv5TK+3St8
DF7ktlGqs2KG/E96LMf762P69CK2IccE7GUpY7N+MiFOZFuMJ7e+vUMyetuuSqeT
1r/RxLgyNAbeM5X0l4mN95Tv6A+aeuBr0jpX+N97vsEXUtdJ+5aLrlFX+8zsc/rn
LpexzXPaUDR5RgotC/+l9TxCAXwmHKJtPo0lLSsOWtctaD5MHYH/VkWAMCO3EGx8
YhOTT2ZNnfsR51Nc0mee/LzhrHGVYrnh+V15riJilNypnY+2wIw+B91xbJoMBFx2
PWLdwU+z67Cnc/+R/qaAYFNOQAfji1e+dAR5uAybReYzJGGRx+IOX/CInPuNZEdh
YMbngcINMVVEd3PzdCHUsIUOoXTpoAl0PlLVvLcf9JMxkn+5+SD23Sk+oNEjreVD
39Sb8bmrUG5C8DWBgddKpRE9dSbooLJhdkNApMUDdZwoluEDYeYlH2UDE+j7OkN6
kTZXans1Iq0fkkq/w/V3AQO5Z8aP+FHIIg6j6Jy6zD3C9L7Lw4EdhWFBBPDFpWp/
UGPs6TkWr0rre1fR657a3oKgv3OYwThEf3+bnTvbK7RiVQukc0Q=
=qzjC
-----END PGP SIGNATURE-----

--ctyqydaobcxcfjee--


--===============8435942204498745943==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8435942204498745943==--
