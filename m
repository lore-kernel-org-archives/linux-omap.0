From: Sebastian Reichel <sre@debian.org>
Subject: N900 board code in 3.14
Date: Sat, 16 Nov 2013 12:05:11 +0000
Message-ID: <20131116120508.GA22335@earth.universe>
References: <1384562167-14725-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ring0.de ([91.143.88.219]:36189 "EHLO smtp.ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751040Ab3KPMFo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 16 Nov 2013 07:05:44 -0500
Content-Disposition: inline
In-Reply-To: <1384562167-14725-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Tony,

On Fri, Nov 15, 2013 at 04:36:02PM -0800, Tony Lindgren wrote:
> Here are few patches to deal with the mix of legacy platform data
> and device tree that we still need to do at least until DSS has
> device tree bindings. These patches should allow the remaining
> omap3 boards to be made device tree only so we can remove the
> board-*.c files.

Do you plan to remove the Nokia N900 board code in 3.14, too?

I see two big issues with that:
 a) Using DT boot the display is currently not working.
 b) I could not get the 32GB eMMC working. For me the chip is not found
    and I don't know how to debug it.

There are two reasons for broken display:

1. omap_mux_init_gpio(RX51_LCD_RESET_GPIO, OMAP_PIN_OUTPUT) fails.
   This can be fixed by simply not calling it in DT mode. DT data
   contains pinmux information for this from 3.13 onwards [0].
2. The spi panel driver is not probed.

I have a local hack to probe the panel driver via DT. I changed the
display node to look as follows:

&mcspi1 {
    /* ... tsc2005 ... */

    mipid@2 {
        compatible = "sony,acx565akm";
        spi-max-frequency = <6000000>;
        reg = <2>;
        vdds_sdi-supply = <&vaux1>;
        label = "lcd";
        reset-gpio = <&gpio3 26 GPIO_ACTIVE_HIGH>; /* 90 */
        ti,sdi-datapairs = <2>;
        ti,dss-source = "sdi.0";
        pinctrl-names = "default";
        pinctrl-0 = <&display_pins>;
    };
};

Then I changed the acx565akm panel driver to get data from DT
and the DSS to get SDI regulator from the panel. This is
obviously not the way to got, so I wonder how to proceed.
omapdss DT seems not to be ready for the next kernel releases.

My suggestion would be:
 1. Find a better workaround for omapdss to acquire the SDI
    regulator. My current hack is obviously not acceptable.
 2. Load the panel driver via DT as seen above and reference
    the omapdss interface with something like the above
    "ti,dss-source".

This is obviously not a stable DT interface, but that's also the case if
everything is done via platform quirks: An old DT file without any display
stuff in it would not work with a newer kernel without the quirks.

[0] https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=d1e6f51646f2bed16826fd8e4fc1b5f4188d086e

-- Sebastian

--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBCAAGBQJSh190AAoJENju1/PIO/qaWE8P/jZLCcmtbqBcFtv9FEbtnaRB
CozZa7QmhE9djRWJqPKqrR9eXQhjG3436ypzoatbgmwVcvqaJ2cSTa2kmegEHe0I
bP6Qh4mZeeoYJp27zJZtC59uxY/xABBWSsI6RtXVmKfKC6ps6XFCOO/cNj9EOQbl
F9rP6LCsRMbirwQM991IeGPV56uRKouW1D+A1gEv8yQfcT6r6siTnRWNgrCAxd/D
7FpttW0L2642kxuj9IkRdPEhHEyHZ87wsO+E/kAPr8o3yOo2DHXJxGn3m0OVi90V
ispsmhC/zgfv1D+QyFIbqtJ/fNzFSkf0W25fMq/8Ilc23ei4SSbY+gtPfdsppZv7
vYPtI5lQoX/XkIC3jIBPdFj1WqNuv6LEITjfQCxyLyub8GhbDHMOS9S4nZb8cmuS
6qf/5/Z5gn3sxhNh6blqOwl2xzqUFyVtGT+PvAx0DI/C+8IW5BUVzJAxoMVSLFYf
ISHuNiF+KVx+Jg8Wl0W1/JXtE5nKoYRVG+CWw8JdSFW2r0T2G49yneiW9mSwK2wo
R35kEe98MgJWXleoO/BR+oPm3z1A8/hol+eBXA9QTfGxelz3JKe2RLHY70IJsrCr
nEB11tGRz61XftIywQN32XXnJvJV+Q0JaQOQlnEEU3ErOaEDobINzsXAMSy/cp8f
2D1lHi1aX5/Y9MmCQk73
=sTk9
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--
