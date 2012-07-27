From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL] OMAP4 coupled CPUidle support for v3.6
Date: Thu, 26 Jul 2012 17:19:15 -0700
Message-ID: <CAOesGMiTfW6Qz=z4FvG=SomCuKo3C8um1M=uXJV8ZAjeKhRoOg@mail.gmail.com>
References: <87394enqz8.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:50576 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751562Ab2G0ATQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Jul 2012 20:19:16 -0400
Received: by pbbrp8 with SMTP id rp8so4035227pbb.19
        for <linux-omap@vger.kernel.org>; Thu, 26 Jul 2012 17:19:15 -0700 (PDT)
In-Reply-To: <87394enqz8.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: arm@kernel.org, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, ccross@android.com, "Rafael J. Wysocki" <rjw@sisk.pl>

Kevin,

On Thu, Jul 26, 2012 at 2:37 PM, Kevin Hilman <khilman@ti.com> wrote:
> Hi Arnd, Olof,
>
> I know it is late, but I'm really hoping this can still make it for
> v3.6, so consider this a [GIT PLEA].  ;)

New features submitted halfway through the merge window? Yeah, that's late.

I'll pull it in as late2/pm once the below is fixed, but I won't
promise we'll send it up.


> Kevin Hilman (1):
>       ARM: OMAP4: CPUidle: add synchronization for coupled idle states
>
> Santosh Shilimkar (3):
>       ARM: OMAP: timer: allow gp timer clock-event to be used on both cpus
>       ARM: OMAP4: CPUidle: Use coupled cpuidle states to implement SMP cpuidle.
>       ARM: OMAP4: CPUidle: Open broadcast clock-event device.

This looks odd, Colin was author to the first of the commits
attributed to Santosh.


-Olof
