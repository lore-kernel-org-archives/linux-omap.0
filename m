From: Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [PATCH 3/5] arm: mach-omap2: pm33xx: Add support for rtc+ddr in
 self refresh mode
Date: Mon, 1 Apr 2019 20:38:54 +0200
Message-ID: <20190401203854.3b6ec1a2@kemnade.info>
References: <20190322171619.4180-1-j-keerthy@ti.com>
 <20190322171619.4180-4-j-keerthy@ti.com>
 <20190401175245.GJ49658@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5330085055870608740=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190401175245.GJ49658@atomide.com>
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
Cc: linux-rtc@vger.kernel.org, a.zummo@towertech.it, alexandre.belloni@bootlin.com, d-gerlach@ti.com, Keerthy <j-keerthy@ti.com>, t-kristo@ti.com, ssantosh@kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============5330085055870608740==
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/IM5.dslcLd5HSNhpIvRvxx2"; protocol="application/pgp-signature"

--Sig_/IM5.dslcLd5HSNhpIvRvxx2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 1 Apr 2019 10:52:45 -0700
Tony Lindgren <tony@atomide.com> wrote:

> Hi,
>=20
> * Keerthy <j-keerthy@ti.com> [190322 17:16]:
> > +static int am43xx_check_off_mode_enable(void)
> > +{
> > +	/*
> > +	 * Check for am437x-sk-evm which due to HW design cannot support
> > +	 * this mode reliably.
> > +	 */
> > +	if (of_machine_is_compatible("ti,am437x-sk-evm") && enable_off_mode) {
> > +		pr_warn("WARNING: This platform does not support off-mode, entering =
DeepSleep suspend.\n");
> > +		return 0;
> > +	}
> > +
> > +	return enable_off_mode;
> > +} =20
>=20
> Considering off-mode suspend depends on how the board is
> wired for various things such as memory, PMIC and the related
> signal lines, I agree using the machine compatible is the best
> check we can do here.
>=20
> But since the device can hang during suspend unless things are
> configured right for the board, I suggest you rather list allowed
> boards here that are known to work with off-mode.
>=20
Could we somehow describe this property of the hardware
(is-offmode-capable or is-wired-for-offmode) as a separate devicetree
property of the soc?

In mmc we have for example "cap-power-off-card" for
indicating some is-wired-suitable-for thing.

That looks to be clearer as looking for some strange conditions
derived from something.

I have still my offmode patch os the boilerplate...

Regards,
Andreas

--Sig_/IM5.dslcLd5HSNhpIvRvxx2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEPIWxmAFyOaBcwCpFl4jFM1s/ye8FAlyiWr8ACgkQl4jFM1s/
ye/cGw//ZYvBpuTdIquv8gIi92U+KCQ40dhGuS4RS+ekk6hKriDB25jH+WPtBtYE
CE5TP6wdEXzyDpuFmStNmcgHnSESuZphI9NWw6kNtkUXdzfiNh/wdoUnKzibY0UN
pyezoSkhvnlU+7ss92sV2MjtOABSSMxpAiBtX4o/MifvWe5Z65RiqgprZ364Jxg/
GToGGzFosbcdk2eYR6aBl3F42J7ot0bD49W6JC8Pd08zSg2L1D9cb017IXEuxNF5
gsWRdoncV6wI62ZPPkwgJBc/6JcVLz6C+2Be2KbWkyYph23afNWcoIfqwLxjv4Dd
Re7HkXnbeSnkUCVPIdAn/1bNVtiQGAVxsezmFuO9p1zTOt5nNYKzoPNyaYf5deau
Kj+/xqP1anSyBGEo8pluIVXE35d3yy0NqP4Ct+PVf7hYt0OeEFE1dONTRED9BwDQ
9fIh/PvWVofyev4QeKaos0wBni1fXFKwAOtgAVKVCHFjkd163tCY+b71qaQRUQLn
ZqKog7XJcnx91Zv8+YTNxczrvyio1asa0D/F07j7uQlIpoyfqxVCJ5y6nbPEi427
akwLclMYtTrj43+LCTkJMUZbJvGAwLwEKyMYq9K1l5tKM169OBS8e47jq0nnS/ut
Lorje/wJEnfQRTby20aFKl3mXVBv9drIpbGt5JAtV5PoQandrL8=
=B7hI
-----END PGP SIGNATURE-----

--Sig_/IM5.dslcLd5HSNhpIvRvxx2--


--===============5330085055870608740==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5330085055870608740==--
