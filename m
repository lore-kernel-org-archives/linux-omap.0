From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 03/17] ARM: mark const init data with __initconst
 instead of __initdata
Date: Fri, 30 Mar 2012 09:11:31 -0700
Message-ID: <20120330161130.GA8240@atomide.com>
References: <20120329211131.GA31250@pengutronix.de>
 <1333055554-31300-3-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1333055554-31300-3-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, kernel@pengutronix.de, Andrew Victor <linux@maxim.org.za>, Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Russell King <linux@arm.linux.org.uk>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@ti.com>, Kukjin Kim <kgene.kim@samsung.com>, Shawn Guo <shawn.guo@linaro.org>, Lennert Buytenhek <kernel@wantstofly.org>, Nicolas Pitre <nico@fluxnic.net>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, David Brown <davidb@codeaurora.org>, Daniel Walker <dwalker@fifo99.com>, Bryan Huntsman <bryanh@codeaurora.org>, Barry Song <baohua.song@csr.com>, Andrew Lunn <andrew@lunn.ch>, Lucas De Marchi <lucas.demarchi@profusion.mobi>, linux-arm-kernel@lists.infradead.org, davinci-linux-open-source@linux.davincidsp.com, linux-sa
List-Id: linux-omap@vger.kernel.org

* Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> [120329 14:16]=
:
> As long as there is no other non-const variable marked __initdata in =
the
> same compilation unit it doesn't hurt. If there were one however
> compilation would fail with
>=20
> 	error: $variablename causes a section type conflict
>=20
> because a section containing const variables is marked read only and =
so
> cannot contain non-const variables.

Acked-by: Tony Lindgren <tony@atomide.com>
