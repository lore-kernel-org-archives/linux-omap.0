From: Joni Lapilainen <joni.lapilainen@gmail.com>
Subject: Re: Beagleboard xM crashes when being set to 800MHz with smartreflex
 on linux-omap-3.6-rc6
Date: Fri, 21 Sep 2012 11:34:37 +0300
Message-ID: <CAOSRfZ7cgAwP62QvhqEdKTk73AznCGM=ajVmYcb+96jswDdfBg@mail.gmail.com>
References: <5448984682E7954C9BFF27F747A9C6CA56E38E@dolphin.TIGRIS.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:42396 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754481Ab2IUIei (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Sep 2012 04:34:38 -0400
Received: by eekc1 with SMTP id c1so1307922eek.19
        for <linux-omap@vger.kernel.org>; Fri, 21 Sep 2012 01:34:37 -0700 (PDT)
In-Reply-To: <5448984682E7954C9BFF27F747A9C6CA56E38E@dolphin.TIGRIS.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Maximilian Schwerin <Maximilian.Schwerin@tigris.de>
Cc: linux-omap@vger.kernel.org

On Fri, Sep 21, 2012 at 9:45 AM, Maximilian Schwerin
<Maximilian.Schwerin@tigris.de> wrote:
> Hi,
>
> I've just built a linux-omap kernel at 3.6-rc6 using omap2plus_defconfig
> as basis for the kernel config.
>
> When I enable smartreflex and switch to 800MHz via
>
> echo 1 > /sys/kernel/debug/smartreflex/smartreflex_core/autocomp
> echo 1 > /sys/kernel/debug/smartreflex/smartreflex_mpu_iva/autocomp
> cpufreq-set -f 800MHz
>
> the board crashes. If I switch to 800MHz and enable smartreflex later
> nothing happens. This used to work in my 3.3 based kernel.
>
> Regards, Maximilian

Also happens with N900 when changing frequency.

-JL
