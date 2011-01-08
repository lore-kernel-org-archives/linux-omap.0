From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 0/40] Complete set of clocksource/sched_clock patches
Date: Sat, 8 Jan 2011 09:23:31 +0000
Message-ID: <20110108092330.GX1198@n2100.arm.linux.org.uk>
References: <20101217113223.GC9937@n2100.arm.linux.org.uk> <AANLkTik-MApg7khsUDHuvmfEy0NRnmJQ7ZP-o8+mQpOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AANLkTik-MApg7khsUDHuvmfEy0NRnmJQ7ZP-o8+mQpOw@mail.gmail.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Wan ZongShun <mcuos.com@gmail.com>
Cc: Alessandro Rubini <rubini@unipv.it>, Bryan Huntsman <bryanh@codeaurora.org>, Colin Cross <ccross@android.com>, Daniel Walker <dwalker@codeaurora.org>, David Brown <davidb@codeaurora.org>, Eric Miao <eric.y.miao@gmail.com>, Erik Gilling <konkers@android.com>, "Hans J. Koch" <hjk@linutronix.de>, Imre Kaloz <kaloz@openwrt.org>, Kevin Hilman <khilman@deeprootsystems.com>, Krzysztof Halasa <khc@pm.waw.pl>, Kukjin Kim <kgene.kim@samsung.com>, Lennert Buytenhek <kernel@wantstofly.org>, Jiandong Zheng <jdzheng@broadcom.com>, Linus Walleij <linus.walleij@stericsson.com>, linux-arm-msm@vger.kernel.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>, Olof Johansson <olof@lixom.net>, Sascha Hauer <kernel@pengutronix.de>, Scott Branden <sbranden@broadcom.com>, STEricsson <STEricsson_nomadik_linux@lis>
List-Id: linux-omap@vger.kernel.org

On Sat, Jan 08, 2011 at 05:05:53PM +0800, Wan ZongShun wrote:
> 2010/12/17 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> > Here is the entire set of clocksource and sched_clock patches which
> > have been previously posted. =A0There's a couple of small tweaks in=
 a
> > few of the patches (such as adding notrace to OMAP clocksource read
> > functions), and this also shows the proper ordering of these patche=
s.
> >
> > Still looking for acks or tested-by's for these patches.
> >
>=20
> Acked-By: Wan Zongshun <mcuos.com@gmail.com>

I'm afraid you're too late - it's already in mainline so your ack can't
be added.
--
To unsubscribe from this list: send the line "unsubscribe linux-arm-msm=
" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
