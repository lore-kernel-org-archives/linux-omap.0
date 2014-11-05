From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: N900 modem support in 3.18-rc1
Date: Wed, 5 Nov 2014 22:06:04 +0100
Message-ID: <201411052206.05379@pali>
References: <20141104205117.GA17606@amd> <201411052137.31452@pali>
 <20141105203918.GA29199@amd>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7736981319846610281=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20141105203918.GA29199@amd>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Pavel Machek <pavel@ucw.cz>
Cc: khilman@kernel.org, tony@atomide.com, aaro.koskinen@iki.fi, Sebastian Reichel <sre@kernel.org>, kernel list <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org, freemangordon@abv.bg, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

--===============7736981319846610281==
Content-Type: multipart/signed;
  boundary="nextPart2683732.v9upTCThi5";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2683732.v9upTCThi5
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Maybe you need to enable modem?

This is n900 init sequence from script: nokia-n900-configs.sh

    # set up the GPIO's for N900 modem:
    echo 70 >/sys/class/gpio/export
    echo low >/sys/class/gpio/gpio70/direction
    echo 0 >/sys/class/gpio/gpio70/value
    echo 73 >/sys/class/gpio/export
    echo high >/sys/class/gpio/gpio73/direction
    echo 0 >/sys/class/gpio/gpio73/value
    echo 74 >/sys/class/gpio/export
    echo low >/sys/class/gpio/gpio74/direction
    echo 75 >/sys/class/gpio/export
    echo low >/sys/class/gpio/gpio75/direction
    echo 157 >/sys/class/gpio/export
    echo low >/sys/class/gpio/gpio157/direction
    echo 0 >/sys/class/gpio/gpio157/value
    # create symlinks for ofono N900 plugin
    mkdir -p /dev/cmt
    ln -nsf /sys/class/gpio/gpio70 /dev/cmt/cmt_apeslpx
    ln -nsf /sys/class/gpio/gpio74 /dev/cmt/cmt_en
    ln -nsf /sys/class/gpio/gpio73 /dev/cmt/cmt_rst_rq
    ln -nsf /sys/class/gpio/gpio75 /dev/cmt/cmt_rst
    ln -nsf /sys/class/gpio/gpio157 /dev/cmt/cmt_bsi

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart2683732.v9upTCThi5
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlRakT0ACgkQi/DJPQPkQ1IAyQCggohsTovx6sTcRoSat5Nematc
jJAAn3FaCjj29X//NZ6FItoprxAF18Tw
=cmIb
-----END PGP SIGNATURE-----

--nextPart2683732.v9upTCThi5--


--===============7736981319846610281==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7736981319846610281==--
