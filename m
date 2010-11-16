From: "Taneja, Archit" <archit@ti.com>
Subject: RE: [PATCH v4 3/7] OMAP: DSS2: Introduce omap_channel as a
 omap_dss_device parameter
Date: Tue, 16 Nov 2010 16:52:16 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC356087034C10218C@dbde02.ent.ti.com>
References: <1289219065-1362-1-git-send-email-archit@ti.com>
	 <1289219065-1362-4-git-send-email-archit@ti.com>
 <1289904957.2668.75.camel@tubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45087 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932917Ab0KPLWZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Nov 2010 06:22:25 -0500
In-Reply-To: <1289904957.2668.75.camel@tubuntu>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Semwal, Sumit" <sumit.semwal@ti.com>, "Mittal, Mukund" <mmittal@ti.com>, "Nilofer, Samreen" <samreen@ti.com>

Hi,

Tomi Valkeinen wrote:
> Hi,
> 

[snip]

>> diff --git a/arch/arm/plat-omap/include/plat/display.h
>> b/arch/arm/plat-omap/include/plat/display.h
>> index 586944d..3e6eec1 100644
>> --- a/arch/arm/plat-omap/include/plat/display.h
>> +++ b/arch/arm/plat-omap/include/plat/display.h
>> @@ -434,6 +434,7 @@ struct omap_dss_device {
>>         struct omap_overlay_manager *manager;
>> 
>>         enum omap_dss_display_state state;
>> +       enum omap_channel channel;
> 
> Isn't this the same as dssdev->manager->id?
> 
> Yes, this channel stuff is a bit confusing, even the enum "omap_channel"
> is badly named (should at least have "dss" in it). But
> omap_overlay_manager should represent the output pipe, so I
> don't think there's need for channel field in dss_device.

The panel somehow needs to tell which manager it is connected to. We went with
with the way of declaring a new member 'channel' and setting that parameter up in the
board file.

The current way to relate the manager and device is done by checking the dssdev->type
in dss_recheck_connections() and then calling set_device()

This is not sufficient any more since two of the managers can support similar types of
displays.

So in the channel approach the following happens:

-mgr->id's are initialized at bootup.
-devices and managers are connected using 'channel'.
-mgr->id automatically becomes equal to channel.

Can we set something like dssdev->manager->id in the board file itself?

Archit

> 
> I think in many places we could even pass
> omap_overlay_manager pointer around, instead of omap_channel.
> However, for low level dispc functions it's perhaps cleaner
> to pass the channel ID though.
> 
>  Tomi