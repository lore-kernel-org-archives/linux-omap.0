From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 0/2] OMAP clock: implement clock rate/parent change notifiers
Date: Wed, 25 Mar 2009 10:54:15 -0700
Message-ID: <87tz5hwks8.fsf@deeprootsystems.com>
References: <20090325160759.31866.49722.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f118.google.com ([209.85.221.118]:48325 "EHLO
	mail-qy0-f118.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752819AbZCYRyV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Mar 2009 13:54:21 -0400
Received: by qyk16 with SMTP id 16so314151qyk.33
        for <linux-omap@vger.kernel.org>; Wed, 25 Mar 2009 10:54:18 -0700 (PDT)
In-Reply-To: <20090325160759.31866.49722.stgit@localhost.localdomain> (Paul Walmsley's message of "Wed\, 25 Mar 2009 10\:09\:19 -0600")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org

Paul Walmsley <paul@pwsan.com> writes:

> Hello,
>
> This series allows core code and driver code to register for
> notification when a clock's rate or parent changes.  This is currentl=
y
> used by driver code that must be notified whenever power management
> code (e.g., CPUFreq) causes system rate changes that affect the drive=
r's
> clock.

I will be re-basing the PM branch onto today's linux-omap HEAD which
is v2.6.29 based.  As I do this, I'll be dropping all the previous
notifier patches and replacing them with this series.

Kevin

> There are three notifier messages:=20
>
> 1. a pre-change notifier, called before the change;=20
>
> 2. a post-change notifier, called after the change; and
>
> 3. an abort notifier, called if the change fails for any reason after
>    the pre-change notifier callbacks have run.
>
> Since the implementation uses a blocking notifier, notifier code may
> block waiting for devices to quiesce; but long delays here will reduc=
e
> the effectiveness of DVFS.  Since notifier callbacks are called with
> clocks_mutex held, callback code must not re-enter the clock framewor=
k.
>
> Pre-change notifiers are passed the current clock rate and the desire=
d
> clock rate, so drivers can adjust any internal dividers appropriately=
=2E
> (To minimize performance and memory usage impact, post-change
> notifiers are passed only the desired clock rate, i.e., the clock rat=
e
> after the rate change.)  The notifiers are called even if the clock
> rate is the same before and after the change.  This is because
> reprogramming a clock's parent or rate may briefly disrupt the clock.
>
> The interface to the notifiers is via:
>
> int clk_notifier_register(struct clk *clk, struct notifier_block *nb)=
;
> int clk_notifier_unregister(struct clk *clk, struct notifier_block *n=
b);
>
> Until prototypes for these functions are made available in
> include/linux/clk.h, drivers should pass function pointers to
> clk_notifier_register() and clk_notifier_unregister() via their
> platform_data struct.
>
> This series is a collaboration between Tero Kristo
> <tero.kristo@nokia.com> and Paul Walmsley <paul@pwsan.com> and severa=
l
> others. Hiroshi Doyu <Hiroshi.DOYU@nokia.com> tracked down and fixed =
a
> bug where blocking_notifier_chain_*() were called while interrupts
> were disabled.  Nishanth Menon <nm@ti.com> found and fixed a bug in
> the clk_notifier_unregister() path, where a list_del() was missing.
> And thanks to Jouni H=F6gander <jouni.hogander@nokia.com> for comment=
s
> and review during the evolution of these patches.
>
> Registration and callbacks on rate change and parent change tested on
> BeagleBoard (OMAP3530 ES2.1).
>
> Comments welcomed.
>
> ---
>
>    text    data     bss     dec     hex filename
> 3439981  175136  111800 3726917  38de45 vmlinux.beagle.orig
> 3441545  176000  111800 3729345  38e7c1 vmlinux.beagle
>
>
>  arch/arm/mach-omap2/clock.c             |   30 ++++
>  arch/arm/mach-omap2/clock.h             |    1=20
>  arch/arm/mach-omap2/clock24xx.c         |    1=20
>  arch/arm/mach-omap2/clock34xx.c         |    1=20
>  arch/arm/plat-omap/clock.c              |  256 +++++++++++++++++++++=
++++++++++
>  arch/arm/plat-omap/include/mach/clock.h |   68 ++++++++
>  6 files changed, 357 insertions(+), 0 deletions(-)
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
