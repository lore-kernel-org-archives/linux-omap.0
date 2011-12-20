From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL] omap prcm changes for v3.3 merge window
Date: Mon, 19 Dec 2011 21:33:59 -0800
Message-ID: <CAOesGMiB-Mh-_GvgqPjebVx8VC8Hu6OfvkYkdQoZh6eEiGEWnQ@mail.gmail.com>
References: <20111219200046.GS6464@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:45287 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751688Ab1LTFeA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Dec 2011 00:34:00 -0500
Received: by yhr47 with SMTP id 47so4490416yhr.19
        for <linux-omap@vger.kernel.org>; Mon, 19 Dec 2011 21:33:59 -0800 (PST)
In-Reply-To: <20111219200046.GS6464@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Mon, Dec 19, 2011 at 12:00 PM, Tony Lindgren <tony@atomide.com> wrote:
> Hi Arnd & Olof,
>
> Please pull omap prcm changes from:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap prcm
>
> These changes adds support for PRCM (Power, Reset, Clock, Module)
> chained interrupt handling. This will eventually allow us to start
> making PM parts into driver modules and move them out of arch/arm.
>
> These are also needed for the serial port runtime PM patches that
> I'll post a pull request for after this.
>
> Note that these have a slight dependency to the previously merged
> omap4 branch so it would produce a minor merge conflict if based
> on something earlier. However, the following uart branch has a
> dependency to both omap4 branch and this branch, so I've based
> this on omap4 branch also.

Thanks, pulled into next/pm.


-Olof
