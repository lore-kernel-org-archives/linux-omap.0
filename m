From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] ARM: ATAGS: move save_atags() to include/asm
 arch/arm/include/asm/setup.h
Date: Thu, 24 Dec 2015 10:53:19 -0800
Message-ID: <20151224185319.GT2793@atomide.com>
References: <20151224153536.GJ30871@n2100.arm.linux.org.uk>
 <1450975076-7411-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <1450975076-7411-2-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <201512241848.17946@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201512241848.17946@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, linux@arm.linux.org.uk, nicolas.pitre@linaro.org, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Pali Roh=C3=A1r <pali.rohar@gmail.com> [151224 09:48]:
> On Thursday 24 December 2015 17:37:55 Ivaylo Dimitrov wrote:
> > So it can be used by code outside arch/arm/kernel/. Fix save_atags(=
)
> > declaration to match its definition while at it.
> >=20
> > Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
>=20
> Tested-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>

Nice, please upload both to Russell's patch system after no
more comments:

Acked-by: Tony Lindgren <tony@atomide.com>
