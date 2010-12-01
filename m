From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH v5 3/7] OMAP: DSS2: Introduce omap_channel as a
 omap_dss_device parameter
Date: Wed, 01 Dec 2010 17:38:06 +0200
Message-ID: <1291217886.10133.171.camel@tubuntu>
References: <1290410585-29418-1-git-send-email-archit@ti.com>
	 <1290410585-29418-4-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.26]:24416 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752090Ab0LAPiO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 1 Dec 2010 10:38:14 -0500
In-Reply-To: <1290410585-29418-4-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Archit Taneja <archit@ti.com>
Cc: linux-omap@vger.kernel.org, Sumit Semwal <sumit.semwal@ti.com>, Mukund Mittal <mmittal@ti.com>, Samreen <samreen@ti.com>

Hi,

On Mon, 2010-11-22 at 12:53 +0530, ext Archit Taneja wrote:
> From: Sumit Semwal <sumit.semwal@ti.com>
> 
> A new member 'channel' is introduced in omap_dss_device structure to determine
> which channel the panel uses. The dss_recheck_connections() called in dss_driver_probe()
> to set the correct manager to the corresponding omap_dss_device. The interface drivers
> (dsi.c, sdi.c etc) now call dispc functions with dssdev->manager->id as a parameter to
> specify the DISPC channel.
> 
> The following dispc functions are changed to incorporate channel as an argument:
> 	-dispc_enable_fifohandcheck()
> 	-dispc_set_lcd_size()
> 	-dispc_set_parallel_interface_mode()
> 	-dispc_set_tft_data_lines()
> 	-dispc_set_lcd_display_type()
> 	-dispc_set_lcd_timings()

This patch combines two separate things: 1) the new channel-field +
related changes (dss_recheck_connections), and 2) converting dispc
functions to accept channel as a parameter.

Generally about the whole patch set, I think this is starting to look
ok. But two things, which are cosmetical:

- I wouldn't mind a bit more verbose commit descriptions. Of course it's
easy to say "write better descriptions", and I don't have any direct
advice for this. However, remember that the 0000-patch won't be in the
git log, so all important information should be available also from the
patch descriptions.

- The files are getting quite crowded with code that checks for the
channel and then do the work with bits/irqs depending on the channel.
This makes the code a bit difficult to read. I don't have any clear
ideas right now how to make it clearer, but some methods to generalize
these kinds of functions would be nice. But this is not so important for
the time being, and we can improve it later.

 Tomi


