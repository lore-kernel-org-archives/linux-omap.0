From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 08/12] rtc: omap: restore irq state after reading TC
 registers
Date: Fri, 10 Oct 2014 13:02:31 -0500
Message-ID: <20141010180225.GT31348@saruman>
References: <1412881594-25678-1-git-send-email-johan@kernel.org>
 <1412881594-25678-9-git-send-email-johan@kernel.org>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3012344639635557727=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1412881594-25678-9-git-send-email-johan@kernel.org>
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

--===============3012344639635557727==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sT0SRK93LqpGW452"
Content-Disposition: inline

--sT0SRK93LqpGW452
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Oct 09, 2014 at 09:06:30PM +0200, Johan Hovold wrote:
> Make sure to restore local irq state when reading the timer/calendar
> (TC) registers, so that omap_rtc_read_time() can be called with
> interrupts disabled.
>=20
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/rtc/rtc-omap.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
> index 0ef016553a97..62e2e9a9887a 100644
> --- a/drivers/rtc/rtc-omap.c
> +++ b/drivers/rtc/rtc-omap.c
> @@ -239,8 +239,10 @@ static void bcd2tm(struct rtc_time *tm)
> =20
>  static int omap_rtc_read_time(struct device *dev, struct rtc_time *tm)
>  {
> +	unsigned long flags;
> +
>  	/* we don't report wday/yday/isdst ... */
> -	local_irq_disable();
> +	local_irq_save(flags);

you should really convert these to a real spin_lock_irq*(), that's
because local_irq* do not get re-written with RT patchset, so this
pretty much "breaks" RT.

--=20
balbi

--sT0SRK93LqpGW452
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUOB83AAoJEIaOsuA1yqRERkUQAKTvqxK7GEXdumizPMqfyH+P
GcuUz0eN86Mg/OkActLci7WDkorwlDvfZm8OiB7Fyk6EP6MKl2scHWguhFuTwFYK
pSR8tTomOQEvnR6gujcEUrUfl16fZ/UaHR2mnSxrdzgk/hmBLj6w56zQwhHtiPFy
taV7I3R+bvTnUTfjYK63w38mLLPVuNFSH+tvAWyvM8xQFsU3SmBwF8ZdFBC4bafk
zKo8RgKsNzw5KiPoBDmUBP9eERa8wSLBQCMd/oerodEiZUwnrxXbHWOB9o3b7/iE
Ms7xSNFHqfXYHOdV6liT0m7FgCyyIUVpgHe0khdDztJnx35sZJUIaU+AKt6/jY0z
T9oEs0nOL8cWkYSCA2taqni0C5P1kffAVVPvQw4Aticw580ubaE0AemKydb4xCM4
ioTq7q0c2veImw0akJOzNfEkkwfAzbhlHc7dn1hdQqXE/TQVZr5sbm941S0jGZZC
TXJ2q4wUHzAfGkFoCldV7roibdz/f/dRcjYXp72D+O6wVZ68bybCMRlpqxXqG9Aa
+5upKxZMKcx0U8RoSPjCDf7ZWjVV3wpmvhZuAcIaiGOvaN+OZEHcopSYitmrrQXL
MB3YtaSNoRijTw6RRNtzEn39pb082ozlF1cf/FNvBEaQ/x/aJM8p7wJdmaS6ipw+
ApZ1Lgn7okH1EPH0/1iN
=b6os
-----END PGP SIGNATURE-----

--sT0SRK93LqpGW452--


--===============3012344639635557727==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3012344639635557727==--
