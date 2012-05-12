From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [GIT PULL] gpio/omap: cleanups for v3.5
Date: Fri, 11 May 2012 18:51:55 -0600
Message-ID: <20120512005156.5131B3E0791@localhost>
References: <874nrmtf47.fsf@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:57595 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755061Ab2ELAv6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 May 2012 20:51:58 -0400
Received: by dady13 with SMTP id y13so3709956dad.19
        for <linux-omap@vger.kernel.org>; Fri, 11 May 2012 17:51:58 -0700 (PDT)
In-Reply-To: <874nrmtf47.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

On Fri, 11 May 2012 17:30:48 -0700, Kevin Hilman <khilman@ti.com> wrote:
> Hi Grant,
> 
> Here's the final round of GPIO cleanups for v3.5.  This branch is based
> on my for_3.5/fixes/gpio branch you just pulled.
> 
> Kevin
> 
> 
> The following changes since commit 6edd94db250038c8fdf176f23ca4017d2f312509:
> 
>   gpio/omap: fix incorrect initialization of omap_gpio_mod_init (2012-05-10 07:16:15 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git for_3.5/gpio/cleanup

Applied, thanks.

g.

> 
> for you to fetch changes up to 1b1287032df3a69d3ef9a486b444f4ffcca50d01:
> 
>   gpio/omap: fix missing check in *_runtime_suspend() (2012-05-11 17:08:40 -0700)
> 
> ----------------------------------------------------------------
> Tarun Kanti DebBarma (8):
>       gpio/omap: remove virtual_irq_start variable
>       gpio/omap: remove saved_fallingdetect, saved_risingdetect
>       gpio/omap: remove suspend_wakeup field from struct gpio_bank
>       gpio/omap: remove saved_wakeup field from struct gpio_bank
>       gpio/omap: remove retrigger variable in gpio_irq_handler
>       gpio/omap: remove suspend/resume callbacks
>       gpio/omap: remove cpu_is_omapxxxx() checks from *_runtime_resume()
>       gpio/omap: fix missing check in *_runtime_suspend()
> 
>  arch/arm/mach-omap1/gpio15xx.c         |    2 -
>  arch/arm/mach-omap1/gpio16xx.c         |    5 --
>  arch/arm/mach-omap1/gpio7xx.c          |    7 ---
>  arch/arm/mach-omap2/gpio.c             |    3 +-
>  arch/arm/plat-omap/include/plat/gpio.h |    3 +-
>  drivers/gpio/gpio-omap.c               |  103 +++++++-------------------------
>  6 files changed, 27 insertions(+), 96 deletions(-)

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies, Ltd.
