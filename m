From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL 1/3] omap plat header removal for v3.8 merge window,
 part2
Date: Mon, 5 Nov 2012 10:11:07 -0800
Message-ID: <20121105181107.GA22301@quad.lixom.net>
References: <508affc9.8f07320a.16f0.0ac0SMTPIN_ADDED@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:32904 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754424Ab2KESLC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Nov 2012 13:11:02 -0500
Received: by mail-pa0-f46.google.com with SMTP id hz1so4108244pad.19
        for <linux-omap@vger.kernel.org>; Mon, 05 Nov 2012 10:11:01 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <508affc9.8f07320a.16f0.0ac0SMTPIN_ADDED@mx.google.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Oct 26, 2012 at 02:23:39PM -0700, Tony Lindgren wrote:
> The following changes since commit 3e9a6321f9895eac9a3d241d3126e44021e7102b:
> 
>   Merge tag 'omap-for-v3.8/cleanup-headers-signed' into omap-for-v3.8/cleanup-headers-serial-take2 (2012-10-24 13:25:44 -0700)
> 
> are available in the git repository at:
> 
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.8/cleanup-headers-serial-take2-signed
> 
> for you to fetch changes up to 3d82cbbb3aadb4f8a30e3f614e51be96574a0855:
> 
>   ARM: OMAP: Split plat/serial.h for omap1 and omap2+ (2012-10-24 13:34:31 -0700)
> 
> ----------------------------------------------------------------
> These changes remove plat/serial.h usage for omap2+.
> 
> Note that this branch is based on a tty commit 3e9a6321
> (tty/serial/8250: Make omap hardware workarounds local to 8250.h)
> merged with omap-for-v3.8/cleanup-headers-signed.
> 
> The tty commit is needed to keep things compiling for omaps,
> and omap-for-v3.8/cleanup-headers-signed is needed to avoid
> multiple merge conflicts with the includes. I've verified
> with Greg KH that the tty commit above is immutable and OK
> to use as a base.

Thanks, pulled into next/headers, and I kept an explicit dependency on Greg's
tree as depends/tty so we can keep track of it.


-Olof
