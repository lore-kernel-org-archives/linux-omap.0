From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [GIT PULL] few fixes for the v3.19 merge window
Date: Mon, 15 Dec 2014 14:44:00 -0800
Message-ID: <7hvblcfs9b.fsf@deeprootsystems.com>
References: <20141210205752.GB12921@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:34148 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751197AbaLOWoE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Dec 2014 17:44:04 -0500
Received: by mail-pd0-f171.google.com with SMTP id y13so12602495pdi.30
        for <linux-omap@vger.kernel.org>; Mon, 15 Dec 2014 14:44:02 -0800 (PST)
In-Reply-To: <20141210205752.GB12921@atomide.com> (Tony Lindgren's message of
	"Wed, 10 Dec 2014 12:57:52 -0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: arm@kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Tony Lindgren <tony@atomide.com> writes:

> The following changes since commit a0e4467726cd26bacb16f13d207ffcfa82ffc07d:
>
>   Merge tag 'asm-generic-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic (2014-12-09 17:25:00 -0800)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.19/fixes-for-merge-window
>
> for you to fetch changes up to 661ea91b676bcca137c1c3fe838997925ce98060:
>
>   ARM: omap2plus_defconfig: Enable AHCI_PLATFORM driver (2014-12-10 09:33:50 -0800)
>
> ----------------------------------------------------------------
> Fixes for a few issues found that would be good to get
> into -rc1:
>
> - Update SoC revision detection for am43x es1.2
>
> - Fix regression with GPMC timings on 2430sdp for some versions
>   of u-boot
>
> - Fix dra7 watchdog compatible property
>
> - Fix am437x-sk-evm LCD timings
>
> - Fix dra7 DSS clock muxing
>
> - Fix dra7-evm voltages
>
> - Remove a unused function prototype for am33xx_clk_init
>
> - Enable AHCI in the omap2plus_defconfig
>
> ----------------------------------------------------------------

Pulled into fixes.

Not sure yet if this will make it before -rc1 or not.  I think Arnd has
a couple more pull requests outstanding, so he may be able to include
this before -rc1.  Otherwise, it may wait until the after -rc1.

Kevin
