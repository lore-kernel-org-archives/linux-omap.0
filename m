From: Archit Taneja <archit@ti.com>
Subject: Re: v3.6-rc1 DSS issues/regression
Date: Mon, 6 Aug 2012 23:06:28 +0530
Message-ID: <5020009C.1080308@ti.com>
References: <20120806164732.GB1298@harshnoise.musicnaut.iki.fi> <1344273868.12136.50.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52429 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932291Ab2HFRgl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 6 Aug 2012 13:36:41 -0400
In-Reply-To: <1344273868.12136.50.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, linux-omap@vger.kernel.org

Hi,

On Monday 06 August 2012 10:54 PM, Tomi Valkeinen wrote:
> On Mon, 2012-08-06 at 19:47 +0300, Aaro Koskinen wrote:
>> Hi,
>>
>> I can't get the display on N900 (SDI, acx565akm) to work with v3.6-rc1
>> kernel, it's just full of flicker/noise.
>>
>> According to git-bisect, the problem is introduced by the commit:
>>
>>      commit f476ae9dab3234532d41d36beb4ba7be838fa786
>>      Author: Archit Taneja <archit@ti.com>
>>      Date:   Fri Jun 29 14:37:03 2012 +0530
>>
>>      OMAPDSS: APPLY: Remove DISPC writes to manager's lcd parameters in interface
>>
>> Any ideas?

Thanks for pointing this out.

The commit delays the register writes to a later point. But these 
registers are shadowed, i.e, they shouldn't take impact till the time 
the overlay manager is enabled. It's possible that some fields of the 
registers in question may have a direct impact, and hence messing up 
some sequence with respect to sdi registers.

The diff I have shared introduces the register writes back. This should 
make it work like before. But we need to figure out which parameter 
write needs to be done immediately. If this works, could you remove each 
dispc register write turn by turn, and point out which is the culprit one?

Sorry about the manual process, but we don't have any way to test SDI 
here :)

Thanks
Archit

diff --git a/drivers/video/omap2/dss/sdi.c b/drivers/video/omap2/dss/sdi.c
index 5d31699..d397e96 100644
--- a/drivers/video/omap2/dss/sdi.c
+++ b/drivers/video/omap2/dss/sdi.c
@@ -46,6 +46,22 @@ static void sdi_config_lcd_manager(struct 
omap_dss_device *dssdev)
         sdi.mgr_config.video_port_width = 24;
         sdi.mgr_config.lcden_sig_polarity = 1;

+
+       dispc_mgr_set_io_pad_mode(sdi.mgr_config.io_pad_mode);
+       dispc_mgr_enable_stallmode(dssdev->manager->id,
+                       sdi.mgr_config.stallmode);
+       dispc_mgr_enable_fifohandcheck(dssdev->manager->id,
+                       sdi.mgr_config.fifohandcheck);
+
+       dispc_mgr_set_clock_div(dssdev->manager->id,
+                       &sdi.mgr_config.clock_info);
+
+       dispc_mgr_set_tft_data_lines(dssdev->manager->id,
+                       sdi.mgr_config.video_port_width);
+       dispc_lcd_enable_signal_polarity(sdi.mgr_config.lcden_sig_polarity);
+
+       dispc_mgr_set_lcd_type_tft(dssdev->manager->id);
+

>
> Looks strange, that particular commit more or less just moves the
> writing of the configs to another place. And it works for DPI and DSI,
> at least.
>
> Can you take a dump of debugfs/omapdss/dss and debugfs/omapdss/dispc,
> for both working and non-working versions, to see if there's a diff?
>
>   Tomi
>

