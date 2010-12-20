From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 0/40] Complete set of clocksource/sched_clock patches
Date: Mon, 20 Dec 2010 22:48:14 +0000
Message-ID: <20101220224814.GJ28157@n2100.arm.linux.org.uk>
References: <20101217113223.GC9937@n2100.arm.linux.org.uk> <AANLkTimarRAf-_ykQNLgzXd3TtUHhSw+gZ6cZ5pW=Y-9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AANLkTimarRAf-_ykQNLgzXd3TtUHhSw+gZ6cZ5pW=Y-9@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Eric Miao <eric.y.miao@gmail.com>
Cc: Alessandro Rubini <rubini@unipv.it>, Bryan Huntsman <bryanh@codeaurora.org>, Colin Cross <ccross@android.com>, Daniel Walker <dwalker@codeaurora.org>, David Brown <davidb@codeaurora.org>, Erik Gilling <konkers@android.com>, "Hans J. Koch" <hjk@linutronix.de>, Imre Kaloz <kaloz@openwrt.org>, Kevin Hilman <khilman@deeprootsystems.com>, Krzysztof Halasa <khc@pm.waw.pl>, Kukjin Kim <kgene.kim@samsung.com>, Lennert Buytenhek <kernel@wantstofly.org>, Jiandong Zheng <jdzheng@broadcom.com>, Linus Walleij <linus.walleij@stericsson.com>, linux-arm-msm@vger.kernel.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>, Olof Johansson <olof@lixom.net>, Sascha Hauer <kernel@pengutronix.de>, Scott Branden <sbranden@broadcom.com>, STEricsson <STEricsson_nomadik_linux@list.st.com>, Tony Lindgren <tony@atom>
List-Id: linux-omap@vger.kernel.org

On Mon, Dec 20, 2010 at 11:32:21AM +0800, Eric Miao wrote:
> On Fri, Dec 17, 2010 at 7:32 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
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
> Hi Russell,
>=20
> Sorry for late feedback. Tested the branch 'clksrc' on Littleton/PXA3=
xx,
> seems to be good.
>=20
> Tested-by: Eric Miao <eric.y.miao@gmail.com>

Ok, I'll add that to the PXA and generic patches, thanks.
