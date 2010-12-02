From: "Taneja, Archit" <archit@ti.com>
Subject: RE: [PATCH v5 3/7] OMAP: DSS2: Introduce omap_channel as a
 omap_dss_device parameter
Date: Thu, 2 Dec 2010 15:17:57 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC356087035F0A4A5C@dbde02.ent.ti.com>
References: <1290410585-29418-1-git-send-email-archit@ti.com>
	 <1290410585-29418-4-git-send-email-archit@ti.com>
	 <1291217886.10133.171.camel@tubuntu>
	 <FCCFB4CDC6E5564B9182F639FC356087035EFD6FE6@dbde02.ent.ti.com>
 <1291282030.778.9.camel@tubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39377 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756971Ab0LBJsH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Dec 2010 04:48:07 -0500
In-Reply-To: <1291282030.778.9.camel@tubuntu>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Semwal, Sumit" <sumit.semwal@ti.com>, "Mittal, Mukund" <mmittal@ti.com>, "Nilofer, Samreen" <samreen@ti.com>

Hi,

[snip]

>> I am assuming that you are referring to 'DISPC_IRQ_MASK_ERROR' and the
>> registering/unregistering of irq masks in manager.c
> 
> Not only the irqs, but also, for example, code like this:
> 
> 
>         if (channel == OMAP_DSS_CHANNEL_LCD ||
>                         channel == OMAP_DSS_CHANNEL_LCD2)
>                 bit = 5; /* GOLCD */
>         else
>                 bit = 6; /* GODIGIT */
> 
>         if (channel == OMAP_DSS_CHANNEL_LCD2)
>                 return REG_GET(DISPC_CONTROL2, bit, bit) == 1;         else
>                 return REG_GET(DISPC_CONTROL, bit, bit) == 1;
> 

Things would be bad only for DISPC_CONTROL and DISPC_CONFIG since
we couldn't parametrize them based on channel. Others look scalable,
I don't know if there will be more such registers on OMAP5, but we
can ask HW Team to keep them specific to the channel.

> So lots of the functions contain ifs based on the channel. I
> don't know right now what would be the best way to make the
> code cleaner (probably some kinds of look-up tables, but they
> incur some overhead), and as I said, it's cosmetical and can
> be cleaned up later (presuming we come up with a good way).
> 
>> I guess we could have a dss_features function which could return the
>> mask based on what omap it is. But this way the mask values/contents
>> would be totally invisble in manager.c and dispc.c, one
> would need to check it in dss_features.c, which also isn't readable.
> 
> Right. I agree that that solution isn't perhaps the best one either.
> 
>> One thing which I would like to add is that this series
> doesn't need to touch any board file for now.
>> The present dss_recheck_connections() doesn't try to differentiate
>> between LCD and DIGIT channels, it just uses 'omap_display_type' to
>> differentiate between them. Only a panel which needs to connect to
>> LCD2 has to do this, This method wouldn't have worked if we didn't
>> switch to uniform use of dssdev->manager->id instead of
>> dssdev->channel. We will need to change
> dss_recheck_connections() in the future to make it more uniform.
> 
> Ok.
> 
> If you can split this patch into the two parts I suggested
> (if that's ok for you, you didn't comment on that one), and
> check if there's anything to add to the commit descriptions,
> I think we can go and apply this patch set.

If I split this into 2 parts, the first patch will be just a line
addition in display.h, I was beaten up by the community because of
this in the previous version. One line patches in a series aren't
taken very kindly :|. What I can do is clearly mention the 2 sets
of things which this commit does, if you think that is good enough.

> 
> Btw, on what platforms have you tested this (or generally any
> patches you send?). I only have 3430SDP currently that I can
> easily use to test, so my testing is a bit limited.
> 

This one I had tested throughly on 3430SDP, bootup on zoom2 and zoom3.
I couldn't test on omap2, we have a n800 board but we don't know what panel
driver we need to use, board-n8x0.c doesn't tell anything about. If you can
tell me what panel driver to use etc I can try out.

Archit