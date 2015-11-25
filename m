From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 5/5] arm: boot: store ATAGs structure into DT "/chosen/linux,atags" entry
Date: Wed, 25 Nov 2015 22:51 +0100
Message-ID: <17689711.DsQsCiDFAN@wuerfel>
References: <20150713131902.GH26485@atomide.com> <3245119.krc4KB3uae@wuerfel> <201511252244.28797@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201511252244.28797@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>, Frank Rowand <frowand.list@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Laura Abbott <lauraa@codeaurora.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robherring2@gmail.com>, Will Deacon <will.deacon@arm.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@debian.org>, Andreas =?ISO-8859-1?Q?F=E4rber?= <afaerber@suse.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wednesday 25 November 2015 22:44:28 Pali Roh=E1r wrote:
>=20
> Arnd, my question about proper solution reminds... Proprietary=20
> bootloader which cannot be replaced (e.g. it is signed or do unknown=20
> magic) provides information to booted kernel via custom specific ATAG=
s=20
> fields. How userspace could properly read those custom information fr=
om=20
> bootloader?

The typical solution for nonstandard bootloaders is to have a boot wrap=
per
like the one from https://github.com/zonque/pxa-impedance-matcher that
translates whatever information we have at the bootloader level into
DT properties.

As I understand, the reason we are not doing that here is that we also
have proprietary user space that we can't fix to look in a different
place, i.e. the interface is between the bootloader and some user
binary, not bootloader to kernel.

	Arnd
