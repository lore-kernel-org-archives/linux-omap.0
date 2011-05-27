From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 2/2] GPIO: OMAP: move to drivers/gpio
Date: Fri, 27 May 2011 09:04:37 -0700
Message-ID: <877h9c2kq2.fsf@ti.com>
References: <1305898868-9188-1-git-send-email-khilman@ti.com>
	<1305898868-9188-3-git-send-email-khilman@ti.com>
	<20110527073529.GF31953@ponder.secretlab.ca>
	<BANLkTinqEM-iDhgSMAnMB5uehkt=V1Qq+w@mail.gmail.com>
	<87pqn4404t.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:60638 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750774Ab1E0QEl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 May 2011 12:04:41 -0400
Received: by mail-pz0-f52.google.com with SMTP id 35so1136871pzk.11
        for <linux-omap@vger.kernel.org>; Fri, 27 May 2011 09:04:40 -0700 (PDT)
In-Reply-To: <87pqn4404t.fsf@ti.com> (Kevin Hilman's message of "Fri, 27 May
	2011 08:46:26 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linux-omap@vger.kernel.org, Linus Walleij <linus.walleij@stericsson.com>, linux-arm-kernel@lists.infradead.org

Kevin Hilman <khilman@ti.com> writes:

[...]

>
> OK, I rebased onto RMK's for-linus branch (already pulled by Linus),
> which contained some other changes touching gpio.c.    I also s/_/-/ in
> the filename.
>
> Below is pull request.

BTW, apologies for the ssh URL.  I used it because I just pushed it, and
wanted to be sure you didn't have to wait for the mirrors.

Kevin

> The following changes since commit 9a55d9752d8abfc62f1ab05ccc790d22a0c8e7c0:
>
>   Merge branch 'devel-stable' into for-linus (2011-05-23 19:28:04 +0100)
>
> are available in the git repository at:
>
>   ssh://master.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git for_2.6.40/gpio-move
>
> Kevin Hilman (2):
>       GPIO: OMAP: move register offset defines into <plat/gpio.h>
>       GPIO: OMAP: move to drivers/gpio
>
>  arch/arm/plat-omap/Makefile                        |    2 +-
>  arch/arm/plat-omap/include/plat/gpio.h             |  103 +++++++++++++++++++
>  drivers/gpio/Makefile                              |    1 +
>  .../plat-omap/gpio.c => drivers/gpio/gpio-omap.c   |  105 --------------------
>  4 files changed, 105 insertions(+), 106 deletions(-)
>  rename arch/arm/plat-omap/gpio.c => drivers/gpio/gpio-omap.c (93%)
