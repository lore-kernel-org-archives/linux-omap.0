From: Archit Taneja <archit@ti.com>
Subject: Re: [PATCH v2 0/2] drm: omap: Fix omapdrm probe and module insertion/removal
 issues
Date: Wed, 9 Oct 2013 19:26:23 +0530
Message-ID: <52556087.6050401@ti.com>
References: <1379502502-8781-1-git-send-email-archit@ti.com> <1381138693-23404-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47526 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751462Ab3JIN5N (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Oct 2013 09:57:13 -0400
In-Reply-To: <1381138693-23404-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: robdclark@gmail.com, tomi.valkeinen@ti.com
Cc: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org

Hi Rob,

On Monday 07 October 2013 03:08 PM, Archit Taneja wrote:
> With the new omapdss device model. The user(omapdrm/omapfb) of a omap_dss_device
> has to call connect() to use the device. A connect() call can request to defer
> probe if the device(or the previous entities in the chain) have missing
> resources like a regulator or an I2C bus.
>
> We make omapdrm defer probe by trying to first connect all panels, and request
> for deferral if any panel requests for a defer. This makes sure that all the
> panels are set up correctly when we finally proceed with omapdrm initialization.
>
> In order for omapdrm module to be removed successfully, we need to disconnect
> the panels which omapdrm connected. Another thing noticed was that omapdrm
> insertion followed by some usage results in panels getting enabled.
>
> Trying to remove omapdrm with a panel enabled results in failure while
> disconnecting. This leaves omapdss panels in a bad state. I have added an
> explicit panel disable in the omap_encoder_destroy() op, I needed some
> suggestions on whether there is a better way to do this.
>
> changes in v2:
> - Add special case when no panels are available to connect.
> - Make sure panels are diabled (and then disconnected) when omapdrm is removed

omapdrm fails when built-in in 3.12, the first patch fixes this. The 
second one fixes issues seen with successive module insertion and removals.

It'll be great if the first one can at least make it to 3.12. Could you 
have a look at it?

Thanks,
Archit

