From: Steve Sakoman <sakoman@gmail.com>
Subject: Re: omap DSS fails with tft410 driver panel?
Date: Thu, 22 Nov 2012 22:14:42 -0800
Message-ID: <CAGDS+nm2YVNyq+eAF-VSq785KAKWC2GM4v5U7N1vLGTNNDfa7Q@mail.gmail.com>
References: <CAFqH_50PVJdbX0CMwo9t3RuAhzi3q6jcBwzq2R3UFighkrF7iw@mail.gmail.com>
	<CAGDS+nmx8qFSx932TudMN6ikmZ=OGkbvrZuCV=Ump+HETkU-tw@mail.gmail.com>
	<50ADE6A5.3030001@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:35972 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753129Ab2KWGOm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Nov 2012 01:14:42 -0500
Received: by mail-ob0-f174.google.com with SMTP id wc20so8677890obb.19
        for <linux-omap@vger.kernel.org>; Thu, 22 Nov 2012 22:14:42 -0800 (PST)
In-Reply-To: <50ADE6A5.3030001@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Enric Balletbo Serra <eballetbo@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@dowhile0.org>

On Thu, Nov 22, 2012 at 12:47 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:

>> I'll add the printk's to omapfb_setup_plane() that were requested by
>> Tomi and report back.

Today was a holiday, so family obligations didn't allow much time to
look at this.

I did however do a quick build with some printk's in
omapfb_setup_plane() so I could narrow down where to start looking.

I discovered that the error (omapdss OVERLAY error: check_overlay:
paddr cannot be 0) is happening as a result of the
ovl->set_overlay_info() call in the else clause of the code below:

    if (pi->enabled) {
        r = omapfb_setup_overlay(fbi, ovl, pi->pos_x, pi->pos_y,
            pi->out_width, pi->out_height);
        if (r) {
            printk("omapfb_setup_plane: pi->enabled &
omapfb_setup_overlay()\n");
            goto undo;
        }
    } else {
        struct omap_overlay_info info;

        ovl->get_overlay_info(ovl, &info);

        info.pos_x = pi->pos_x;
        info.pos_y = pi->pos_y;
        info.out_width = pi->out_width;
        info.out_height = pi->out_height;

        r = ovl->set_overlay_info(ovl, &info);
        if (r) {
            printk("omapfb_setup_plane: !pi->enabled &
ovl->set_overlay_info failed\n");
            goto undo;
        }
    }

I'll look at this more over as I get time over the coming days.

> How can I reproduce this? Is there a downloadable rootfs somewhere that
> I could try?

The only downloadable rootfs I have is 3.5 based.  I'll try to get a
3.6 image posted in the next couple of days.

> Could you also copy full kernel boot log to pastebin or such?

OK, will do that with my next build.  I'll assume you want dss
debugging enabled for that.

Steve
