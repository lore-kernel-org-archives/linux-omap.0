From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: Re: [PATCH 03/17] ARM: mark const init data with __initconst
 instead of __initdata
Date: Fri, 30 Mar 2012 06:34:56 +0200
Message-ID: <20120330043456.GL7757@game.jcrosoft.org>
References: <20120329211131.GA31250@pengutronix.de>
 <1333055554-31300-3-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1333055554-31300-3-git-send-email-u.kleine-koenig@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>, Daniel Walker <dwalker@fifo99.com>, Lennert Buytenhek <kernel@wantstofly.org>, Kevin Hilman <khilman@ti.com>, Kukjin Kim <kgene.kim@samsung.com>, Russell King <linux@arm.linux.org.uk>, linux-arm-msm@vger.kernel.org, David Brown <davidb@codeaurora.org>, Lucas De Marchi <lucas.demarchi@profusion.mobi>, Nicolas Ferre <nicolas.ferre@atmel.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, linux-samsung-soc@vger.kernel.org, Barry Song <baohua.song@csr.com>, linux-omap@vger.kernel.org, Andrew Victor <linux@maxim.org.za>, linux-arm-kernel@lists.infradead.org, davinci-linux-open-source@linux.davincidsp.com, Eric Miao <eric.y.miao@gmail.com>, Nicolas Pitre <nico@fluxnic.net>, linux-kernel@vger.kernel.org, Bryan Huntsman <bryanh@codeaurora.org>, kernel@pengutronix.de, Andrew Morton <akpm@li>
List-Id: linux-omap@vger.kernel.org

On 23:12 Thu 29 Mar     , Uwe Kleine-K=F6nig wrote:
> As long as there is no other non-const variable marked __initdata in the
> same compilation unit it doesn't hurt. If there were one however
> compilation would fail with
> =

> 	error: $variablename causes a section type conflict
> =

> because a section containing const variables is marked read only and so
> cannot contain non-const variables.
> =

> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Cc: Andrew Victor <linux@maxim.org.za>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Lennert Buytenhek <kernel@wantstofly.org>
> Cc: Nicolas Pitre <nico@fluxnic.net>
> Cc: Eric Miao <eric.y.miao@gmail.com>
> Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
> Cc: David Brown <davidb@codeaurora.org>
> Cc: Daniel Walker <dwalker@fifo99.com>
> Cc: Bryan Huntsman <bryanh@codeaurora.org>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Barry Song <baohua.song@csr.com>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: davinci-linux-open-source@linux.davincidsp.com
> Cc: linux-samsung-soc@vger.kernel.org
> Cc: linux-arm-msm@vger.kernel.org
> Cc: linux-omap@vger.kernel.org
> ---
>  arch/arm/mach-at91/board-dt.c                 |    2 +-
>  arch/arm/mach-at91/clock.c                    |    2 +-
for at91
Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

Best Regards,
J.
