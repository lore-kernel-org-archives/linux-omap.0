From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv8 00/23]I2C big cleanup
Date: Thu, 13 Sep 2012 09:36:59 +0300
Message-ID: <20120913063657.GH6504@arwen.pp.htv.fi>
References: <1347447496-16793-1-git-send-email-shubhrajyoti@ti.com>
 <874nn2vpv9.fsf@deeprootsystems.com>
 <50517780.2080002@ti.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rmUrFcWP4LYae1gV"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <50517780.2080002-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Cc: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--rmUrFcWP4LYae1gV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Sep 13, 2012 at 11:34:48AM +0530, Shubhrajyoti wrote:
> On Thursday 13 September 2012 03:57 AM, Kevin Hilman wrote:
> > Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org> writes:
> >
> > [...]
> >
> >> This is the cleanup only series.
> >>  =20
> >> Tested on omap4sdp and 3430sdp.
> > It would be extremely helpful if you would describe how this was tested.
> > And for me, it would be a source of extreme joy if you described any PM
> > testing.
> >
> > I gave this some additional PM testing on 3430/n900, 3530/Overo,
> > 3730/OveroSTORM, 3730/Beagle-xM and 4430/Panda.
> >
> > I tested v3.6-rc5 which passed all PM tests and then added this series
> > (by merging the i2c-embedded/i2c-next branch.)  PM tests then fail.
> >
> > At least on 3530/Overo and 3730/Overo, CORE no longer hits retenion (or
> > off) during idle. =20
> >
> > The easy way to notice this is to see that even when no i2c transactions
> > are happening, the runtime PM status for omap_i2c.1 is remains 'active':
> >
> > # cat omap_i2c.*/power/runtime_status=20
> > active
> > suspended
> >
> > Of course that means that clocks are never gated during idle, and CORE
> > will never hit retention.
> >
> > I noticed it because my PM tests detected that the CORE powerdomain was
> > not transitioning to retention (or off) during idle.
> >
> > To reproduce, simply enable UART timeouts so CORE will hit retention:
> >
> > echo 3000 > /sys/devices/platform/omap_uart.0/power/autosuspend_delay_ms
> > echo 3000 > /sys/devices/platform/omap_uart.1/power/autosuspend_delay_ms
> > echo 3000 > /sys/devices/platform/omap_uart.2/power/autosuspend_delay_ms
> > echo 3000 > /sys/devices/platform/omap_uart.3/power/autosuspend_delay_ms
> >
> > and check the core_pwrm state counters:
> >
> > cat /debug/pm_debug/count
> >
> > wait > 3 seconds for the UART autosuspend timers to kick in.  At this
> > point, CORE should be transitioning to retenion in idle (determined by
> > noticing that the RET counter for core_pwrdm is increasing.)
> >
> > With $SUBJECT series applied, you'll notice that CORE is not
> > transitioning.
> However I do not see the issue,let me know if I missed something see belo=
w.
>=20
> On my 3430sdp
>=20
> /sys/bus/platform/devices # cat omap_i2c.*/power/runtime_status
> suspended
> suspended
> suspended
> /sys/bus/platform/devices #
> /sys/bus/platform/devices # cat omap_i2c.*/power/autosuspend_delay_ms
> 1000
> 1000
> 1000

I just revived my very, very old 3503 overo and while i2c isn't active,
I don't see transitions on core power domain:

# mount -t proc none /proc
# mount -t sysfs none /sys
# mount -t debugfs none /debug
# echo 3000 > /sys/devices/platform/omap_uart.0/power/autosuspend_delay_ms
# echo 3000 > /sys/devices/platform/omap_uart.1/power/autosuspend_delay_ms
# echo 3000 > /sys/devices/platform/omap_uart.2/power/autosuspend_delay_ms
# cat /sys/devices/platform/omap_i2c.*/power/runtime_status
suspended
suspended
# grep ^core_pwrdm /debug/pm_debug/count && sleep 5 && grep ^core_pwrdm /de=
bug/pm_debug/count
core_pwrdm (ON),OFF:0,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0,R=
ET-MEMBANK2-OFF:0
core_pwrdm (ON),OFF:0,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0,R=
ET-MEMBANK2-OFF:0

Weird, but I don't think i2c is to blame here (unless I'm missing
something). I can see that after i2c transfers, my suspend function is
called and right after that i2c is suspended:

# cat /sys/class/regulator/regulator.*/status && sleep 1 && cat /sys/device=
s/platform/omap_i2c.*/power/runtime_status
[  411.072998] omap_i2c omap_i2c.1: omap_i2c_runtime_resume
normal
normal
normal
[  412.075347] omap_i2c omap_i2c.1: omap_i2c_runtime_suspend
suspended
suspended

What am I missing to get any pm transitions to happen with my overo ?

# cat  /debug/pm_debug/count && sleep 5 && cat /debug/pm_debug/count
usbhost_pwrdm (ON),OFF:0,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
sgx_pwrdm (OFF),OFF:1,RET:0,INA:0,ON:0,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
core_pwrdm (ON),OFF:0,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0,R=
ET-MEMBANK2-OFF:0
per_pwrdm (ON),OFF:0,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
dss_pwrdm (ON),OFF:0,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
cam_pwrdm (RET),OFF:0,RET:1,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
neon_pwrdm (ON),OFF:0,RET:2379,INA:0,ON:2380,RET-LOGIC-OFF:0
mpu_pwrdm (ON),OFF:0,RET:2377,INA:0,ON:2378,RET-LOGIC-OFF:0,RET-MEMBANK1-OF=
F:0
iva2_pwrdm (ON),OFF:0,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0,R=
ET-MEMBANK2-OFF:0,RET-MEMBANK3-OFF:0,RET-MEMBANK4-OFF:0
usbhost_clkdm->usbhost_pwrdm (1)
sgx_clkdm->sgx_pwrdm (0)
per_clkdm->per_pwrdm (19)
cam_clkdm->cam_pwrdm (0)
dss_clkdm->dss_pwrdm (1)
d2d_clkdm->core_pwrdm (0)
iva2_clkdm->iva2_pwrdm (0)
mpu_clkdm->mpu_pwrdm (0)
core_l4_clkdm->core_pwrdm (21)
core_l3_clkdm->core_pwrdm (4)
neon_clkdm->neon_pwrdm (0)
usbhost_pwrdm (ON),OFF:0,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
sgx_pwrdm (OFF),OFF:1,RET:0,INA:0,ON:0,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
core_pwrdm (ON),OFF:0,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0,R=
ET-MEMBANK2-OFF:0
per_pwrdm (ON),OFF:0,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
dss_pwrdm (ON),OFF:0,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
cam_pwrdm (RET),OFF:0,RET:1,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
neon_pwrdm (ON),OFF:0,RET:2442,INA:0,ON:2443,RET-LOGIC-OFF:0
mpu_pwrdm (ON),OFF:0,RET:2440,INA:0,ON:2441,RET-LOGIC-OFF:0,RET-MEMBANK1-OF=
F:0
iva2_pwrdm (ON),OFF:0,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0,R=
ET-MEMBANK2-OFF:0,RET-MEMBANK3-OFF:0,RET-MEMBANK4-OFF:0
usbhost_clkdm->usbhost_pwrdm (1)
sgx_clkdm->sgx_pwrdm (0)
per_clkdm->per_pwrdm (19)
cam_clkdm->cam_pwrdm (0)
dss_clkdm->dss_pwrdm (1)
d2d_clkdm->core_pwrdm (0)
iva2_clkdm->iva2_pwrdm (0)
mpu_clkdm->mpu_pwrdm (0)
core_l4_clkdm->core_pwrdm (21)
core_l3_clkdm->core_pwrdm (4)
neon_clkdm->neon_pwrdm (0)

--=20
balbi

--rmUrFcWP4LYae1gV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQUX8JAAoJEIaOsuA1yqRERk4QAJ6EtWj6/5zNYu7TjDrg9I0H
oZTUyz+KJ0XnN2o+PQnTLtHuTIM58TP+kFItA80pXRui+fqoZ0YXcmMBcBaH3zNg
kmgd6k5DMwFUT/J3kVWZAJeoCBvncz9Arra0WjrIlTBkdswlN+2J6D+vrInz6bm2
n4j63Oj7pqoBttL8ATFGbiIKvBLz+n0calEnmS1SJENqsUF5/L1acfAq34go6/gM
KlZmCK7aIdwEFMKu/wrls06jGhf6EUvJmPnZLUNb29Vu0CJYXKLQ3eT9+V+q1TIU
B4qnpzditJWqSaWxsxgUz4RcABdGEmHlrtTGMMMrXbDuLs3M36hyR6ze4s8oA7pN
TSWOTOUgBFJbHpjdmbABlHKwbGMC09oLzG/nUyH1Pd3dOiaHKB6ouPD6QMiEp6fP
q6g3nAGQm7jF0UgiyKcEMgNCRIcqVWKvzSlrhuYYL4/xWmC4xNsc/iD21wOHBGSp
6SmuZOZOh56BxbbFtELEt2xf6BNTRxQJBz9ocq+QV2C6WH95BkLE+sbDaZabVD59
t+Ic3+rUjf/2ms9OCVYzXSxDQ5psgN6gY4Gnot7AwswFKCbU7GU8BPgGxe5MY6wn
ulTVr++d8iDSyTt1qaA17b9qnwhAzVR/w+feK+XMCFAxk1N4Pw9nX4KjZXhQ1yAu
OaaTEB68ohCAPqUOgjWW
=/4kA
-----END PGP SIGNATURE-----

--rmUrFcWP4LYae1gV--
