From: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Subject: Re: [PATCH v4 00/11] Support for AM33xx PWM Subsystem
Date: Thu, 22 Nov 2012 22:16:16 +0100
Message-ID: <20121122211616.GK16716@avionic-0098.adnet.avionic-design.de>
References: <1353503469-18634-1-git-send-email-avinashphilip@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7484964914938128951=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1353503469-18634-1-git-send-email-avinashphilip-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: "Philip, Avinash" <avinashphilip-l0cyMroinI0@public.gmane.org>
Cc: linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gururaja.hebbar-l0cyMroinI0@public.gmane.org, vaibhav.bedia-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--===============7484964914938128951==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qo8f1a4rgWw9S/zY"
Content-Disposition: inline


--Qo8f1a4rgWw9S/zY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 21, 2012 at 06:40:57PM +0530, Philip, Avinash wrote:
> In AM33xx PWM sub modules like ECAP, EHRPWM & EQEP are  integrated to
> PWM subsystem. All these submodules shares the resources (clock) & has
> a clock gating register in PWM Subsystem. This patch series creates a
> parent PWM Subsystem driver to handle access synchronization of shared
> resources & clock gating from PWM Subsystem configuration space.
> Also Device tree nodes populated to support parent child relation
> between PWMSS, ECAP & EHRPWM submodules.
> In addition EHRPWM module requires explicit clock gating from control
> module & is handled by patch #2 & 8.
>=20
> As suggested by  Thierry for handling clock gating for PWM submodules
> should handle with a global function. This requires config space
> handling done independent from driver and is done at parent driver.
>=20
> So the parent<->child relation adopted to handle
> 1. pm runtime synchronization
> 2. PWM subsystem common config space clock gating for PWM submodules.
>=20
> Patches supports
> - Driver support for parent child relation handled patch #1
> - Optional EHRPWM tb clock in patch #2
> - Parent child in HWMOD handled at patch #3
> - Device tree binding support handled in patch #4, 6 &8
> - pinctrl support in patch #5 & 7.
> - DT node populated in patch #9 ,10 & 11.
>=20
> This patch series based on omap_dt/for_3.8/dts_part2 and tested
> on am335x-evm & am335x-evmsk.
>=20
> It depends on [1]
>=20
> 1. https://lkml.org/lkml/2012/11/21/70
> pwm: Device tree support for PWM polarity
>=20
> Changes since v3:
> 	- Rebased on top of omap_dt/for_3.8/dts_part2
> 	- Add pwm backlight for am335xevm_sk
> 	- Moved tipwmss.h to pwm-tipwmss.h
>=20
> Philip, Avinash (11):
>   PWMSS: Add PWM Subsystem driver for parent<->child relationship
>   ARM: am33xx: clk: Add optional clock for EHRPWM
>   ARM: OMAP: AM33xx hwmod: Add parent-child relationship for PWM
>     subsystem
>   pwm: pwm-tiecap: Add device-tree binding support for APWM driver
>   pwm: pwm-tiecap: pinctrl support
>   pwm: pwm-tiehrpwm: Add device-tree binding support for EHRPWM driver
>   pwm: pwm-tiehrpwm: pinctrl support
>   pwm: pwm-tiehrpwm: Adding TBCLK gating support.
>   ARM: dts: AM33XX: Add PWMSS device tree nodes
>   ARM: dts: AM33XX: Add PWM backlight DT data to am335x-evm
>   ARM: dts: AM33XX: Add PWM backlight DT data to am335x-evmsk

Hi,

So how do you want to get this merged? Should I take patches 1, 4, 5, 6,
7 and 8 while the rest go through some ARM tree? Can we still merge this
for 3.8? The patches don't seem to have build dependencies on each other
but how about runtime dependencies?

Thierry

--Qo8f1a4rgWw9S/zY
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQrpYgAAoJEN0jrNd/PrOhx04QALld4zdyK4uzCc10EXZBF8Qy
s+eYwWUVMnV8FMb0xi3rU9PrKq51CPydX+JhjFGDMRjAYlnIOdjwvOX60OSfsE/K
z0LVCghVsivnGP76PFjeYt9fHd+dmAFEWoTQo6R4BHLDhogt+OwwQvkdK5DZwbU+
X+XWPQ13pTkio4Y7IXHCGAdBLazNw/L0cfmwJMtbMfia4HI3HSgmu5YZxGDguUs4
VqqaS4i/Qt3eIw3Q8Yf2Xkrp/8HZkt8qza4zfwsOdU3El8BkiWAby9keHGJsdSXH
KS7W2jClSxAE4+R/zimz6Vk1MUyoHXMJ73vgc4C3N2caYcIrPYzn3LjcCo9fIifs
80hAM6FMdg4JkAYxE48OlTFEmm6Nx22GYQFxcxI9BxmKkecRH9twTUa/h+sdGAUU
fO2bWH2plaYTIdDQzKpB8OAIz12Bofr5ls2Ckm8WlC35hNn30vQDiDYrUuR1isS4
hrf/BIq99lePmNoXLA5gnBM+rWMBi0eshLIxSenVrrtZPWV5gPtdi5BmtG7GFwoa
byCokYRSiKcufa9H03tiscDnWTYWpVkBID8C8N054XOxMPPk2sZ6wQwWlZr8rNEN
VS+myT9lx7LfzsFdM32y/0NKfYQ3AV73EZ36zfXdctMg63rPc5X2znWGCHG4bGBa
3yzGmffBKYCgD9X8tiXZ
=oJFt
-----END PGP SIGNATURE-----

--Qo8f1a4rgWw9S/zY--

--===============7484964914938128951==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============7484964914938128951==--
