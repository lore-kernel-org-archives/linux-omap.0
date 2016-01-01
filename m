From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: Re: [PATCH 2/2] memory: omap-gpmc: Add Kconfig option for debug
Date: Fri, 1 Jan 2016 13:29:00 +0200
Message-ID: <568662FC.9050206@gmail.com>
References: <1432156863-19695-1-git-send-email-tony@atomide.com>
 <1432156863-19695-3-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1432156863-19695-3-git-send-email-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: Nishanth Menon <nm@ti.com>, Paul Walmsley <paul@pwsan.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Sebastian Reichel <sre@kernel.org>, pavel@ucw.cz, =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>, Brian Hutchinson <b.hutchman@gmail.com>, linux-arm-kernel@lists.infradead.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On 21.05.2015 00:21, Tony Lindgren wrote:
> We support decoding the bootloader values if DEBUG is defined.
> But we also need to change the struct omap_hwmod flags to have
> HWMOD_INIT_NO_RESET to avoid the GPMC being reset during the
> boot. Otherwise just the default timings will be displayed
> instead of the bootloader configured timings.
>
> This also allows us to clean up the various GPMC related
> hwmod flags. For debugging, we only need HWMOD_INIT_NO_RESET,
> and HWMOD_INIT_NO_IDLE is not needed.
>
> Cc: Brian Hutchinson <b.hutchman@gmail.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Roger Quadros <rogerq@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>   arch/arm/mach-omap2/omap_hwmod.h                        |  6 ++++++
>   arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c      | 12 ++----------
>   arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c |  3 ++-
>   arch/arm/mach-omap2/omap_hwmod_3xxx_data.c              | 12 ++----------
>   arch/arm/mach-omap2/omap_hwmod_44xx_data.c              | 11 ++---------
>   arch/arm/mach-omap2/omap_hwmod_7xx_data.c               |  4 ++--
>   arch/arm/mach-omap2/omap_hwmod_81xx_data.c              |  2 ++
>   drivers/memory/Kconfig                                  |  8 ++++++++
>   drivers/memory/omap-gpmc.c                              |  6 +++---
>   9 files changed, 29 insertions(+), 35 deletions(-)
>

1. Happy new year :)

2. It was a while I tested upstream on N900 but I had some spare time 
during the holidays to play, so I tried to boot 4.4-rc6 with Maemo 5. To 
my surprise, after that try, Maemo 5 rootfs, which is located on onenand 
became irreversibly corrupted. I bisected the tree to the $subject 
commit and after restoring HWMOD_INIT_NO_RESET in omap3xxx_gpmc_hwmod 
flags, the problem was solved. It seems that GPMC is either incorrectly 
or incompletely setup by the kernel, leading to failed onenand 
reads/writes and whatnot. Unfortunately, what I have here is a release 
device, so I am unable to capture any logs through the serial port. BTW 
keep in mind that rootfs corruption happens as soon as a boot is 
attempted, even after a freshly flashed rootfs.

Please advice on how to proceed.

Regards,
Ivo
