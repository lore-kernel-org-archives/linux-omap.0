From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [GIT PULL 2/6] omap pdata and dt preparation changes for v3.13 merge window
Date: Mon, 14 Oct 2013 15:34:23 -0700
Message-ID: <87iowz4h3k.fsf@linaro.org>
References: <5258a9a2.c6b9e50a.3704.5f61SMTPIN_ADDED_MISSING@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:33783 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757399Ab3JNWe1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Oct 2013 18:34:27 -0400
Received: by mail-pd0-f179.google.com with SMTP id v10so7945082pde.24
        for <linux-omap@vger.kernel.org>; Mon, 14 Oct 2013 15:34:27 -0700 (PDT)
In-Reply-To: <5258a9a2.c6b9e50a.3704.5f61SMTPIN_ADDED_MISSING@mx.google.com>
	(Tony Lindgren's message of "Fri, 11 Oct 2013 18:44:57 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: arm@kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Tony Lindgren <tony@atomide.com> writes:

> The following changes since commit d0e639c9e06d44e713170031fe05fb60ebe680af:
>
>   Linux 3.12-rc4 (2013-10-06 14:00:20 -0700)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.13/quirk-signed
>
> for you to fetch changes up to 8d71528343c69ce387bd5fdb4fd8dc2b9f69d97c:
>
>   ARM: configs: omap2plus_defconfig: enable dwc3 and dependencies (2013-10-11 15:41:25 -0700)
>
> ----------------------------------------------------------------
> Changes needed to prepare for making omap3 device tree only:
>
> - Always build in board-generic, and add pdata quirks and auxdata
>   support for it so we have all the pdata related quirks
>   in the same place.
>
> - Merge of the drivers/pinctrl changes that are needed for PM
>   to continue working on omap3 and also needed for other omaps
>   eventually. The three pinctrl related patches have been acked
>   by Linus Walleij and are pulled into both the pinctrl tree
>   and this branch.
>
> - Few defconfig related changes for drivers needed.
>
> ----------------------------------------------------------------

Thanks, pulled into next/dt.

Kevin
