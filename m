From: Sebastian Reichel <sre@kernel.org>
Subject: Re: Bunch of CRC errors in next with arm: move exports to definitions
Date: Tue, 18 Oct 2016 06:59:44 +0200
Message-ID: <20161018045944.o3j4odeuq4kj6gzx@earth>
References: <20160822162512.mptzbiaozx2fz42l@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0831127974035437910=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160822162512.mptzbiaozx2fz42l@atomide.com>
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
Cc: linux-omap@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


--===============0831127974035437910==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lmg3ytwrkfnxcogr"
Content-Disposition: inline


--lmg3ytwrkfnxcogr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 22, 2016 at 09:25:13AM -0700, Tony Lindgren wrote:
> Looks like starting with next-20160818 I'm now getting close to
> 800 lines of WARNINGs on ARM with omap2plus_defconfig while doing
> make modules:
>=20
> Building modules, stage 2.
>   MODPOST 399 modules
> WARNING: "__memzero" [sound/usb/snd-usbmidi-lib.ko] has no CRC!
> WARNING: "memset" [sound/usb/snd-usbmidi-lib.ko] has no CRC!
> WARNING: "memcpy" [sound/usb/snd-usbmidi-lib.ko] has no CRC!
> WARNING: "_set_bit" [sound/usb/snd-usbmidi-lib.ko] has no CRC!
> WARNING: "_test_and_set_bit" [sound/usb/snd-usbmidi-lib.ko] has no CRC!
> WARNING: "_clear_bit" [sound/usb/snd-usbmidi-lib.ko] has no CRC!
> WARNING: "__aeabi_uidivmod" [sound/usb/snd-usb-audio.ko] has no CRC!
> WARNING: "_test_and_clear_bit" [sound/usb/snd-usb-audio.ko] has no CRC!
> WARNING: "arm_copy_to_user" [sound/usb/snd-usb-audio.ko] has no CRC!
> WARNING: "__aeabi_uidiv" [sound/usb/snd-usb-audio.ko] has no CRC!
> ...
> WARNING: "memset" [crypto/drbg.ko] has no CRC!
> WARNING: "memcpy" [crypto/ctr.ko] has no CRC!
> WARNING: "memcpy" [crypto/cmac.ko] has no CRC!
> WARNING: "__memzero" [crypto/cmac.ko] has no CRC!
> WARNING: "memcpy" [crypto/ccm.ko] has no CRC!
> WARNING: "__memzero" [crypto/ccm.ko] has no CRC!

Any update on this one? I just updated my power-supply next branch
to v4.9-rc1 and now get almost 18000 CRC warnings for allmodconfig.
(I use arm-linux-gnueabihf-gcc (Debian 6.1.1-9) 6.1.1 20160705)

-- Sebastian

--lmg3ytwrkfnxcogr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYBaw9AAoJENju1/PIO/qarHIP/RA5//Lt82EwE0YH1otnYHCb
lXwXAkeBCBrqm0qp4jlIO6F1+ht1RnO7UIZslVOzQenPe7L7hIIzIPUXd45qJjhe
0ObOCDRN04vH89IlTF36sHjqeqCftrBWlGEyX350cNn4XbhXW6unkkx40m4EYmxD
Y8TSOvBpYD8mm1QELItwTXWSbiN6ZBwheb7YuDl9aBYUC+DLed4Lo94abRXqlvnp
tONiJWSzsvn7ePPif+fPIFZ9rNk4u+X+9N/ZK93JYP1GhO8GDX1B72fQzKXfre3h
8caYrif7qDdbuGYSKZ3EZ9iiVSOF482hoRbxSzeucziMrjkEaX36/fQRgclqr0o3
1P0kRMG3aDX6I84hhqpyBjFGYuAyFVxbIcXpC/uNLgyV3ionz/I7MJsG/aU0enSj
M7Wuo1/ooxmkDOV4t2qO/zDdP7UY3Pow9u/+UmSrjjiKIMMFubAHOq453x1SO7eC
XpLM16ay/00lIjGL5pJeUZJpSW+LoBrS6rkPUotygq9wFR+hmzVDWPIjKQN9Mk5U
d5ABBmKqBZlWUp3yizdcwRq4c83Gk7SDwClS2X3Dy32Vc9oGyh9VNqsPjnwdgYu/
tQ+p8NUtUmjuwHzVCiSqVywoa7cVmzBAAPUt1uEUy+rlQu6c4WrisdturBz3KxO4
IBKN2EdY9zy3xvc+QM+s
=y1e1
-----END PGP SIGNATURE-----

--lmg3ytwrkfnxcogr--


--===============0831127974035437910==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0831127974035437910==--
