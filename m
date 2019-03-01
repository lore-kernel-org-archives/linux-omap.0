From: Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [PATCH] mfd: twl-core: disable irq while suspended
Date: Fri, 1 Mar 2019 07:45:11 +0100
Message-ID: <20190301074511.2d15aacc@kemnade.info>
References: <20190223114754.16286-1-andreas@kemnade.info>
        <20190223182323.GA39872@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/N40uUVtxTp0XE0kd_lnYTyP"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190223182323.GA39872@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: lee.jones@linaro.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Dave Gerlach <d-gerlach@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Keerthy <j-keerthy@ti.com>, Tero Kristo <t-kristo@ti.com>, letux-kernel@openphoenux.org
List-Id: linux-omap@vger.kernel.org

--Sig_/N40uUVtxTp0XE0kd_lnYTyP
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, 23 Feb 2019 10:23:23 -0800
Tony Lindgren <tony@atomide.com> wrote:

> * Andreas Kemnade <andreas@kemnade.info> [190223 11:48]:
> > Since commit
> > 6e2bd956936 ("i2c: omap: Use noirq system sleep pm ops to idle device f=
or suspend")
> > on gta04 we have handle_twl4030_pih() called in situations where pm_run=
time_get()
> > in i2c-omap.c returns -EACCES.
> > [   86.474365] Freezing remaining freezable tasks ... (elapsed 0.002 se=
conds) done.
> > [   86.485473] printk: Suspending console(s) (use no_console_suspend to=
 debug)
> > [   86.555572] Disabling non-boot CPUs ...
> > [   86.555664] Successfully put all powerdomains to target state
> > [   86.563720] twl: Read failed (mod 1, reg 0x01 count 1)
> > [   86.563751] twl4030: I2C error -13 reading PIH ISR
> > [   86.563812] twl: Read failed (mod 1, reg 0x01 count 1)
> > [   86.563812] twl4030: I2C error -13 reading PIH ISR
> > [   86.563873] twl: Read failed (mod 1, reg 0x01 count 1)
> > [   86.563903] twl4030: I2C error -13 reading PIH ISR
> >=20
> > This happens when we wakeup via something behing twl4030
> > (powerbutton or rtc alarm).
> > This goes on for minutes until the system is finally resumed.
> > Disable the irq on suspend and enable it on resume to avoid
> > having i2c access problems when the irq registers are checked. =20
>=20
> Thanks for fixing this, still works fine for me for rtcwake:
>=20
> Tested-by: Tony Lindgren <tony@atomide.com>
>=20
hmm, in which version we will see this regression fixed?

I consider this whole thing as a reminder to finally
improve my automated test facilities and finally add the suspend/power
consumption test scripts I have to it so I can catch such things earlier.

Regards,
Andreas

--Sig_/N40uUVtxTp0XE0kd_lnYTyP
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEPIWxmAFyOaBcwCpFl4jFM1s/ye8FAlx41PcACgkQl4jFM1s/
ye95PBAAjch8QEbm1Xjq6d2frVDCzM1NZTy4094hu42wz0Ku+VkXIZ5TlTBi+r//
FqDoodgDMPKus/QxKNsRzv5bVXZmRTt07QLWTmMih5HykoGvZAHdiVbH2wWMtMME
a4snuBjsCVnKilEceTn8Mghe5xMDbtSUPPM9pIQYegPR6iePzqCJX8l1KcAc6uQH
4SHCqtXOpP/cp07Y9MmqLWShvc3IWRdSo9qofqcDhZBhezCuHbJ33p2XKsY+21rM
6i0guXjNVYLgPWHGFQ6JUUE5PDMAgts2u1wcgOHL+Siae5KRxbaE0F4h8gzAi++1
gnRKfg+p4uZ7RjgbPrb18U2CDNDr9GbCvFH0clXyuW5NTLfxL6i6YYqF13bciztC
5QvN4E/vVmXfE+i8TrOjVxyOGCxlZWrFgj8pTS0kbjzURakbhyYywPz4YNMCQhP7
U7fYvYveNqCmof0KZ5JA+aSqo9uRVHbcY9OZ6SoBzQGg4MoMx1JDFdEshSsM2i0a
+mYxEo9zpngH7VeMWT3v00xCRMQi6MD2moKLWkHNP2vxAOkAAXf8O4tcuGl2ceFF
sI+V5gqTAzoZiS2TfeX1+sA2LNz13y7xrLTN0gFctWiiMGh4H5fc1XMvDF2j2qyw
dp9F6wGNgqM3aGPyiTv0L894cv7w6XkIg4b5OzTKtiAWsPzu1TY=
=iIvs
-----END PGP SIGNATURE-----

--Sig_/N40uUVtxTp0XE0kd_lnYTyP--
