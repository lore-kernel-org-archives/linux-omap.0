From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: n900 in 4.2-rc0: repeating oopses
Date: Mon, 29 Jun 2015 12:45:53 +0200
Message-ID: <20150629104553.GD16230@pali>
References: <20150416093234.GA17423@amd>
 <20150629091146.GA5103@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150629091146.GA5103@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com
List-Id: linux-omap@vger.kernel.org

Hi!

On Monday 29 June 2015 11:11:46 Pavel Machek wrote:
> Hi!
>=20
> Just tried booting 4.2-rc0 on n900 (commit
> 4a10a91756ef381bced7b88cfb9232f660b92d93) and it is broken. Previous
> -rc0 version worked. This time, there's some output on console, but
> too fast for me to read.
>=20

What happen after errors are reported? Maybe you can enable R&D mode an=
d
disable HW watchdogs to prevent device reboots...

> It seems oopses happen before mounting root. If you have serial
> console, they should be easy to see.
>=20
> I tried booting same kernel in qemu, but it seems to work ok there.
>=20

Hm... Maybe problem with HS code?

By chance, can you try to disable (omap) sham node in n900 DT file?
(same way like omap aes is disabled)

> Any ideas? Thanks,
> 									Pavel

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
