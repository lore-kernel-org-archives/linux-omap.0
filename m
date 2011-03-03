From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 00/19] OMAP3+: introduce SR class 1.5
Date: Wed, 02 Mar 2011 16:33:18 -0800
Message-ID: <87aahdujox.fsf@ti.com>
References: <1298116918-30744-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:47058 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752734Ab1CCAdV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Mar 2011 19:33:21 -0500
Received: by mail-iw0-f169.google.com with SMTP id 42so622436iwl.14
        for <linux-omap@vger.kernel.org>; Wed, 02 Mar 2011 16:33:20 -0800 (PST)
In-Reply-To: <1298116918-30744-1-git-send-email-nm@ti.com> (Nishanth Menon's
	message of "Sat, 19 Feb 2011 17:31:39 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

Hi Nishanth,

Nishanth Menon <nm@ti.com> writes:

> Hi,
> This series intends to introduce SmartReflex AVS Class 1.5 support which
> is now the recommended AVS class for usage in OMAP3630, OMAP4 an potentially
> in later generation of silicon as well. Smartreflex class 1.5 is a software
> controlled hardware calibration mechanism designed to improve dvfs latencies
> and system performance as well as helping bring in additional benefits to the
> system from h/w perspective. The corresponding patch has details on this class
> and the implementation as well.

In addition to some specific comments given on individual patches, I
a couple of general, nit-picky comments:

- Please capitalize acronyms throughout the
  subjects/comments/changelogs.  This series tends to mix lower-case and
  upper case acronyms

- Please Cc linux-arm-kernel for patches intended for mainline.  Because
  of this, I didn't (yet) queue the ones I said I would queue. 

- Please rebase this on top of my pm-core branch (or Paul's
  integration-2.6.39 branch if you prefer.)  There are some important
  voltage related re-organization happening there that affects your code.

Kevin

> The series eventually results in OMAP343x based platforms using class3 and
> OMAP3630, OMAP4 platforms using class1.5 automatically without modifications
> or additions to board files.
>
> This series is Based on:
> a) k.org 2.6.38-rc5 (b2.6.38-rc5)
> b) The following branches Kevin Hilman's tree: (pm-base)
>  'pm/for_2.6.38/pm-fixes', 'pm/for_2.6.39/pm-misc' and 'pm/pm-wip/cpufreq'
>  http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-pm.git;a=summary
> c) sr-fixes: (sr-baseline)
> 	http://marc.info/?l=linux-omap&m=129783708019505&w=2
> 	http://marc.info/?l=linux-omap&m=129679846322563&w=2
>
> This series is also available at:
> 	git://gitorious.org/linux-omap-nm-sr/linux-omap-sr.git
> 	Branch: sr-1.5-v1
>
> Note: There is also a branch sr-dvfs-1.5 in my tree which contains the test
> version of code which is based off Vishwa's DVFS series which is currently
> being revamped. it may need few handtweaking for testing (esp selecting class
> at menuconfig level or by commenting out appropriate late_init).
>
> The series contains a bunch of bugfixes and improvements needed to introduce
> Smartreflex class 1.5.

> Nishanth Menon (19):
>   omap3: hwmod: add smartreflex irqs
>   omap3630: hwmod: sr: enable for higher ES
>   omap3+: voltage: remove initial voltage
>   omap3+: voltage: remove spurious pr_notice for debugfs
>   omap3+: voltage: use IS_ERR_OR_NULL
>   omap3+: voltage: use volt_data pointer instead values
>   omap3+: voltage: add transdone apis
>   omap3+: sr: make notify independent of class
>   omap3+: sr: introduce class init,deinit and priv data
>   omap3+: sr: fix cosmetic indentation
>   omap3+: sr: call handler with interrupt disabled
>   omap3+: sr: disable interrupt by default
>   omap3+: sr: enable/disable SR only on need
>   omap3+: sr: introduce notifiers flags
>   omap3+: sr: introduce notifier_control
>   omap3+: sr: disable spamming interrupts
>   omap3+: sr: make enable path use volt_data pointer
>   omap3630+: sr: add support for class 1.5
>   omap3430: sr: class3: restrict cpu to run on
>
>  arch/arm/mach-omap2/Makefile                  |    1 +
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c    |   25 +-
>  arch/arm/mach-omap2/pm.c                      |    3 +-
>  arch/arm/mach-omap2/smartreflex-class1p5.c    |  556 +++++++++++++++++++++++++
>  arch/arm/mach-omap2/smartreflex-class3.c      |   21 +-
>  arch/arm/mach-omap2/smartreflex.c             |  249 ++++++++++--
>  arch/arm/mach-omap2/voltage.c                 |  236 ++++++++---
>  arch/arm/plat-omap/Kconfig                    |   17 +
>  arch/arm/plat-omap/include/plat/smartreflex.h |   42 ++-
>  arch/arm/plat-omap/include/plat/voltage.h     |   36 ++-
>  10 files changed, 1062 insertions(+), 124 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/smartreflex-class1p5.c
>
> Testing performed:
> - basic boot tests on SDP3630 and SDP3430 - with bare series
> - Detailed dvfs tests with Viswha's series on SDP3430 and SDP3630
> - OMAP4 was'nt supported yet by dvfs series, so very restricted tests.
> - Build tests with and without each of SR classes, SMARTREFLEX enabled.
>
> Test Script: http://pastebin.mozilla.org/1080985
>
> I request any additional tests on Panda, BeagleXM, EVM platforms that folks
> may have. please feel free to comment and provide tested-by/Acked-by feedback
> before I take this ahead including l-a.
>
> Regards,
> Nishanth Menon
