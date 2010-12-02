From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: RE: [PATCH v5 3/7] OMAP: DSS2: Introduce omap_channel as a
 omap_dss_device parameter
Date: Thu, 02 Dec 2010 11:27:10 +0200
Message-ID: <1291282030.778.9.camel@tubuntu>
References: <1290410585-29418-1-git-send-email-archit@ti.com>
	 <1290410585-29418-4-git-send-email-archit@ti.com>
	 <1291217886.10133.171.camel@tubuntu>
	 <FCCFB4CDC6E5564B9182F639FC356087035EFD6FE6@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.26]:17496 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757058Ab0LBJ1S (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 2 Dec 2010 04:27:18 -0500
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC356087035EFD6FE6@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Taneja, Archit" <archit@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Semwal, Sumit" <sumit.semwal@ti.com>, "Mittal, Mukund" <mmittal@ti.com>, "Nilofer, Samreen" <samreen@ti.com>

On Thu, 2010-12-02 at 13:27 +0530, ext Taneja, Archit wrote:
> Hi,
> 
> Tomi Valkeinen wrote:
> > Hi,
> > 

> > - The files are getting quite crowded with code that checks
> > for the channel and then do the work with bits/irqs depending
> > on the channel.
> > This makes the code a bit difficult to read. I don't have any
> > clear ideas right now how to make it clearer, but some
> > methods to generalize these kinds of functions would be nice.
> > But this is not so important for the time being, and we can improve it later.
> 
> I am assuming that you are referring to 'DISPC_IRQ_MASK_ERROR' and the registering/unregistering of
> irq masks in manager.c

Not only the irqs, but also, for example, code like this:


        if (channel == OMAP_DSS_CHANNEL_LCD ||
                        channel == OMAP_DSS_CHANNEL_LCD2)
                bit = 5; /* GOLCD */
        else
                bit = 6; /* GODIGIT */

        if (channel == OMAP_DSS_CHANNEL_LCD2)
                return REG_GET(DISPC_CONTROL2, bit, bit) == 1;
        else
                return REG_GET(DISPC_CONTROL, bit, bit) == 1;

So lots of the functions contain ifs based on the channel. I don't know
right now what would be the best way to make the code cleaner (probably
some kinds of look-up tables, but they incur some overhead), and as I
said, it's cosmetical and can be cleaned up later (presuming we come up
with a good way).

> I guess we could have a dss_features function which could return the mask based on what omap
> it is. But this way the mask values/contents would be totally invisble in manager.c and dispc.c, one
> would need to check it in dss_features.c, which also isn't readable.

Right. I agree that that solution isn't perhaps the best one either.

> One thing which I would like to add is that this series doesn't need to touch any board file for now.
> The present dss_recheck_connections() doesn't try to differentiate between LCD and DIGIT channels, it just
> uses 'omap_display_type' to differentiate between them. Only a panel which needs to connect to LCD2 has to do this,
> This method wouldn't have worked if we didn't switch to uniform use of dssdev->manager->id instead of
> dssdev->channel. We will need to change dss_recheck_connections() in the future to make it more uniform.

Ok.

If you can split this patch into the two parts I suggested (if that's ok
for you, you didn't comment on that one), and check if there's anything
to add to the commit descriptions, I think we can go and apply this
patch set.

Btw, on what platforms have you tested this (or generally any patches
you send?). I only have 3430SDP currently that I can easily use to test,
so my testing is a bit limited.

 Tomi


