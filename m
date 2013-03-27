From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP3 ROM Random Number Generator support
Date: Wed, 27 Mar 2013 15:25:24 -0700
Message-ID: <20130327222524.GR10155@atomide.com>
References: <201302281905.48546@pali>
 <20130327210918.GP10155@atomide.com>
 <201303272303.44420@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201303272303.44420@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Cc: Juha Yrjola <juha.yrjola@solidboot.com>, Russell King <linux@arm.linux.org.uk>, Matt Mackall <mpm@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Pali Roh=C3=A1r <pali.rohar@gmail.com> [130327 15:08]:
>=20
> I will remove above code for checking omap type from hw rand=20
> driver, because same code is in omap part which creating=20
> platform_device for this driver. So soc.h is not needed.

OK thanks,

Tony
