From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v3] rtc: omap: add support for pmic_power_en
Date: Mon, 27 Oct 2014 11:45:44 -0500
Message-ID: <20141027164544.GI14253@saruman>
References: <1413913086-12730-1-git-send-email-johan@kernel.org>
 <1414397368-26480-1-git-send-email-johan@kernel.org>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2715572116266837779=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1414397368-26480-1-git-send-email-johan@kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Johan Hovold <johan@kernel.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com, devicetree@vger.kernel.org, Tony Lindgren <tony@atomide.com>, j-keerthy@ti.com, nsekhar@ti.com, linux-kernel@vger.kernel.org, Felipe Balbi <balbi@ti.com>, t-kristo@ti.com, Lokesh Vutla <lokeshvutla@ti.com>, linux-arm-kernel@lists.infradead.org, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Andrew Morton <akpm@linux-foundation.org>, linux-omap@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
List-Id: linux-omap@vger.kernel.org

--===============2715572116266837779==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="o7gdRJTuwFmWapyH"
Content-Disposition: inline

--o7gdRJTuwFmWapyH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2014 at 09:09:28AM +0100, Johan Hovold wrote:
> Add new property "ti,system-power-controller" to register the RTC as a
> power-off handler.
>=20
> Some RTC IP revisions can control an external PMIC via the pmic_power_en
> pin, which can be configured to transition to OFF on ALARM2 events and
> back to ON on subsequent ALARM (wakealarm) events.
>=20
> This is based on earlier work by Colin Foe-Parker and AnilKumar Ch. [1]
>=20
> [1] https://www.mail-archive.com/linux-omap@vger.kernel.org/msg82127.html
>=20
> Tested-by: Felipe Balbi <balbi@ti.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>=20
> Changes since v2:
>  - add two-second delay to allow alarm to trigger before returning
>=20
> Andrew, can you replace just this patch in the series that you already
> have in your tree, or do you prefer I resend the whole series (with
> Felipe's Tested-by tags)?
>=20
> Thanks,
> Johan
>=20
>=20
>  Documentation/devicetree/bindings/rtc/rtc-omap.txt |  9 +-
>  drivers/rtc/rtc-omap.c                             | 95 ++++++++++++++++=
++++++
>  2 files changed, 103 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/rtc/rtc-omap.txt b/Documen=
tation/devicetree/bindings/rtc/rtc-omap.txt
> index 5a0f02d34d95..750efd40c72e 100644
> --- a/Documentation/devicetree/bindings/rtc/rtc-omap.txt
> +++ b/Documentation/devicetree/bindings/rtc/rtc-omap.txt
> @@ -5,11 +5,17 @@ Required properties:
>  	- "ti,da830-rtc"  - for RTC IP used similar to that on DA8xx SoC family.
>  	- "ti,am3352-rtc" - for RTC IP used similar to that on AM335x SoC famil=
y.
>  			    This RTC IP has special WAKE-EN Register to enable
> -			    Wakeup generation for event Alarm.
> +			    Wakeup generation for event Alarm. It can also be
> +			    used to control an external PMIC via the
> +			    pmic_power_en pin.
>  - reg: Address range of rtc register set
>  - interrupts: rtc timer, alarm interrupts in order
>  - interrupt-parent: phandle for the interrupt controller
> =20
> +Optional properties:
> +- ti,system-power-controller: whether the rtc is controlling the system =
power

isn't there a discussion going on to drop the vendor prefix ? I wonder
if we should just use the final binding to avoid supporting this for
rtc-omap too. OTOH, all of that can be hidden under
of_is_system_power_controller() itself.

--=20
balbi

--o7gdRJTuwFmWapyH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUTna4AAoJEIaOsuA1yqREgwEP/1K5u2SMMrSwStmF5zXsQFcU
hCY7y0v3LxtgZYeBJpIQH4cZcxi3VPlO/9+pRL49JQ1eYZoBcDgKVNwYJHpKHP3v
EZM9QzfBLhXjyCi/vAIRj/A9MPGsa/YQFViLiLJrfI98SqOvJSk5/4C0MC0N0Tbj
AEFMCVxZw+98xJseQhNrsgDg6VGoOsnuIyeiX4erei6jn9mHvMSS+9O3EaBta7Aw
dvZSRxqSKqXeceP7uv4kCl1uECJIXb+NYlb+999QhPgJxKEsYMf/kVfqkTA4+4PQ
XG2ue0ZcKck9CQIRrbE+RHCnlA+0RqGNmu2L7HINu7+QNLdbg5LuPynkW/lIVh4Q
5v7ER1Q6jrBk2jMaALnvvu5XVJbcBd55VejeaxM7CO4aLZJLCLvX0hVw7yUXRo9s
UwsAeB2y8KhhjDwRbWaMNadi84VLqgFhigq5rxS7pcxGG6voQP4eu08o9olwGRYB
iXl8AlLj7TsfLS/sGboglrTeXXQmfmyW/mHqk1/cwvOnUEFmv3v5TKh4VBLt4Tos
kYMU62NxoDHN5jd2mqViXmy0IIs42RXbGdfalclsTPBTGWL355M1i4zks5SqJAR6
BVx+IEX3dVrCroqImctdS6RKGYqCglhoRZdIcfMp411wQJpbDpmhxEsVK5RVsuFP
C83DS/Cf3678jPDKawiy
=+xdL
-----END PGP SIGNATURE-----

--o7gdRJTuwFmWapyH--


--===============2715572116266837779==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2715572116266837779==--
