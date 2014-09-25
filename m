From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v2 3/4] rtc: omap: Update Kconfig for OMAP RTC
Date: Thu, 25 Sep 2014 10:11:18 -0500
Message-ID: <20140925151117.GL28045@saruman>
References: <1411637529-18289-1-git-send-email-lokeshvutla@ti.com>
 <1411637529-18289-4-git-send-email-lokeshvutla@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7416677211900859528=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1411637529-18289-4-git-send-email-lokeshvutla@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lokesh Vutla <lokeshvutla@ti.com>
Cc: a.zummo@towertech.it, rtc-linux@googlegroups.com, devicetree@vger.kernel.org, tony@atomide.com, j-keerthy@ti.com, nsekhar@ti.com, balbi@ti.com, t-kristo@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============7416677211900859528==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eMP3JyRexyk9c0Bv"
Content-Disposition: inline

--eMP3JyRexyk9c0Bv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2014 at 03:02:08PM +0530, Lokesh Vutla wrote:
> From: Tero Kristo <t-kristo@ti.com>
>=20
> RTC is present in AM43xx and DRA7xx also. Updating the
> same in Kconfig.
>=20
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
> Changes since v1:
> 	- New patch
>  drivers/rtc/Kconfig    | 6 +++---
>  drivers/rtc/rtc-omap.c | 4 ++--
>  2 files changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index a168e96..b092e2f 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -971,11 +971,11 @@ config RTC_DRV_IMXDI
>  	   will be called "rtc-imxdi".
> =20
>  config RTC_DRV_OMAP
> -	tristate "TI OMAP1"
> -	depends on ARCH_OMAP15XX || ARCH_OMAP16XX || ARCH_OMAP730 || ARCH_DAVIN=
CI_DA8XX || SOC_AM33XX
> +	tristate "TI OMAP Real Time Clock"
> +	depends on ARCH_OMAP15XX || ARCH_OMAP16XX || ARCH_OMAP730 || ARCH_DAVIN=
CI_DA8XX || SOC_AM33XX || SOC_DRA7XX || SOC_AM43XX

do you mind if we just make this "depends on ARCH_OMAP || ARCH_DAVINCI" ? P=
retty much
every incarnation has this anyway.

--=20
balbi

--eMP3JyRexyk9c0Bv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUJDCVAAoJEIaOsuA1yqRExl0QAKQ61n+fkOnUUBnVYgJR465z
+/2lPE3hgjxGyxvVi7i08oSroIfQjKtS+6QCCxf0haKF/uXurWG+bniloSvQX82K
C9LnZwClwqqr4PwlCq8pXSJESfEappufgYusfDUs6e3nl8/KCI1gjA/ZrVLZhur6
r9L3HZNXFyz0b3yWeOAoPG+gaVpUILm4YpJ3OFH8DgP/6bHst4GIJtuFJk14PFKK
iN7+f7LLmfOma0wZlE8zuKn7YdKi+2EqJ4rYe2VBmN9saw0XPCEPrWNNgfGCDUwq
1fQkWx//ZUN4GIhzlL5uaHfeaZhycBAsOUWs+H+zhVotViNpCaRAnzus80U+BlsB
2/2w5ANuwswOFkMH9Vc17uWjq8foOIFpOhAIQa3k2slTvCW1546ednnMhLHwe0rv
/IMaCVhPYp6b7XEKvMmZcVnMtxoLrhOPvb+sVdLDngDjvLvN6WBZb5NjQU0gHPOh
JHQlg6NQV0mpTGkY6iKihit95rPY/sdV3ZBo8BhgGP7jzLHL34exmg+RMEf5xnjb
JP+Njkk3GQkiQJgTWVcWXkGpLKqnVzeALVpEMPR8FiIRyfrFkeWxQO/YDdZ7Banc
tWHJCLaDwe8t6+m+AUlDWkJNr5f5AouWgZj5skDwyev9W/HEvrWvn4h0H6OKGsAW
ni2+PYEav/1yAnTEkajk
=VQ/o
-----END PGP SIGNATURE-----

--eMP3JyRexyk9c0Bv--


--===============7416677211900859528==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7416677211900859528==--
