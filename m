From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [GIT PULL] gpio/omap: fix fallout from last cleanup series
Date: Fri, 18 May 2012 16:19:58 -0600
Message-ID: <CACxGe6tK+rvm-hYYOMjtOs=0xeNdQvP3wM900iPvEnZZo-3Lkw@mail.gmail.com>
References: <87vcjtkuck.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:56064 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756477Ab2ERWUT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 May 2012 18:20:19 -0400
Received: by pbbrp8 with SMTP id rp8so4491322pbb.19
        for <linux-omap@vger.kernel.org>; Fri, 18 May 2012 15:20:19 -0700 (PDT)
In-Reply-To: <87vcjtkuck.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

On Fri, May 18, 2012 at 4:16 PM, Kevin Hilman <khilman@ti.com> wrote:
> Hi Grant,
>
> Here's the promised branch that fixes the fallout from the last clean=
up
> series which introduced a few new bugs in the cleanup. :(
>
> I collected the acks/tested-bys from the list.

Merged,
thanks.

g.

>
> Thanks,
>
> Kevin
>
>
> The following changes since commit 1b1287032df3a69d3ef9a486b444f4ffcc=
a50d01:
>
> =A0gpio/omap: fix missing check in *_runtime_suspend() (2012-05-11 17=
:08:40 -0700)
>
> are available in the git repository at:
>
> =A0git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-p=
m.git for_3.5/fixes/gpio-2
>
> for you to fetch changes up to b3c64bc30af67ed328a8d919e41160942b8704=
51:
>
> =A0gpio/omap: (re)fix wakeups on level-triggered GPIOs (2012-05-18 07=
:05:06 -0700)
>
> ----------------------------------------------------------------
> Kevin Hilman (2):
> =A0 =A0 =A0gpio/omap: fix broken context restore for non-OFF mode tra=
nsitions
> =A0 =A0 =A0gpio/omap: (re)fix wakeups on level-triggered GPIOs
>
> =A0drivers/gpio/gpio-omap.c | =A0 =A09 ++++-----
> =A01 file changed, 4 insertions(+), 5 deletions(-)



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
