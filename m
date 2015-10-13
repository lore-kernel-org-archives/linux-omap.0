From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v2 0/3] arm:irchip: IRQCHIP_DECLARE macro is now
 accessible
Date: Tue, 13 Oct 2015 21:48:51 +0800
Message-ID: <20151013134851.GA551@tiger>
References: <1444740975-31948-1-git-send-email-joel@porquet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1444740975-31948-1-git-send-email-joel@porquet.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Joel Porquet <joel@porquet.org>
Cc: linux-kernel@vger.kernel.org, linux@arm.linux.org.uk, kgene@kernel.org, k.kozlowski@samsung.com, kernel@pengutronix.de, tony@atomide.com, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Marc Zyngier <marc.zyngier@arm.com>
List-Id: linux-omap@vger.kernel.org

On Tue, Oct 13, 2015 at 02:56:12PM +0200, Joel Porquet wrote:
> The IRQCHIP_DECLARE macro migrated to 'include/linux/irqchip.h', maki=
ng it
> globally accessible.
>=20
> See commit 91e20b5040c67c51aad88cf87db4305c5bd7f79d ("irqchip: Move
> IRQCHIP_DECLARE macro to include/linux/irqchip.h").
>=20
> This series of patches add inclusions of 'include/linux/irqchip.h' an=
d
> replaces uses of macro OF_DECLARE_2 with IRQCHIP_DECLARE for platform=
s
> exynos, imx and omap2.
>=20
> I had submitted a single patch a few months ago
> (https://lkml.org/lkml/2015/7/7/1069), but it never got merged althou=
gh it
> had been acked by all the subsystem maintainers. Hopefully, splitting=
 the
> patch into these independent patches that can be applied separately s=
hould
> help.
>=20
> Jo=EBl
>=20
> Joel Porquet (3):
>   arm:exynos: IRQCHIP_DECLARE macro is now accessible
>   arm:imx: IRQCHIP_DECLARE macro is now accessible
>   arm:omap2: IRQCHIP_DECLARE macro is now accessible
>=20
>  arch/arm/mach-exynos/suspend.c       | 3 ++-
>  arch/arm/mach-imx/gpc.c              | 7 ++-----
>  arch/arm/mach-omap2/omap-wakeupgen.c | 7 ++-----
>  3 files changed, 6 insertions(+), 11 deletions(-)

Marc sent a patch [1] doing the same thing a few days ago.

Shawn

[1] http://thread.gmane.org/gmane.linux.ports.arm.kernel/444136
