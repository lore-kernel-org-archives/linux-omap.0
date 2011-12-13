From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL] omap hsmmc platform code changes for v3.3 merge window
Date: Tue, 13 Dec 2011 14:39:27 -0800
Message-ID: <CAOesGMgeD9tuN8RgRCMg951Pyvo-NDt6Bsmptt4E8tBM38GM1w@mail.gmail.com>
References: <20111212223234.GH32251@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:61070 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755979Ab1LMWj2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Dec 2011 17:39:28 -0500
Received: by yhr47 with SMTP id 47so833899yhr.19
        for <linux-omap@vger.kernel.org>; Tue, 13 Dec 2011 14:39:28 -0800 (PST)
In-Reply-To: <20111212223234.GH32251@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Mon, Dec 12, 2011 at 2:32 PM, Tony Lindgren <tony@atomide.com> wrote:
> Hi Arnd & Olof,
>
> Please pull omap hsmmc platform code changes from:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap hsmmc
>
> Ideally arch/arm/mach-omap2/hsmmc.c file will completely
> disappear with device tree, but looks like we're still
> some more patches away from that. Meanwhile, these are
> needed for various board files.

Thanks, pulled into next/drivers.


-Olof
