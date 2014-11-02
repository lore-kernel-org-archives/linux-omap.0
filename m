From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL] omap fixes against v3.18-rc2
Date: Sun, 2 Nov 2014 13:39:46 -0800
Message-ID: <20141102213946.GA17643@localhost>
References: <20141030165019.GA31454@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:36552 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751752AbaKBX3F (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 2 Nov 2014 18:29:05 -0500
Received: by mail-pd0-f177.google.com with SMTP id v10so10423852pde.36
        for <linux-omap@vger.kernel.org>; Sun, 02 Nov 2014 15:29:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20141030165019.GA31454@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: arm@kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux@arm.linux.org.uk

On Thu, Oct 30, 2014 at 09:50:20AM -0700, Tony Lindgren wrote:
> The following changes since commit cac7f2429872d3733dc3f9915857b1691da2eb2f:
> 
>   Linux 3.18-rc2 (2014-10-26 16:48:41 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/fixes-against-v3.18-rc2
> 
> for you to fetch changes up to 4b91f7f3c8b20e073b7bfc098625b37f99789508:
> 
>   ARM: OMAP2+: Warn about deprecated legacy booting mode (2014-10-29 12:19:20 -0700)

Thanks, merged.

> 
> ----------------------------------------------------------------
> Few fixes for omaps to enable NAND BCH so devices won't
> produce errors when booted with omap2plus_defconfig, and
> reduce bloat by making IPV6 a loadable module.
> 
> Also let's add a warning about legacy boot being deprecated
> for omap3.
> 
> We now have things working with device tree, and only omap3 is
> still booting in legacy mode. So hopefully this warning will
> help move the remaining legacy mode users to boot with device
> tree.

Hm, I think I saw Russell commenting recently about migrating back from
DT to legacy boot on a 3430 board.

> As the total reduction of code and static data is somewhere
> around 20000 lines of code once we remove omap3 legacy mode
> booting, we really do want to make omap3 to boot also in
> device tree mode only over the next few merge cycles.

Yep, that'd be nice.


-Olof
