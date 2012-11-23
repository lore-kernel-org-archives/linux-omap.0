From: Steve Sakoman <sakoman@gmail.com>
Subject: Re: omap DSS fails with tft410 driver panel?
Date: Fri, 23 Nov 2012 07:20:04 -0800
Message-ID: <CAGDS+nncx71OL7tiwEot6RcyFxipj_SVg=z5Sg-Qdv2n4iyL2A@mail.gmail.com>
References: <CAFqH_50PVJdbX0CMwo9t3RuAhzi3q6jcBwzq2R3UFighkrF7iw@mail.gmail.com>
	<CAGDS+nmx8qFSx932TudMN6ikmZ=OGkbvrZuCV=Ump+HETkU-tw@mail.gmail.com>
	<50ADE6A5.3030001@ti.com>
	<CAGDS+nm2YVNyq+eAF-VSq785KAKWC2GM4v5U7N1vLGTNNDfa7Q@mail.gmail.com>
	<50AF37EA.3080400@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:46927 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752013Ab2KWPUF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Nov 2012 10:20:05 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so8963365oag.19
        for <linux-omap@vger.kernel.org>; Fri, 23 Nov 2012 07:20:05 -0800 (PST)
In-Reply-To: <50AF37EA.3080400@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Enric Balletbo Serra <eballetbo@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@dowhile0.org>

On Fri, Nov 23, 2012 at 12:46 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:


> Ok, so hmm... So the overlay is disabled, and the paddr is zero. Can you
> put a printk at dss/apply.c:dss_olv_set_info, and print ovl->id and
> info->paddr? And perhaps also to omapfb-main.c:omapfb_setup_overlay, at
> the point where it sets info.paddr, as I think that's the only place
> where omapfb sets paddr.

OK, did that and here is what I get when starting up gdm, prior to
that all is normal

root@omap3-multi:~# systemctl start gdm.service
Starting Gnome Display Manager...
Started Gnome Display Manager                                          [  OK  ]
root@omap3-multi:~# [   83.475128] omapfb_setup_plane entry
[   83.479492] setup_overlay 0, posx 0, posy 0, outw 1024, outh 768
[   83.485809] omapfb_setup_overlay: setting info.paddr = 9f400000
[   83.492431] dss_ovl_set_info entry
[   83.496307]     ovl->id = 0
[   83.499267]     info->paddr = 9f400000
[   83.503601] omapfb_setup_plane: return success
[   83.508697] omapfb_setup_plane entry
[   83.513153] dss_ovl_set_info entry
[   83.516723]     ovl->id = 2
[   83.520111]     info->paddr = 0
[   83.523406] omapdss OVERLAY error: check_overlay: paddr cannot be 0
[   83.530426] omapfb_setup_plane: !pi->enabled & ovl->set_overlay_info
[   83.537414] dss_ovl_set_info entry
[   83.540985]     ovl->id = 2
[   83.544250]     info->paddr = 0
[   83.547546] omapdss OVERLAY error: check_overlay: paddr cannot be 0

<repeats  as X dies and restarts>

> I don't know what's going on there, why the paddr is suddenly zero.
> Looking at the log from Enric, SETUP_PLANE works fine just fine, and
> then, for no reason, next SETUP_PLANE fails, and the log doesn't show
> anything much happening between.
>
> However, I think omapdss may have been more permissive in the past,
> allowing paddr 0 if the overlay is disabled. I could add that back, but
> I'd rather first understand what's happening here.

>From the above it seems that the first SETUP_PLANE is for ovl->id = 0
and then those that fail are for ovl->id =2.

No idea what is going on in user space, but maybe this will mean
something to you :-)

Steve
