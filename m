From: jean-philippe francois <jp.francois@cynove.com>
Subject: Re: Strange OMAP3 LCD display regression - bisected.
Date: Mon, 3 Jun 2013 10:13:18 +0200
Message-ID: <CAGGh5h0ZsY0J4o6TbMDjD+kOs94SqkFv4gxEhQLgiX9ihdYnPA@mail.gmail.com>
References: <20130602165019.655da2eb@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f169.google.com ([74.125.82.169]:58009 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751312Ab3FCINU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Jun 2013 04:13:20 -0400
Received: by mail-we0-f169.google.com with SMTP id n57so324912wev.28
        for <linux-omap@vger.kernel.org>; Mon, 03 Jun 2013 01:13:18 -0700 (PDT)
In-Reply-To: <20130602165019.655da2eb@notabene.brown>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: linux-omap <linux-omap@vger.kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Rajendra Nayak <rnayak@ti.com>, Mike Turquette <mturquette@ti.com>, Paul Walmsley <paul@pwsan.com>

2013/6/2 NeilBrown <neilb@suse.de>:
>
> Hi Tomi, Rajendra and other,
>  I have run into a rather strange regression with the LCD panel displ=
ay on my
>  GTA04 (OMAP3630 based phone) that you might be able to help me with.
>
>  I bisected down to two patches, neither of which cause the problem b=
y
>  themselves, but both together do.
>
>  They are:
>
> commit bd0f5cc3641cb76ae8fa2cc4924c29da157f8b2d
> Author: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Date:   Thu Dec 13 14:21:30 2012 +0200
>
>     OMAPDSS: fix TV-out issue with DSI PLL
>
> and
>
> commit f7f73aab3d5bd19ba0f72ff00fb6b3be28e1a4d3
> Author: Rajendra Nayak <rnayak@ti.com>
> Date:   Fri Apr 27 16:27:51 2012 +0530
>
>     ARM: OMAP: clock: Switch to COMMON clk
>
>
> Yes - rather odd.
>

Does this patch solve your issue ?

https://patchwork.kernel.org/patch/2634161/

Regards,
Jean-Philippe Fran=C3=A7ois

> The details:
>  I'm currently trying to move from a 3.7 kernel on my GTA04 to a 3.10=
-rc
>  kernel (hopefully to have 3.10 fully working by the time it comes ou=
t..).
>
>  Once I got it compiling and booting I found that while the display w=
orked
>  perfectly at boot, after it has been turned off (ioctl(FBIOBLANK)) a=
nd back
>  on again, it is all white - no discernible image at all.
>  A suspend/resume cycle at this point might bring it back, but it is =
often
>  shimmery (low vsync?) and once it had inverse colours.
>
>  I had noticed that the panel which normally gets a 22153 kHz pixel c=
lock was
>  only getting a 21600 kHz clock.  This turned out to be due to the fa=
ct
>  that dpi_calc_dispc_cb rejects odd divisors, and it used to use a di=
visor of
>  '3'.
>
>
>  I disabled that code and then the screen would wake successfully res=
ume from
>  blank, but there was a strange artefact in the image.  My display ha=
s a grey
>  background with some blue text.  On the lines that have text, the gr=
ey
>  background had a very slight green tinge, especially when viewed at =
the
>  right angle.
>
>  I decided to try bisecting to find the cause of this, because I coul=
dn't
>  even begin to guess what it might be.  I found:
>
> commit 2b8318881ddbcb67c5e8d2178b42284749442222
> Merge: e81d372 e7f5c9a
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Sat Dec 15 13:03:48 2012 -0800
>
>     Merge tag 'fbdev-for-3.8' of git://gitorious.org/linux-omap-dss2/=
linux
>
>     Pull fbdev changes from Tomi Valkeinen:
>      "OMAPDSS changes, including:
>
>
>  yes - a merge commit. Neither branch by itself caused the problem bu=
t the two
>  together do.
>  I then decided "in for a penny, in for a pound" and proceeded to bis=
ect both
>  branches, merging in the other one at each test point.
>  This lead me to the two commits listed above.
>
>   bd0f5cc3641cb76 merged with e81d372 has the problem,
>   bd0f5cc3641cb76~1 merged with e81d372 is fine.
>
>  Similarly
>   f7f73aab3d5bd19b merged with e7f5c9a has the problem, while
>   f7f73aab3d5bd19b~1 merged with e7f5c9a is fine.
>
>  I tried reverting the "OMAPDSS: fix TV-out issue with DSI PLL" patch=
 from
>  3.10-rc as below, and it seems to behave better, returning from blan=
k
>  properly. This is without disabling the "no odd divisors" code.
>  I'm not really sure how it survives suspend, as suspend generally is=
n't
>  reliable for me on 3.10-rc yet - haven't look into why as yet.
>
>  Any help anyone could provide here would be greatly appreciated.  I'=
m happy
>  to run any test patches you would like to suggest.
>
> Thanks,
> NeilBrown
>
>
>
> diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/=
dpi.c
> index 757b57f..4d4f775 100644
> --- a/drivers/video/omap2/dss/dpi.c
> +++ b/drivers/video/omap2/dss/dpi.c
> @@ -62,7 +62,7 @@ static struct platform_device *dpi_get_dsidev(enum =
omap_channel channel)
>         case OMAPDSS_VER_OMAP34xx_ES3:
>         case OMAPDSS_VER_OMAP3630:
>         case OMAPDSS_VER_AM35xx:
> -               return NULL;
> +//             return NULL;
>
>         case OMAPDSS_VER_OMAP4430_ES1:
>         case OMAPDSS_VER_OMAP4430_ES2:
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
