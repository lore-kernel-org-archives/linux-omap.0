From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH 1/2] ARM: OMAP2+: Drop legacy board file for n900
Date: Wed, 15 Jun 2016 21:34:48 +0300
Message-ID: <20160615183448.GB8398@raspberrypi.musicnaut.iki.fi>
References: <1465987689-14812-1-git-send-email-tony@atomide.com>
 <1465987689-14812-2-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1465987689-14812-2-git-send-email-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@baylibre.com>, Timo Kokkonen <timo.t.kokkonen@iki.fi>, Sebastian Reichel <sre@kernel.org>, Russell King <rmk+kernel@armlinux.org.uk>, Pavel Machek <pavel@ucw.cz>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Olof Johansson <olof@lixom.net>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Wed, Jun 15, 2016 at 03:48:08AM -0700, Tony Lindgren wrote:
> Let's drop the last two remaining omap3 legacy boot board files.
> Let's only use the device tree based booting known to work for
> these two boards.
> 
> We still have two omap3 boards booting in legacy mode in addition
> to device tree based booting. All the other ten or so omap2+ SoCs
> have been booting using device tree mode only for years now. This
> has allowed us to get rid of quite a bit of arch/arm/mach-omap2
> related platform init code in favor of dts and driver changes.
> 
> Pretty much the only remaining known users for omap3 legacy boot
> board files are Kevin's and Russell's boot test systems, and N900
> kernel tree maintained by Pali and Ivaylo. And all of them are
> also supporting the device tree based booting. The legacy booting
> mode has been kept around mostly to verify against regressions.
> 
> As there is still a slim chance of possible other uses of the
> mainline kernel for these boards, let's just drop the board
> files for v4.8, and let's not touch the related platform init
> code until around v4.9 time if no issues are found. This makes
> it trivial for us to add back the board files with a simple revert.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Acked-by: Aaro Koskinen <aaro.koskinen@iki.fi>

A.

> ---
>  arch/arm/mach-omap2/Kconfig                  |    6 -
>  arch/arm/mach-omap2/Makefile                 |    3 -
>  arch/arm/mach-omap2/board-rx51-peripherals.c | 1317 --------------------------
>  arch/arm/mach-omap2/board-rx51-video.c       |   67 --
>  arch/arm/mach-omap2/board-rx51.c             |  141 ---
>  arch/arm/mach-omap2/board-rx51.h             |   11 -
>  6 files changed, 1545 deletions(-)
>  delete mode 100644 arch/arm/mach-omap2/board-rx51-peripherals.c
>  delete mode 100644 arch/arm/mach-omap2/board-rx51-video.c
>  delete mode 100644 arch/arm/mach-omap2/board-rx51.c
>  delete mode 100644 arch/arm/mach-omap2/board-rx51.h
