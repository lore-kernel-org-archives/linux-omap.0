From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [GIT PULL] gpio/omap: more fixes for v3.4
Date: Fri, 23 Mar 2012 08:49:18 +0000
Message-ID: <CACxGe6vvDLVyirAxFw6JxaZYNzWSr1Z6cVgfnJS4+Sna1EZ+1g@mail.gmail.com>
References: <871uok5pk0.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:35946 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757089Ab2CWItj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Mar 2012 04:49:39 -0400
Received: by obbeh20 with SMTP id eh20so2228188obb.19
        for <linux-omap@vger.kernel.org>; Fri, 23 Mar 2012 01:49:38 -0700 (PDT)
In-Reply-To: <871uok5pk0.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, tarun.kanti@ti.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

On Thu, Mar 22, 2012 at 8:49 PM, Kevin Hilman <khilman@ti.com> wrote:
> Hi Grant,
>
> Please pull these OMAP GPIO fixes for v3.4. =A0These fix some rather
> serious regressions introduced by the cleanup and runtime PM conversi=
on
> series which is also queued for v3.4. =A0This branch is based on your
> gpio/next branch.
>
> This version is functionally the same as the version you previously
> merged (and I asked you to back it out), but this version has some
> better changlogs, and I added reviewed-by and s-o-b from me as well.
>
> Thanks,
>
> Kevin

Merged, thanks.

g.

>
>
>
> The following changes since commit 81b279d80a63628e580c71a31d30a8c3b3=
047ad4:
>
> =A0gpio/davinci: fix enabling unbanked GPIO IRQs (2012-03-12 11:53:33=
 -0600)
>
> are available in the git repository at:
>
> =A0git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-p=
m.git for_3.4/fixes/gpio-2
>
> for you to fetch changes up to 7fcca715de3438b8fc3c8a144702f3a95c8ff6=
3c:
>
> =A0gpio/omap: fix redundant decoding of gpio offset (2012-03-21 10:21=
:24 +0530)
>
> ----------------------------------------------------------------
> Tarun Kanti DebBarma (7):
> =A0 =A0 =A0gpio/omap: fix wakeup_en register update in _set_gpio_wake=
up()
> =A0 =A0 =A0gpio/omap: fix trigger type to unsigned
> =A0 =A0 =A0gpio/omap: fix _set_gpio_irqenable implementation
> =A0 =A0 =A0gpio/omap: fix missing dataout context save in _set_gpio_d=
ataout_reg
> =A0 =A0 =A0gpio/omap: fix incorrect context restore logic in omap_gpi=
o_runtime_*
> =A0 =A0 =A0gpio/omap: fix incorrect update to context.irqenable1
> =A0 =A0 =A0gpio/omap: fix redundant decoding of gpio offset
>
> =A0drivers/gpio/gpio-omap.c | =A0 47 ++++++++++++++++++++++++--------=
--------------
> =A01 file changed, 25 insertions(+), 22 deletions(-)



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
