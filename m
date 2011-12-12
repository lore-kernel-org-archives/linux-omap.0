From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL] PM support for omap4 for v3.3 merge window
Date: Sun, 11 Dec 2011 18:10:40 -0800
Message-ID: <CAOesGMjCJpG7-t9dfnVkg7hh_1EqkK3FxxLvh7AU0xnp7Xz5vQ@mail.gmail.com>
References: <20111209212155.GZ31337@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:55726 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752743Ab1LLCKk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 11 Dec 2011 21:10:40 -0500
Received: by mail-yx0-f174.google.com with SMTP id m11so3353624yen.19
        for <linux-omap@vger.kernel.org>; Sun, 11 Dec 2011 18:10:40 -0800 (PST)
In-Reply-To: <20111209212155.GZ31337@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Fri, Dec 9, 2011 at 1:21 PM, Tony Lindgren <tony@atomide.com> wrote:
> Hi Arnd & Olof,
>
> Please pull omap4 PM support from:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap omap4
>
> Note that because of the map_io and common.h changes this is based
> on commit deee6d5359969a0ce4e2760cfd7b9f379bd5698a in Russell's
> devel-stable.
>
> FYI, other omap SoC related changes that I'll post later will have a
> build dependency to this series for the omap-secure.c changes.

Thanks, pulled into next/pm.


-Olof
