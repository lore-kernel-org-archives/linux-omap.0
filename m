From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: Revert disabling of smc91x for n900
Date: Wed, 18 Feb 2015 20:50:48 -0800
Message-ID: <20150219045047.GE32521@atomide.com>
References: <20150105230228.GO4081@atomide.com>
 <201502182004.03195@pali>
 <20150218224206.GC32521@atomide.com>
 <201502182352.16203@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201502182352.16203@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

* Pali Roh=C3=A1r <pali.rohar@gmail.com> [150218 15:58]:
> On Wednesday 18 February 2015 23:42:06 Tony Lindgren wrote:
> > Of course it's always possible to do do a omap3-n900-qemu.dts
> > if larger changes are needed :)
>
> I would like to avoid using separate DTS for qemu. When we have=20
> only one DTS file (for both qemu and real HW), we can test for=20
> regression in qemu and we are sure that we have same software=20
> configuration...

Agreed, and I'd rather take the extra warning on rare to find
hardware to avoid an etra .dts file.

Are there any reasons whey the n900 qemu support could not
be in the mainline qemu btw?

Regards,

Tony
