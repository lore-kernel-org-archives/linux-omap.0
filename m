From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH v2 02/15] ARM: mark const init data with __initconst instead
 of __initdata
Date: Wed, 11 Apr 2012 17:04:15 +0530
Message-ID: <4F856C37.2040304@ti.com>
References: <20120330200358.GV15647@pengutronix.de> <1333137905-13809-2-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1333137905-13809-2-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-arm-msm-owner@vger.kernel.org
To: =?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, kernel@pengutronix.de, Andrew Victor <linux@maxim.org.za>, Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Russell King <linux@arm.linux.org.uk>, Kevin Hilman <khilman@ti.com>, Kukjin Kim <kgene.kim@samsung.com>, Shawn Guo <shawn.guo@linaro.org>, Lennert Buytenhek <kernel@wantstofly.org>, Nicolas Pitre <nico@fluxnic.net>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, David Brown <davidb@codeaurora.org>, Daniel Walker <dwalker@fifo99.com>, Bryan Huntsman <bryanh@codeaurora.org>, Tony Lindgren <tony@atomide.com>, Barry Song <baohua.song@csr.com>, Andrew Lunn <andrew@lunn.ch>, Lucas De Marchi <lucas.demarchi@profusion.mobi>, linux-arm-kernel@lists.infradead.org, davinci-linux-open-source@linux.davincidsp.co
List-Id: linux-omap@vger.kernel.org

Hi Uwe,

On 3/31/2012 1:34 AM, Uwe Kleine-K=C3=B6nig wrote:
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
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

=46or the DaVinci parts,

Acked-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar
