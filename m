From: Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [PATCH 2/3] bus: ti-sysc: Fix timer handling with drop
 pm_runtime_irq_safe()
Date: Sat, 26 Jan 2019 19:41:45 +0100
Message-ID: <20190126194145.2b3484da@aktux>
References: <20190122175717.13428-1-tony@atomide.com>
 <20190122175717.13428-3-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3335383024783922150=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190122175717.13428-3-tony@atomide.com>
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
Cc: Ladislav Michl <ladis@linux-mips.org>, "H
 . Nikolaus Schaller" <hns@goldelico.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Tero Kristo <t-kristo@ti.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Pavel Machek <pavel@ucw.cz>, Keerthy <j-keerthy@ti.com>, Thomas Gleixner <tglx@linutronix.de>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============3335383024783922150==
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/2RvUWKBcFzdZgkVQ.ToJv5/"; protocol="application/pgp-signature"

--Sig_/2RvUWKBcFzdZgkVQ.ToJv5/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 22 Jan 2019 09:57:16 -0800
Tony Lindgren <tony@atomide.com> wrote:

> Commit 84badc5ec5fc ("ARM: dts: omap4: Move l4 child devices to probe
> them with ti-sysc") started producing a warning for pwm-omap-dmtimer:
>=20
> WARNING: CPU: 0 PID: 77 at drivers/bus/omap_l3_noc.c:147
> l3_interrupt_handler+0x2f8/0x388
> 44000000.ocp:L3 Custom Error: MASTER MPU TARGET L4PER2 (Idle):
> Data Access in Supervisor mode during Functional access
> ...
> __pm_runtime_idle
> omap_dm_timer_disable
> pwm_omap_dmtimer_start
> pwm_omap_dmtimer_enable
> pwm_apply_state
> pwm_vibrator_start
> pwm_vibrator_play_work
>=20
> This is because the timer that pwm-omap-dmtimer is using is now being
> probed with ti-sysc interconnect target module instead of omap_device
> and the ti-sysc quirk for SYSC_QUIRK_LEGACY_IDLE is not fully
> compatible with what omap_device has been doing.
>=20
> We could fix this by reverting the timer changes and have the timer
> probe again with omap_device. Or we could add more quirk handling to
> ti-sysc driver. But as these options don't work nicely as longer term
> solutions, let's just make timers probe with ti-sysc without any
> quirks.
>=20
> To do this, all we need to do is remove quirks for timers for ti-sysc,
> and drop the bogus pm_runtime_irq_safe() flag for timer-ti-dm.
>=20
> We should not use pm_runtime_irq_safe() anyways for drivers as it will
> take a permanent use count on the parent device blocking the parent
> devices from idling and has been forcing ti-sysc driver to use a
> quirk flag.
>=20
> Note that we will move the timer data to DEBUG section later on in
> clean-up patches.
>=20
together with 1/3 it fixes things on pyra.

Tested-By: Andreas Kemnade <andreas@kemnade.info>

--Sig_/2RvUWKBcFzdZgkVQ.ToJv5/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE7sDbhY5mwNpwYgrAfb1qx03ikyQFAlxMqekACgkQfb1qx03i
kySStxAAldk/NK4MDi3dXbEZDaUuskh8JlfN1iOQ1Bg2RzoBFN409hhj831VVcAy
6pVXmQl101j9tPEVWHEKg1yBfhWP/RpXe5ozMFTirZ6VYMqFn8xQhjqDcdQO1pix
ZvaR3uO0WGJ0iuRsD9ktllZKzSL6QSjv/19hJ06zxm7Ssvgw8dyyBI49Eb0i+eRW
EqKkHTmxwMkV/yP8IMLm9u2e0yd1gwZPSkCXzFmZisw0+F3T532lqbFQyoMpsBfd
pJCZN58bBmYbOlkuRM23+TZmCfFayhjJhMBjmTRsb76z32wTMGbd0tMhLKe2i/N8
9RwV8+zOidaRe6fZOSwVn9K/RCHkywr3ENuIBgqQhHSXkv/m6g18qlny7wU/wybj
HTCpfJlobco6YqhEAijk+HVCtcg5zmtn0f2BmP4NMU2j86mq5XFyGjyJl6J5qwNZ
/8kuN0/RmY04uRO3rFuQQuZXxho5mwx1ijohfWBczwGtdPGGuHgkls2XI24vwGdZ
tr/dQ/SSVP3toDMNyX8bbw+9PWkeMyu15Mwm4Ps4GV0XDks+5RLB59jfvvMVrmuR
uhYCsmR4roUF9VO5u3l0RghgnzX6GAu2pQbSKDE0VJUlE1dAaRZ2zs8jebRU26Ij
nyrrA2eOrTKGOXVYe9yjo9CyoMi+LDTei6ZHI9JulhhJsT6Imw4=
=c0sf
-----END PGP SIGNATURE-----

--Sig_/2RvUWKBcFzdZgkVQ.ToJv5/--


--===============3335383024783922150==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3335383024783922150==--
