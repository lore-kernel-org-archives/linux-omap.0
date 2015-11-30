From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/7] ARM: omap1: make headers more local
Date: Mon, 30 Nov 2015 15:04:46 -0800
Message-ID: <20151130230445.GN23396@atomide.com>
References: <1448924458-3279040-1-git-send-email-arnd@arndb.de>
 <1448924458-3279040-2-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1448924458-3279040-2-git-send-email-arnd@arndb.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Wan ZongShun <mcuos.com@gmail.com>, Kevin Hilman <khilman@deeprootsystems.com>, Sekhar Nori <nsekhar@ti.com>, Greg Ungerer <gerg@uclinux.org>, Gregory Clement <gregory.clement@free-electrons.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Arnd Bergmann <arnd@arndb.de> [151130 15:02]:
> Some header files are never included outside of a mach-omap1
> directory and do not need to be made visible in include/mach,
> so let's just move them all down one level.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/mach-omap1/board-ams-delta.c              | 2 +-
>  arch/arm/mach-omap1/board-fsample.c                | 2 +-
>  arch/arm/mach-omap1/board-h2.c                     | 2 +-
>  arch/arm/mach-omap1/board-h3.c                     | 2 +-
>  arch/arm/mach-omap1/board-innovator.c              | 2 +-
>  arch/arm/mach-omap1/board-osk.c                    | 2 +-
>  arch/arm/mach-omap1/board-palmte.c                 | 2 +-
>  arch/arm/mach-omap1/board-palmtt.c                 | 2 +-
>  arch/arm/mach-omap1/board-palmz71.c                | 2 +-
>  arch/arm/mach-omap1/board-perseus2.c               | 2 +-
>  arch/arm/mach-omap1/board-sx1-mmc.c                | 2 +-
>  arch/arm/mach-omap1/board-sx1.c                    | 4 ++--
>  arch/arm/mach-omap1/{include/mach => }/board-sx1.h | 0
>  arch/arm/mach-omap1/{include/mach => }/camera.h    | 0
>  arch/arm/mach-omap1/devices.c                      | 2 +-
>  arch/arm/mach-omap1/flash.c                        | 2 +-
>  arch/arm/mach-omap1/{include/mach => }/flash.h     | 0
>  17 files changed, 15 insertions(+), 15 deletions(-)
>  rename arch/arm/mach-omap1/{include/mach => }/board-sx1.h (100%)
>  rename arch/arm/mach-omap1/{include/mach => }/camera.h (100%)
>  rename arch/arm/mach-omap1/{include/mach => }/flash.h (100%)

Looks good to me:

Acked-by: Tony Lindgren <tony@atomide.com>
