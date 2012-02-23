From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [GIT PULL] gpio/omap: cleanup and runtime PM conversion for v3.4
Date: Wed, 22 Feb 2012 18:37:46 -0700
Message-ID: <20120223013746.GB3212@ponder.secretlab.ca>
References: <8762f6fr13.fsf@ti.com>
 <4F456F01.5020302@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:46623 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752288Ab2BWBht (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Feb 2012 20:37:49 -0500
Received: by daed14 with SMTP id d14so663784dae.19
        for <linux-omap@vger.kernel.org>; Wed, 22 Feb 2012 17:37:49 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4F456F01.5020302@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

On Wed, Feb 22, 2012 at 02:41:05PM -0800, Kevin Hilman wrote:
> Hi Grant,
> 
> Any objections to this series? Can we get this queued and into linux-next?
> 
> I'll have an additional pull request for Benoit's GPIO DT stuff that
> depends on this for v3.4 too after that series is finalized.

The diffstat is clean.  I've merged it in.

g.

> 
> Thanks,
> 
> Kevin
> 
> On 02/16/2012 12:43 PM, Kevin Hilman wrote:
> >Hi Grant,
> >
> >I've given this a final review and testing and I believe it's ready for
> >3.4, so here you go.
> >
> >Also note that Benoit's recently posted GPIO cleanups and DT conversion
> >depend on this series.
> >
> >Thanks,
> >
> >Kevin
> >
> >
> >The following changes since commit 62aa2b537c6f5957afd98e29f96897419ed5ebab:
> >
> >   Linux 3.3-rc2 (2012-01-31 13:31:54 -0800)
> >
> >are available in the git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git for_3.4/gpio/runtime-pm-cleanup
> >
> >for you to fetch changes up to f86bcc302a8c570dd0f5a50097a6af96a0e717c2:
> >
> >   gpio/omap: handle set_dataout reg capable IP on restore (2012-02-06 16:58:45 +0530)
> >
> >----------------------------------------------------------------
> >Charulatha V (8):
> >       gpio/omap: remove dependency on gpio_bank_count
> >       gpio/omap: use flag to identify wakeup domain
> >       gpio/omap: make gpio_context part of gpio_bank structure
> >       gpio/omap: make non-wakeup GPIO part of pdata
> >       gpio/omap: avoid cpu checks during module ena/disable
> >       gpio/omap: use pinctrl offset instead of macro
> >       gpio/omap: remove bank->method&  METHOD_* macros
> >       gpio/omap: fix bankwidth for OMAP7xx MPUIO
> >
> >Nishanth Menon (4):
> >       gpio/omap: save and restore debounce registers
> >       gpio/omap: enable irq at the end of all configuration in restore
> >       gpio/omap: restore OE only after setting the output level
> >       gpio/omap: handle set_dataout reg capable IP on restore
> >
> >Tarun Kanti DebBarma (13):
> >       gpio/omap: handle save/restore context in GPIO driver
> >       gpio/omap: further cleanup using wkup_en register
> >       gpio/omap: use level/edge detect reg offsets
> >       gpio/omap: remove hardcoded offsets in context save/restore
> >       gpio/omap: cleanup set_gpio_triggering function
> >       gpio/omap: cleanup omap_gpio_mod_init function
> >       gpio/omap: remove unnecessary bit-masking for read access
> >       gpio/omap: use pm-runtime framework
> >       gpio/omap: optimize suspend and resume functions
> >       gpio/omap: cleanup prepare_for_idle and resume_after_idle
> >       gpio/omap: fix debounce clock handling
> >       gpio/omap: fix incorrect access of debounce module
> >       gpio/omap: remove omap_gpio_save_context overhead
> >
> >  arch/arm/mach-omap1/gpio15xx.c         |    7 +-
> >  arch/arm/mach-omap1/gpio16xx.c         |   47 ++-
> >  arch/arm/mach-omap1/gpio7xx.c          |   14 +-
> >  arch/arm/mach-omap2/gpio.c             |   36 +-
> >  arch/arm/mach-omap2/pm34xx.c           |   14 -
> >  arch/arm/plat-omap/include/plat/gpio.h |   29 +-
> >  drivers/gpio/gpio-omap.c               | 1106 +++++++++++++-------------------
> >  7 files changed, 555 insertions(+), 698 deletions(-)
> 
