From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] OMAP: RX51: save ATAGS data in the early boot stage
Date: Thu, 24 Dec 2015 10:56:05 -0800
Message-ID: <20151224185604.GU2793@atomide.com>
References: <20151224153536.GJ30871@n2100.arm.linux.org.uk>
 <1450975076-7411-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <1450975076-7411-3-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <201512241849.11704@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201512241849.11704@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, linux@arm.linux.org.uk, nicolas.pitre@linaro.org, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Pali Roh=C3=A1r <pali.rohar@gmail.com> [151224 09:49]:
> On Thursday 24 December 2015 17:37:56 Ivaylo Dimitrov wrote:
> > Nokia N900 (RX51) legacy userspace needs various ATAGS passed by th=
e
> > bootloader (boot reason, device serial, boot mode, various GPIO
> > swithes, etc). Save that data early enough in the boot process, so
> > it can be exported later in /proc/atags
> >=20
> > Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
>=20
> Working fine in qemu.
>=20
> Tested-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>

Maybe update the description to say "This fixes a regression with
device tree based booting compared to legacy booting for n900 to
make the n900 legacy user space to also work with device tree based
booting".

It would be nice to get these two in as fixes after -rc1 assuming
people have no objections to it. So please upload this one also
into Russell's patch system after no more comments:

Acked-by: Tony Lindgren <tony@atomide.com>
