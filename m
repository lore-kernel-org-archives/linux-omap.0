From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 0/7] twl4030: finish threaded IRQ conversion
Date: Fri, 19 Aug 2011 00:48:09 +0300
Message-ID: <20110818214808.GA21064@legolas.emea.dhcp.ti.com>
References: <1309427470-605-1-git-send-email-balbi@ti.com>
 <20110709040900.GI26900@sirena.org.uk>
 <20110818213614.GB20509@legolas.emea.dhcp.ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110818213614.GB20509@legolas.emea.dhcp.ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, Tony Lindgren <tony@atomide.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-omap@vger.kernel.org


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Aug 19, 2011 at 12:36:15AM +0300, Felipe Balbi wrote:
> Hi,
>=20
> On Sat, Jul 09, 2011 at 05:09:00AM +0100, Mark Brown wrote:
> > On Thu, Jun 30, 2011 at 12:51:03PM +0300, Felipe Balbi wrote:
> >=20
> > > the following patches where boot-tested on beagle xM
> > > and everything seems fine. MMC root filesystem still
> > > mounts, /proc/interrupts looks like ps aux | grep irq
> > > shows our threads, etc.
> >=20
> > Reviewed-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
>=20
> It has been a long time and nobody complained. Samuel, can you take
> these patches in for 3.2 merge window ?

if you want in pull request form, here it is:

The following changes since commit 93ee7a9340d64f20295aacc3fb6a22b759323280:

  Linux 3.1-rc2 (2011-08-14 15:09:08 -0700)

are available in the git repository at:
  master.kernel.org:/pub/scm/linux/kernel/git/balbi/usb.git irq

Felipe Balbi (7):
      mfd: twl4030-irq: remove trailing whitespaces
      mfd: twl4030-irq: implement bus_lock/bus_sync_unlock methods
      mfd: twl4030-irq: drop the kthread
      mfd: twl4030-irq: drop mask_work
      mfd: twl4030-irq: drop edge_work
      mfd: twl4030-irq: set irq nested flag
      rtc: twl: move to threaded irq

 drivers/mfd/twl4030-irq.c |  342 +++++++++++++++++------------------------=
----
 drivers/rtc/rtc-twl.c     |   10 +--
 2 files changed, 132 insertions(+), 220 deletions(-)

--=20
balbi

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOTYiYAAoJEAv8Txj19kN1UpwH/ihrr9WzimdcG+G8SRx3j5sN
vjjkAxuGAy+7TqrIm9u4nEbxLWlv4XwI80heDi+WVV/krysWWDoE5hLjF/gcVaNk
ptVcH1Kk4SNlERsqaU6qe8LqWS5LLKGztGmK3ETh1FZbjkePqzZPvA26xt9P/BxB
afFjY2c9BzNS3PnCcqihQeTC4ofw+PZoBnArO8DUEELK8pv0Z3hKliflVi39wo2V
V0kv6G5DFEEQ1Jgv1ywnFATn5WYoAaiUZ+BAwfe35I6jbExe5nboHPjfmCQTkXiI
tkQFuO1+/k1KIzalg8INGGCx9FmCTWBnHbGmQQj4hgZmU0+bZLzbL3bgpgYFETU=
=Khnw
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--
