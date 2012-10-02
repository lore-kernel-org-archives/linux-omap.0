From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: Beagleboard xM crashes when being set to 800MHz with smartreflex on linux-omap-3.6-rc6
Date: Mon, 01 Oct 2012 17:00:25 -0700
Message-ID: <87391xbv52.fsf@deeprootsystems.com>
References: <5448984682E7954C9BFF27F747A9C6CA56E38E@dolphin.TIGRIS.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:64516 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757723Ab2JBAA1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Oct 2012 20:00:27 -0400
Received: by pbbrr4 with SMTP id rr4so8234597pbb.19
        for <linux-omap@vger.kernel.org>; Mon, 01 Oct 2012 17:00:27 -0700 (PDT)
In-Reply-To: <5448984682E7954C9BFF27F747A9C6CA56E38E@dolphin.TIGRIS.local>
	(Maximilian Schwerin's message of "Fri, 21 Sep 2012 08:45:16 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Maximilian Schwerin <Maximilian.Schwerin@tigris.de>
Cc: linux-omap@vger.kernel.org

"Maximilian Schwerin" <Maximilian.Schwerin@tigris.de> writes:

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

SmartReflex is kwown to be unstable in mainline and there are several
errata that still need fixing for it to be stable.

I strongly recommend you simply leave SR disabled.

Kevin


