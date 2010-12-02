From: "Taneja, Archit" <archit@ti.com>
Subject: RE: [PATCH v5 3/7] OMAP: DSS2: Introduce omap_channel as a
 omap_dss_device parameter
Date: Thu, 2 Dec 2010 13:27:34 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC356087035EFD6FE6@dbde02.ent.ti.com>
References: <1290410585-29418-1-git-send-email-archit@ti.com>
	 <1290410585-29418-4-git-send-email-archit@ti.com>
 <1291217886.10133.171.camel@tubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34441 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752352Ab0LBH5m convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Dec 2010 02:57:42 -0500
In-Reply-To: <1291217886.10133.171.camel@tubuntu>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Semwal, Sumit" <sumit.semwal@ti.com>, "Mittal, Mukund" <mmittal@ti.com>, "Nilofer, Samreen" <samreen@ti.com>

Hi,

Tomi Valkeinen wrote:
> Hi,
> 
> On Mon, 2010-11-22 at 12:53 +0530, ext Archit Taneja wrote:
>> From: Sumit Semwal <sumit.semwal@ti.com>
>> 
>> A new member 'channel' is introduced in omap_dss_device structure to
>> determine which channel the panel uses. The dss_recheck_connections()
>> called in dss_driver_probe() to set the correct manager to the
>> corresponding omap_dss_device. The interface drivers (dsi.c, sdi.c
>> etc) now call dispc functions with dssdev->manager->id as a
> parameter to specify the DISPC channel.
>> 
>> The following dispc functions are changed to incorporate channel as an
>> argument: 
>> 	-dispc_enable_fifohandcheck()
>> 	-dispc_set_lcd_size()
>> 	-dispc_set_parallel_interface_mode()
>> 	-dispc_set_tft_data_lines()
>> 	-dispc_set_lcd_display_type()
>> 	-dispc_set_lcd_timings()
> 
> This patch combines two separate things: 1) the new
> channel-field + related changes (dss_recheck_connections),
> and 2) converting dispc functions to accept channel as a parameter.
> 
> Generally about the whole patch set, I think this is starting
> to look ok. But two things, which are cosmetical:
> 
> - I wouldn't mind a bit more verbose commit descriptions. Of
> course it's easy to say "write better descriptions", and I
> don't have any direct advice for this. However, remember that
> the 0000-patch won't be in the git log, so all important
> information should be available also from the patch descriptions.

I will update the comments.

> 
> - The files are getting quite crowded with code that checks
> for the channel and then do the work with bits/irqs depending
> on the channel.
> This makes the code a bit difficult to read. I don't have any
> clear ideas right now how to make it clearer, but some
> methods to generalize these kinds of functions would be nice.
> But this is not so important for the time being, and we can improve it later.

I am assuming that you are referring to 'DISPC_IRQ_MASK_ERROR' and the registering/unregistering of
irq masks in manager.c

I guess we could have a dss_features function which could return the mask based on what omap
it is. But this way the mask values/contents would be totally invisble in manager.c and dispc.c, one
would need to check it in dss_features.c, which also isn't readable.

One thing which I would like to add is that this series doesn't need to touch any board file for now.
The present dss_recheck_connections() doesn't try to differentiate between LCD and DIGIT channels, it just
uses 'omap_display_type' to differentiate between them. Only a panel which needs to connect to LCD2 has to do this,
This method wouldn't have worked if we didn't switch to uniform use of dssdev->manager->id instead of
dssdev->channel. We will need to change dss_recheck_connections() in the future to make it more uniform.

Regards,
Archit

