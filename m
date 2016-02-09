From: Valdis.Kletnieks@vt.edu
Subject: Re: [PATCH v12 2/4] PM / Domains: add setter for dev.pm_domain
Date: Tue, 09 Feb 2016 15:14:35 -0500
Message-ID: <43751.1455048875@turing-police.cc.vt.edu>
References: <1452181575-9206-1-git-send-email-tomeu.vizoso@collabora.com>
 <CAHp75VdWPUZ8F5rsGn3M1e5Pgpcg1CErBej9PE_3+ZPke5CDFA@mail.gmail.com>
 <CAHp75Vf9TS-AxJALQjiwNjMCT8ct5SBanYzrEsV9aj=DsUw-OA@mail.gmail.com>
 <1783906.XctYjeUNLr@vostro.rjw.lan>
 <44858.1454967873@turing-police.cc.vt.edu>
 <CAJZ5v0jUipo06fpSQsKi+5Po_32ntgc3Ns29=17SgQr2PSj+kA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0252255705=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <CAJZ5v0jUipo06fpSQsKi+5Po_32ntgc3Ns29=17SgQr2PSj+kA@mail.gmail.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kevin Hilman <khilman@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, Alan Stern <stern@rowland.harvard.edu>, dri-devel@lists.freedesktop.org, Pavel Machek <pavel@ucw.cz>, Tomas Winkler <tomas.winkler@intel.com>, Len Brown <lenb@kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

--===============0252255705==
Content-Type: multipart/signed; boundary="==_Exmh_1455048875_2220P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit

--==_Exmh_1455048875_2220P
Content-Type: text/plain; charset=us-ascii

On Mon, 08 Feb 2016 22:50:39 +0100, "Rafael J. Wysocki" said:
> On Mon, Feb 8, 2016 at 10:44 PM,  <Valdis.Kletnieks@vt.edu> wrote:

> > My Dell Latitude laptopi on next-20160201 is throwing a similar error
> > at shutdown, except the traceback continues:
> >
> > mei_me_remove+0xbd/0xc0
> > pci_device_shutdown+0x32/0x50
> > device_shutdown+0xe2/0x210
> >
> > (sorry, that's all I have, transcribing from one frame of video shot while
> > the system was shutting down....)
>
> This should be fixed in 4.5-rc3, so please retest.

Confirming that next-20160201 has the problem, but it is fixed as of next-20160208.

--==_Exmh_1455048875_2220P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Exmh version 2.5 07/13/2001

iQIVAwUBVrpIqwdmEQWDXROgAQIApRAAs86TY9ql0NfW5ebbST9a4zpS2N14eLd9
gHbI7eVnVSoBEPpA0v4iFIjOhMoYg0HBcLRZiCkvGz4sKFJBi3jfMQVSf+WDUB7t
t/TyOhz2tSxapeiCKWyV/OGS0w1iTh14Jp0QETvPtW3zQqFJck8rYful9WGpBu8z
84JRm2t3IHazprR8rELLC/LgJVpjIX+YoQMD8Ncviqgp/PhpAx1T23xoNSWprbOg
zc2zwJyB8kUFUcFJjnQ/7hv64qM7mYn0NdkhFKLkn0nwpADhV+P1IYZn9NYv+rAX
KgSfacwtOhe+9O/WP5kjnS5WVbuh4w9mDM9oCAdhG8hK5+1gA+CJ77jW98hiUSBx
QHSsQSnvYXqr1dFPWPa1yp0qClYLkO2CEUkcM8MdpQSpqA2rBJRjr5LUGl+yo6z9
yjwYw7nh2e7HbhrjkrpXAlS23e2OxfpgK5ShRmtGLzPKAZwLh/VpmAqGZ1EsgQiP
FkDxrCcVhki9eirwA4C9tOdyJVZnx46hEpuMefYl83QFMWzJnHoByfX0lcB4f5Os
rD3jNQsxuky18wWEikf3FfKqnSEiiWzk07IwrYgIMs57gmtIne/CUyrMqcLGrNq3
nrwOqCKSIu7113MJrYMlOCqzF03n7u5BFCfS4I/Muw+bR5Ki79wr2tgOG0LG3MLe
BIraoSAmkoM=
=g8TO
-----END PGP SIGNATURE-----

--==_Exmh_1455048875_2220P--

--===============0252255705==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============0252255705==--
