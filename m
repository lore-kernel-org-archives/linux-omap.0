From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: DSS2 DSI Sync
Date: Fri, 20 Nov 2009 15:53:08 +0200
Message-ID: <1258725188.32674.45.camel@tubuntu.research.nokia.com>
References: <bdad095e0911171511tf66f3c7v8f60dd508fa0995d@mail.gmail.com>
	 <1258535499.2419.76.camel@tubuntu.research.nokia.com>
	 <bdad095e0911180439w34d4c1a7ye5c2c885cb219dd1@mail.gmail.com>
	 <1258550758.2419.121.camel@tubuntu.research.nokia.com>
	 <bdad095e0911180648k5060ea38sec44f16cb0eb7d61@mail.gmail.com>
	 <1258556689.2419.134.camel@tubuntu.research.nokia.com>
	 <bdad095e0911180820l6c72ea7an5b0d688513754459@mail.gmail.com>
	 <1258717256.32674.16.camel@tubuntu.research.nokia.com>
	 <bdad095e0911200529s303a0321vc042e25798a6f0c4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:26167 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750989AbZKTNxd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Nov 2009 08:53:33 -0500
In-Reply-To: <bdad095e0911200529s303a0321vc042e25798a6f0c4@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Steven Fischer <steven.fischer@motorola.com>
Cc: Linux-Omap <linux-omap@vger.kernel.org>

On Fri, 2009-11-20 at 14:29 +0100, ext Steven Fischer wrote:
> 
> 
> On Fri, Nov 20, 2009 at 5:40 AM, Tomi Valkeinen
> <tomi.valkeinen@nokia.com> wrote:

>         Just out of interest, may I ask why you are not using omapfb?
>         Are you
>         using V4L2 driver from TI?
>         
>         
> For the graphic plane, we don't use the "omapfb" code as an
> optimization.  We have a shorter path which is being used.  For the
> video planes, we have a V4L2 overlay driver we wrote.  It is based on
> the V4L2 driver from TI, but we found the TI driver had some gaps, so
> we wrote our own.

You can configure omapfb to use only one framebuffer. Was there some
spesific part in omapfb that was too slow? I'd be happy to get it
optimized.

> Given that the DSS2 exposes all three planes and knowing that there is
> at least two expected input paths, omapfb and the TI V4L2 driver, how
> is one expected to use the DSS2?  Are you suggesting that omapfb or
> V4L2 be used exclusively, not in combination?

No, I'm not suggesting that. This is a known problem, but it can't be
solved inside the kernel.

Optimally all the changes to overlays are done first, then one update is
issued. But if the overlays are handled by different entities, there's
no synchronization point and the entities compete about the display. And
the kernel driver cannot know what is going to happen next, so it cannot
wait for the next entity to issue update, before actually starting the
update.

I don't know how it should be handled with V4L2, but the same problem is
with omapfb. One entity is drawing to fb0, and some other entity draws
to fb1. The only solution I see is that there's one control point
between the kernel and the drawing-entities, and in our case this is X
server (I think). The X server has a better understanding of what is
going on, and can do updates better.

>         So how double buffering is supposed to be done is:
>         
>         1) Fill frame A
>         2) Setup overlay for A
>         3) Wait until Frame B is done, with sync()
>         4) Start sending frame A, with update()
>         5) Fill frame B
>         6) Setup overlay for B
>         7) sync()
>         8) update()
>         9) Go back to 1
>         
> When you say "Setup overlay" I assume you mean both
> "overlay->set_overlay_info()" and "manager->apply()", correct?

Yes, I think apply is needed also.

> 
> We have been calling sync after calling update as a means of
> determining that the previous buffer is free.  In your example, sync
> is called, I assume, to ensure the previous update is complete before
> calling update again.  I need to consider this to see if this helps or
> hinders our cause.

If you call sync after update, you'll wait for that update to finish.
Which is not what you want. So yes, the idea is to start the update for
the front buffer, modify the back buffer, and when back buffer is ready,
use sync to make sure that the previous transfer has been finished.

 Tomi



