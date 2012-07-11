From: Kevin Hilman <khilman@ti.com>
Subject: Re: suspend broken on 3.5-rc1?
Date: Wed, 11 Jul 2012 14:42:57 -0700
Message-ID: <87mx36ht3y.fsf@ti.com>
References: <4FD1D570.1010508@ti.com> <20120608105611.GO12766@atomide.com>
	<4FD1EF25.3060906@ti.com> <1339160732.2091.47.camel@sokoban>
	<4FD1FB47.8040007@ti.com> <4FD72FB7.60905@ti.com>
	<CALLhW=5HUJuUbEoz7GXJ3h75iqB_9_bNrofBU45zKQejkKExAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:35029 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755102Ab2GKVm5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 Jul 2012 17:42:57 -0400
Received: by pbbrp2 with SMTP id rp2so2631329pbb.28
        for <linux-omap@vger.kernel.org>; Wed, 11 Jul 2012 14:42:56 -0700 (PDT)
In-Reply-To: <CALLhW=5HUJuUbEoz7GXJ3h75iqB_9_bNrofBU45zKQejkKExAQ@mail.gmail.com>
	(Omar Ramirez Luna's message of "Wed, 11 Jul 2012 16:06:06 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Omar Ramirez Luna <omar.luna@linaro.org>
Cc: Rajendra Nayak <rnayak@ti.com>, t-kristo@ti.com, Tony Lindgren <tony@atomide.com>, loml <linux-omap@vger.kernel.org>

Omar Ramirez Luna <omar.luna@linaro.org> writes:

> On 12 June 2012 07:01, Rajendra Nayak <rnayak@ti.com> wrote:

[...]

>> ..anyone knows of any more fixes going around?
>
> I'm seeing the same thing, it gets stuck trying to enable CPU1, tried
> this with pm-20120710 from linux-omap-pm and current LO master (based
> on 3.5-rc6), also using a Panda 4460.

When reporing problems like this, it is greatly helpful to report your
defconfig (specifically, any changes from omap2plus_defconfig.)

Specifically, do you have CONFIG_MFD_OMAP_USB_HOST in your defconfig?
There are known bugs that cause the USB host driver to hang suspend in
mainline.  Because of this, and the fact that the USB developers did not
fix try to this for v3.5, current l-o master (and my pm branch) now have
this disabled by default in omap2plus_defconfig.

> Would appreciate patches if any.

If it's the USB host problem you need fixed, Russ Dill has posted a
couple patches and Keshava has posted a bigger revert, but there hasn't
been any conclusion on the fix yet.

Can you try to reproduce with omap2plus_defconfig (+ DMA engine if you
need MMC rootfs.)

With omap2plus_defconfig + initramfs and omap2plus_defconfig + DMAengine
for MMC rootfs, this is working fine for me on my 4430 Panda using RTC
wakeups:

# rtcwake -m mem -s 1
wakeup from "mem" at Sun Jan  2 23:02:35 2000
[   81.642883] PM: Syncing filesystems ... done.
[   81.651214] Freezing user space processes ... (elapsed 0.02 seconds) done.
[   81.683746] Freezing remaining freezable tasks ... (elapsed 0.02 seconds) done.
[   81.714965] Suspending console(s) (use no_console_suspend to debug)
[   81.731903] PM: suspend of devices complete after 8.179 msecs
[   81.733520] PM: late suspend of devices complete after 1.556 msecs
[   81.736175] PM: noirq suspend of devices complete after 2.655 msecs
[   81.736206] Disabling non-boot CPUs ...
[   81.738739] CPU1: shutdown
[   83.134338] Successfully put all powerdomains to target state
[   83.134552] Enabling non-boot CPUs ...
[   83.136352] CPU1: Booted secondary processor
[   83.136932] CPU1 is up
[   83.138336] PM: noirq resume of devices complete after 1.373 msecs
[   83.140014] PM: early resume of devices complete after 1.007 msecs
[   83.544158] PM: resume of devices complete after 404.144 msecs
[   83.608337] Restarting tasks ... done.

Kevin
