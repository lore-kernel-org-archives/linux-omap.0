From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 10/12] rtc: omap: enable wake-up from power off
Date: Fri, 10 Oct 2014 13:08:03 -0500
Message-ID: <20141010180755.GW31348@saruman>
References: <1412881594-25678-1-git-send-email-johan@kernel.org>
 <1412881594-25678-11-git-send-email-johan@kernel.org>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4040412715306861939=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1412881594-25678-11-git-send-email-johan@kernel.org>
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
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com, Colin Foe-Parker <colin.foeparker@logicpd.com>, devicetree@vger.kernel.org, Tony Lindgren <tony@atomide.com>, j-keerthy@ti.com, nsekhar@ti.com, linux-kernel@vger.kernel.org, Felipe Balbi <balbi@ti.com>, t-kristo@ti.com, Lokesh Vutla <lokeshvutla@ti.com>, linux-arm-kernel@lists.infradead.org, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Andrew Morton <akpm@linux-foundation.org>, linux-omap@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
List-Id: linux-omap@vger.kernel.org

--===============4040412715306861939==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k8ylJtLa18RSEDYA"
Content-Disposition: inline

--k8ylJtLa18RSEDYA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 09, 2014 at 09:06:32PM +0200, Johan Hovold wrote:
> The ALARM interrupt must not be disabled during shutdown in order to be
> able to power up the system using an RTC alarm.
>=20
> Signed-off-by: Johan Hovold <johan@kernel.org>

nicely done!

Reviewed-by: Felipe Balbi <balbi@ti.com>

> ---
>  drivers/rtc/rtc-omap.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
> index b0319864dd42..8836c58901b5 100644
> --- a/drivers/rtc/rtc-omap.c
> +++ b/drivers/rtc/rtc-omap.c
> @@ -670,7 +670,15 @@ static SIMPLE_DEV_PM_OPS(omap_rtc_pm_ops, omap_rtc_s=
uspend, omap_rtc_resume);
> =20
>  static void omap_rtc_shutdown(struct platform_device *pdev)
>  {
> -	rtc_write(0, OMAP_RTC_INTERRUPTS_REG);
> +	u8 mask;
> +
> +	/*
> +	 * Keep the ALARM interrupt enabled to allow the system to power up on
> +	 * alarm events.
> +	 */
> +	mask =3D rtc_read(OMAP_RTC_INTERRUPTS_REG);
> +	mask &=3D OMAP_RTC_INTERRUPTS_IT_ALARM;
> +	rtc_write(mask, OMAP_RTC_INTERRUPTS_REG);
>  }
> =20
>  MODULE_ALIAS("platform:omap_rtc");
> --=20
> 2.0.4
>=20

--=20
balbi

--k8ylJtLa18RSEDYA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUOCCDAAoJEIaOsuA1yqREMHsP/RTjlZtXHYw3R66qwnWZpGFr
YhgO8lTUZ4Y2CbujqzWR7PU8ChlIyKY/+rEoNfeULywajHrecKcEK4LtyfNJU5mn
9n+IWXTOloRWRDtLq/GK0aHp/wUXpmCGo/xPUVrT2ComwRuPfMq+rz5V0B9arsB1
m/NRxEfpMLrITgdbV3DiW8+WBtGkPfvegMFQ3brrdKUvsxH34IrQKHEmNhvi1fQE
EdlvEmV479r62K/MFNeCDELSOMm7WMmQiOhp48aTnjcINdMq3ua5kbEy66F7DkPK
FwvS1DsuDiZRS2sozvPdrX8isiG3FfOY+rHk+z9al8MZbTJyJ0KHNQHWyXEyKF9F
Oyk2d0RgSSK/AgZu3ZUqpmaFS4Ie7FsGAzUdUkJrhm8uQsg/EU/wlUtat21PFeVt
Yxl8e7VoFtICySvzxWi9xTA4sx4exAlHbef5J86ih2snnS5TVU5liRTnYMSMwxP6
aBpOxLcpcgacpIjHjX+zAOTeWBZvCTn/0Ir29Ql4YVq05G6WNlb/jiUzRjdsRMeI
1qXlrYms+mLbinZ9jc0HRRkFOFcX1dkPqlnGMc2AQeFkJFegnoylmwGKLbLnyD3K
F7TbcqnVfCCVXErXWTnDSCHD39qAFxacfij8KGWK360wwdVYj0Z6mytVqC0Joc4S
LcBrtW6XfQKars2FNNB8
=0nSB
-----END PGP SIGNATURE-----

--k8ylJtLa18RSEDYA--


--===============4040412715306861939==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4040412715306861939==--
