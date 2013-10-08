From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 3/3] RX-51: Add support for OMAP3 ROM Random Number
 Generator
Date: Tue, 8 Oct 2013 12:06:47 -0700
Message-ID: <20131008190647.GO8313@atomide.com>
References: <1379534757-20870-1-git-send-email-pali.rohar@gmail.com>
 <1379683507-30793-1-git-send-email-pali.rohar@gmail.com>
 <1379683507-30793-4-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1379683507-30793-4-git-send-email-pali.rohar@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Cc: Matt Mackall <mpm@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, Russell King <linux@arm.linux.org.uk>, Joe Perches <joe@perches.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Pali Roh=C3=A1r <pali.rohar@gmail.com> [130920 06:33]:
> Adding this driver as platform device and only for RX-51 until somebo=
dy test if
> it working also on other OMAP3 HS devices and until there will be gen=
eric ARM
> way to deal with SMC calls.

Thanks I'll apply this with the patch #1 clock alias folded in into
omap-for-v3.13/n900 branch.

Regards,

Tony
