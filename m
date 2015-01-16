From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/1] gpio: omap: Fix bad device access with setup_irq()
Date: Fri, 16 Jan 2015 16:55:50 -0600
Message-ID: <20150116225550.GA6254@saruman>
References: <1421448650-15904-1-git-send-email-tony@atomide.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1421448650-15904-1-git-send-email-tony@atomide.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>, Javier Martinez Canillas <javier@dowhile0.org>, Kevin Hilman <khilman@kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Santosh Shilimkar <ssantosh@kernel.org>
List-Id: linux-omap@vger.kernel.org

--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 16, 2015 at 02:50:50PM -0800, Tony Lindgren wrote:
> Similar to omap_gpio_irq_type() let's make sure that the GPIO
> is usable as an interrupt if the platform init code did not
> call gpio_request(). Otherwise we can get invalid device access
> after setup_irq():
>=20
> WARNING: CPU: 0 PID: 1 at drivers/bus/omap_l3_noc.c:147 l3_interrupt_hand=
ler+0x214/0x340()
> 44000000.ocp:L3 Custom Error: MASTER MPU TARGET L4CFG (Idle): Data Access=
 in Supervisor mode during Functional access
> ...
> [<c05f21e4>] (__irq_svc) from [<c05f1974>] (_raw_spin_unlock_irqrestore+0=
x34/0x44)
> [<c05f1974>] (_raw_spin_unlock_irqrestore) from [<c00914a8>] (__setup_irq=
+0x244/0x530)
> [<c00914a8>] (__setup_irq) from [<c00917d4>] (setup_irq+0x40/0x8c)
> [<c00917d4>] (setup_irq) from [<c0039c8c>] (omap_system_dma_probe+0x1d4/0=
x2b4)
> [<c0039c8c>] (omap_system_dma_probe) from [<c03b2200>] (platform_drv_prob=
e+0x44/0xa4)
> ...
>=20
> We can fix this the same way omap_gpio_irq_type() is handling it.
>=20
> Note that the long term solution is to change the gpio-omap driver
> to handle the banks as separate driver instances. This will allow
> us to rely on just runtime PM for tracking the bank specific state.
>=20
> Reported-by: Russell King <rmk+kernel@arm.linux.org.uk>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Javier Martinez Canillas <javier@dowhile0.org>
> Cc: Kevin Hilman <khilman@kernel.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
> Cc: Santosh Shilimkar <ssantosh@kernel.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Tony sent me this patch privately for testing, I've boot tested with
AM437x IDK, AM437x SK and BBB with CONFIG_PREEMPT.

Here are the logs:

http://hastebin.com/vabenibema
http://hastebin.com/weyukexuzi
http://hastebin.com/siceyiwite

Tested-by: Felipe Balbi <balbi@ti.com>

--=20
balbi

--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUuZb2AAoJEIaOsuA1yqRE+uQP/AvsERtxskpWBOqlBGfVJFxk
86tHGQj+U6t+xKwUn7hPrKJL4T7eszMxcp/xVhFWGtm0uR+pzb9G2cGh6TicYRJi
s1RulF0yCrfLATWNfe8SMmM3TMm/IcTYKL7kBLNTXRV81Ye1fCvaZ4A4LVPn3Jsd
QiaFbEtCP3b9Yo99rVBJHveOjRChoMvKsib1cWsEZFQWz09hnJWOuoD+cINX9egW
6Xy8aoEt/5eZrs4rRmoFnKE6XFC1du4dzUc6ayjTMcIo3kTRQF07Sq1/PsZvcRb9
9EeNgd09cVYqGli+y52Yzk1k3Wdk0AktHPmP1rbL1RBydhreaBmvdn3iT7M9lZGY
XII5sXxlekuG7Uq8CJcYHuOUXbKlV2dNOrB1/4CULtAgEFSXadJ3pkfDFVDw6pXg
vX/V6XCzZtssY75zT1Q7fs1w1+w5mJGJa0JDCMRIKkMzLf+zBAfTf45Rzkua9+7E
0jXxkoVTeuXviWhSb7sqNV5Sd5uhNHDuMjgcIbNSgjiOwI90TbUgmkqVt4jeP9Al
0BxQyR2B7upXELFZGue8SM/8QXFvfjOxd63/j1hApHo8hf+XNWTD+7g81kb6sbR+
8Rzhshm+XlLrbK1uLEH6+4hkM9Dno89J0msJJFyng2dKVEi2UsxPWho//uI0Q+hx
QmDthGe+aNDRSvM27RKu
=hEGI
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--
