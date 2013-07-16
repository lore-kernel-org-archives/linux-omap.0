From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 3/4] pinctrl: Add support for additional dynamic states
Date: Tue, 16 Jul 2013 12:35:41 +0300
Message-ID: <20130716093541.GK8880@arwen.pp.htv.fi>
References: <20130716090310.5541.36777.stgit@localhost>
 <20130716090536.5541.36289.stgit@localhost>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8120023293018467928=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20130716090536.5541.36289.stgit@localhost>
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
Cc: linus.walleij@linaro.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Stephen Warren <swarren@wwwdotorg.org>
List-Id: linux-omap@vger.kernel.org

--===============8120023293018467928==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7vAdt9JsdkkzRPKN"
Content-Disposition: inline

--7vAdt9JsdkkzRPKN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 16, 2013 at 02:05:36AM -0700, Tony Lindgren wrote:
> +int pinctrl_check_dynamic(struct device *dev, struct pinctrl_state *st1,
> +			  struct pinctrl_state *st2)
> +{
> +	struct pinctrl_setting *s1, *s2;
> +
> +	list_for_each_entry(s1, &st1->settings, node) {
> +		struct pinctrl_dev *pctldev1;
> +		const struct pinctrl_ops *pctlops1;
> +		const unsigned *pins1;
> +		unsigned num_pins1;
> +		int res;
> +
> +		if (s1->type !=3D PIN_MAP_TYPE_MUX_GROUP)
> +			continue;
> +
> +		pctldev1 =3D s1->pctldev;
> +		pctlops1 =3D pctldev1->desc->pctlops;
> +		res =3D pctlops1->get_group_pins(pctldev1, s1->data.mux.group,
> +					       &pins1, &num_pins1);
> +		if (res) {
> +			dev_dbg(dev, "could not get state1 group pins\n");
> +			return -EINVAL;
> +		}
> +
> +		list_for_each_entry(s2, &st2->settings, node) {
> +			struct pinctrl_dev *pctldev2;
> +			const struct pinctrl_ops *pctlops2;
> +			const unsigned *pins2;
> +			unsigned num_pins2;
> +			int i, j, found =3D 0;
> +
> +			if (s2->type !=3D PIN_MAP_TYPE_MUX_GROUP)
> +				continue;
> +
> +			pctldev2 =3D s2->pctldev;
> +			if (pctldev1 !=3D pctldev2) {
> +				dev_dbg(dev, "pctldev must be the same for states\n");
> +				return -EINVAL;
> +			}
> +			pctlops2 =3D pctldev2->desc->pctlops;
> +			res =3D pctlops2->get_group_pins(pctldev2,
> +						       s2->data.mux.group,
> +						       &pins2, &num_pins2);
> +			if (res) {
> +				dev_dbg(dev, "could not get state2 group pins\n");
> +				return -EINVAL;
> +			}
> +
> +			for (i =3D 0; i < num_pins1; i++) {
> +				int pin1 =3D pins1[i];
> +
> +				for (j =3D 0; j < num_pins2; j++) {
> +					int pin2 =3D pins2[j];
> +
> +					if (pin1 =3D=3D pin2) {
> +						found++;
> +						break;
> +					}
> +				}
> +			}

4 levels of nested loops ? Isn't this way too much ? OTOH, it points to
the fact that, perhaps, a list isn't the best data structure for
pinctrl ??

Or perhaps you could just assume that if num_pins1 =3D=3D num_pins2 it's
enough ? But that will, likely, leave some uncovered corners...

--=20
balbi

--7vAdt9JsdkkzRPKN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJR5RPtAAoJEIaOsuA1yqREvDQP/Arn85Cs3z/fTMutIj6Xx6Wl
EK2svg3c02vQ1Vd9nZM7OEGgNyQdqTEkSyqgFX0ZekuOxEBZkDoTunC4Ai3/1hUA
0C4BDndTl6o9JQ41ECilhF06cgrYfEJO6p6piYiaurm8vGefAmr/GGp0Pj50TNX3
8gpZS2x/ERk+VSq4efbGImO5w7Qic1icu+Omda5YBBpMvzDFeL9Ly+wip1XT0MXa
/krnMmWg2JsxYiXh5IGSOn9FCyHesJcSeYef69a6Dq1p/CulynCHAz4Ivue+lDgB
QQ+0aql+p5Z6Op5d3Tc/fJBNZ8qff6FEWR1QUNr415/sFl1TzqMTRyPyamr7oqyY
xQXWw4ngowd6QCpdqO5UntR8FU510mLkLx4wN7Ybu4Sc2gb8tB++N3ucNYERhZwZ
EhqrrfF/U3ryvompuOQZtqxzbts0HtczkeZSTfcG+51SBzaYI2TyLxzbTFyCI+2e
VDdeybndW0Z5te5mHMCEwJeTSyGdCYv3Ijb8gCrZ0XC3cHD8KbUI0Pg8/LSVTy6H
Gu8v5t2irN3SDmHxVACfCaPLAPTWjynOscurjdp+C5kEVDYM6QbJgPUGSv+uYaH/
SQdCUKJ5+aOQgn9+2w4yC98nugc3OoXkxWTZpJoUqGSpgKSnHsC4IvFaFIRqXWLr
DJBIXu527Etc8/FAXK8O
=Owe4
-----END PGP SIGNATURE-----

--7vAdt9JsdkkzRPKN--


--===============8120023293018467928==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8120023293018467928==--
