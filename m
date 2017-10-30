From: Pavel Machek <pavel@ucw.cz>
Subject: n950: mmc fails to work, omap_hsmmc 480b4000.mmc: RX DMA channel
 request failed ? was Re: 4.13 (and probably all recent) kernels refuse to
 boot on one Nokia N950, work or another
Date: Mon, 30 Oct 2017 20:43:40 +0100
Message-ID: <20171030194340.GA9133@amd>
References: <20171025203459.GA22035@amd>
 <20171025212806.GA21504@atomide.com>
 <20171026091325.GA26929@amd>
 <20171026093115.4bc6ctxjx72ng7ld@earth>
 <20171026095734.GA10141@amd>
 <20171026120130.dicanunwcdmjntnb@earth>
 <20171027101905.GA4287@amd>
 <65ad0b63-cfae-f7ac-f916-32fd0c7c540a@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="FL5UXtIhxfXey3p5"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <65ad0b63-cfae-f7ac-f916-32fd0c7c540a@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, pali.rohar@gmail.com, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com
List-Id: linux-omap@vger.kernel.org


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I was able to setup nfsroot, and boot postmarketos (with root
read/only, but that's good enough for debugging).

Then I was (finally!) able to run dmesg, and that tells me:

[    0.816040] mousedev: PS/2 mouse device common for all mice
[    0.817657] input: TWL4030 Keypad as
/devices/platform/68000000.ocp/48070000.i2c/i2c-0/0-0048/48070000.i2c:twl@4=
8:keypad/input/input0
[    0.820800] i2c /dev entries driver
[    0.830261] omap_wdt: OMAP Watchdog Timer Rev 0x31: initial timeout
60 sec
[    0.836212] omap_hsmmc 480b4000.mmc: RX DMA channel request failed
[    0.840026] ledtrig-cpu: registered to indicate activity on CPUs
[    0.840789] omap-aes 480c5000.aes: OMAP AES hw accel rev: 2.6
[    0.840942] omap-aes 480c5000.aes: Unable to request in DMA channel
[    0.841644] omap-aes 480c5000.aes: will run requests pump with
realtime priority

Kernel 4.13-rc2.

I'm now trying:

+++ b/.config
-CONFIG_MMC_OMAP_HS=3Dy
+# CONFIG_MMC_OMAP_HS is not set

With that, error is gone, but so is MMC driver, so... not good.

Any ideas?

Best regards,
									Pavel  =20
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--FL5UXtIhxfXey3p5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAln3gOwACgkQMOfwapXb+vJEMQCfZ6vsfswVrA6hDvpJZs4m6Cbe
rHsAn1O7WjtazgdB30BwgsUaUtsQdr6O
=TUDa
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5--
