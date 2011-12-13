From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL] Two non-critical DMA fixes for v3.3 merge window
Date: Tue, 13 Dec 2011 14:40:04 -0800
Message-ID: <CAOesGMgzbPSSfGZnaaLt3utjxVG82WCb8hEfbTzkcwqr3SXhfg@mail.gmail.com>
References: <20111212224648.GI32251@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:55516 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755979Ab1LMWkF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Dec 2011 17:40:05 -0500
Received: by yenm11 with SMTP id m11so140346yen.19
        for <linux-omap@vger.kernel.org>; Tue, 13 Dec 2011 14:40:04 -0800 (PST)
In-Reply-To: <20111212224648.GI32251@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi,

On Mon, Dec 12, 2011 at 2:46 PM, Tony Lindgren <tony@atomide.com> wrote:
> Hi Arnd & Olof,
>
> Please pull two non-critical DMA fixes from:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap fixes-non-critical
>
> These are workarounds for corner cases. There's no rush
> to get them in during the -rc cycle, these are fixes for
> features that never worked before.

Thanks, pulled into next/fixes-non-critical (to avoid confusion with
the plain fixes branch for 3.2-rc).


-Olof
