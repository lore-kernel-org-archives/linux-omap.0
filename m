From: Frans Klaver <frans.klaver@xsens.com>
Subject: Re: [PATCH 09/16] tty: serial: 8250_dma: Add a TX trigger workaround
 for AM33xx
Date: Wed, 17 Sep 2014 12:28:12 +0200
Message-ID: <20140917102812.GA20438@ci00147.xsens-tech.local>
References: <5411967A.6090406@hurleysoftware.com>
 <54119AAA.9080907@linutronix.de>
 <20140911151114.GD28458@ci00147.xsens-tech.local>
 <5411C810.7070906@linutronix.de>
 <2cf997d9-e7de-465b-915d-3a0a5e7b95f7@email.android.com>
 <54129F6C.7040508@linutronix.de>
 <20140912094010.GE28458@ci00147.xsens-tech.local>
 <5412C21A.8020203@linutronix.de>
 <20140912102816.GF28458@ci00147.xsens-tech.local>
 <541716DC.9020904@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <541716DC.9020904@linutronix.de>
Sender: linux-serial-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Peter Hurley <peter@hurleysoftware.com>, tony@atomide.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, balbi@ti.com, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Alan Cox <alan@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

Hi,

Yesterday's testing was a bit messy. So here goes again.

On Mon, Sep 15, 2014 at 06:42:04PM +0200, Sebastian Andrzej Siewior wro=
te:
> On 09/12/2014 12:28 PM, Frans Klaver wrote:
> > port config is 115200 8N1. I don't recall doing anything special. I
> > boot, login, less file and get a lock.
>=20
> So I booted my mini Debian 7.6 (basic system + openssh) on my beagle
> bone black which is:
>=20
> [    0.000000] AM335X ES2.0 (neon )

Mine's the same.

> configured a console, login, invoked "less file". The file was shown,=
 I
> hit on the space key so less shows me more of the file. No lock-up.
> I tried booting via NFS and MMC. I tried various files with less.
>=20
> My dot config is here
> 	https://breakpoint.cc/config-am335x-bb.txt.xz
>=20
> If there is nothing specific to the file you do less on I have no ide=
a
> what else it could if it is not the config.

It could be environmental. I have three test cases right now. Two of
them on the beagle bone black, the third on our custom am335x based
platform.

- All test cases run the same kernel built from uart_v10-pre1.
- For the black, the board, dtb, and u-boot environment are equal for
  the test cases.

- Bone Black: Debian 7.5
  Login, "less file" doesn't lock up. Scrolling down looks sensible.
  Scrolling up leaves me with a crooked display, provided the minicom
  window is more than 24 lines high. Condensed example:

  Normal less looks like:
 =20
	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
	eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad
	minim veniam, quis nostrud exercitation ullamco laboris nisi ut
	aliquip ex ea commodo consequat. Duis aute irure dolor in
	:

  While after scrolling up it looks like

	minim veniam, quis nostrud exercitation ullamco laboris nisi ut
	aliquip ex ea commodo consequat. Duis aute irure dolor in
	:

	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
	eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad

  vi works sensibly, but only occupies part of the total screen estate
  in minicom. After quitting, minicom doesn't use the rest of the scree=
n
  estate anymore.

  After running vi, less doesn't show the weird scrolling behavior
  anymore, since the console has just been limited to 24x80.

- Bone Black: Yocto poky, core-image-minimal
  Login, "less file" locks up, doesn't show anything. I can exit using
  Ctrl-C.

  vi runs normally, only occupies part of the total screen estate in
  minicom. After quitting, a weird character shows up (typically I see
  =C3=BF there), but minicom can use the rest of the screen estate agai=
n.
  If we disregard the odd character, this is much like the behavior we
  have on the omap-serial driver.

- Custom board: Yocto poky, custom image
  Login, "less file" locks up, showing only "=C3=BF" in the top left co=
rner
  of the screen. Can get out of there by having something dumped throug=
h
  /dev/kmsg.

  vi: see "Bone Black: Yocto poky, core-image-minimal"

Having it summed up like this, I think we're back at ncurses and its
interaction with the serial driver.

Hope this helps. Thanks for your effort so far,
=46rans
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
