From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH 2/2] video:omapdrm: make omapdrm assume the tv-out cable is always connected
Date: Fri, 13 Nov 2015 17:45:26 +0100
Message-ID: <0A7D0C81-AA10-413C-8546-9873B65FE6CE@goldelico.com>
References: <cover.1447410543.git.hns@goldelico.com> <5942ddb7ab4f42f207c6c2b54be31a3d9fe3b912.1447410544.git.hns@goldelico.com> <5645CD79.5040107@ti.com> <3973104.FPbEEICOqe@avalon>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3973104.FPbEEICOqe@avalon>
Sender: linux-kernel-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: David Airlie <airlied@linux.ie>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, dri-devel@lists.freedesktop.org, LKML <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, linux-fbdev@vger.kernel.org, List for communicating with real GTA04 owners <gta04-owner@goldelico.com>, =?windows-1252?Q?Gra=9Evydas_Ignotas?= <notasas@gmail.com>
List-Id: linux-omap@vger.kernel.org

Here the test results:

Am 13.11.2015 um 13:01 schrieb Laurent Pinchart <laurent.pinchart@ideasonboard.com>:

> On Friday 13 November 2015 13:46:01 Tomi Valkeinen wrote:
>> On 13/11/15 12:29, H. Nikolaus Schaller wrote:
>>> Include VENC in the set of drivers where it is assimed that the cable
>>> is always connected. Like DPI, DSI, DBI and SDI do.
>>> 
>>> Otherwise, the VENC will return cable status "unknown" and is not enabled
>>> by the X-server. So there is no video output signal.
>>> 
>>> Tested on: BeagleBoard XM, GTA04 and OpenPandora
>>> 
>>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>>> ---
>>> 
>>> drivers/gpu/drm/omapdrm/omap_connector.c | 1 +
>>> 1 file changed, 1 insertion(+)
>>> 
>>> diff --git a/drivers/gpu/drm/omapdrm/omap_connector.c
>>> b/drivers/gpu/drm/omapdrm/omap_connector.c index 83f2a91..98ddb5d 100644
>>> --- a/drivers/gpu/drm/omapdrm/omap_connector.c
>>> +++ b/drivers/gpu/drm/omapdrm/omap_connector.c
>>> @@ -120,6 +120,7 @@ static enum drm_connector_status
>>> omap_connector_detect(
>>> 		else
>>> 			ret = connector_status_disconnected;
>>> 	} else if (dssdev->type == OMAP_DISPLAY_TYPE_DPI ||
>>> +			dssdev->type == OMAP_DISPLAY_TYPE_VENC ||
>>> 			dssdev->type == OMAP_DISPLAY_TYPE_DBI ||
>>> 			dssdev->type == OMAP_DISPLAY_TYPE_SDI ||
>>> 			dssdev->type == OMAP_DISPLAY_TYPE_DSI) {
>> 
>> I have no idea why VENC is not working for you when using
>> connector_status_unknown, but I just tested DPI with
>> connector_status_unknown (i.e. changed the above func to return unknown
>> for DPI), and it works fine with X and X omap driver. And xrandr
>> confirms that the connection status is unknown:
>> 
>> # xrandr
>> Screen 0: minimum 320 x 200, current 1920 x 1200, maximum 2048 x 2048
>> HDMI-1 disconnected (normal left inverted right x axis y axis)
>> None-1 unknown connection 1920x1200+0+0 (normal left inverted right x
>> axis y axis) 0mm x 0mm
>>   1920x1200     60.00*+  60.00 +

A) with this VENC patch:

root@letux:~# xrandr
Screen 0: minimum 320 x 200, current 720 x 640, maximum 2048 x 2048
None-1 connected 720x574+0+0 0mm x 0mm
   720x574i      50.00*+
None-2 connected 480x640+0+0 0mm x 0mm
   480x640       65.74*+
root@letux:~# cat /sys/class/drm/card0-Unknown-*/enabled
enabled
enabled
root@letux:~# cat /sys/class/drm/card0-Unknown-*/status 
connected
connected

B) w/o VENC patch (VENC returns returning connector_status_unknown):

root@letux:~# xrandr
Screen 0: minimum 320 x 200, current 480 x 640, maximum 2048 x 2048
None-1 connected 480x640+0+0 0mm x 0mm
   480x640       65.74*+
None-2 unknown connection
   720x574i      50.00 +
root@letux:~# cat /sys/class/drm/card0-Unknown-*/enabled
enabled
disabled
root@letux:~# cat /sys/class/drm/card0-Unknown-*/status
connected
unknown

C) with DPI (also) returning connector_status_unknown

root@letux:~# xrandr
Screen 0: minimum 320 x 200, current 720 x 640, maximum 2048 x 2048
None-1 unknown connection 720x574+0+0 0mm x 0mm
   720x574i      50.00*+
None-2 unknown connection 480x640+0+0 0mm x 0mm
   480x640       65.74*+
root@letux:~# cat /sys/class/drm/card0-Unknown-*/enabled
enabled
enabled
root@letux:~# cat /sys/class/drm/card0-Unknown-*/status
unknown
unknown
root@letux:~# 

D) VENC patch but DPI returning connector_status_unknown

rroot@letux:~# xrandr
Screen 0: minimum 320 x 200, current 720 x 574, maximum 2048 x 2048
None-1 unknown connection
   480x640       65.74 +
None-2 connected 720x574+0+0 0mm x 0mm
   720x574i      50.00*+oot@letux:~# cat /sys/class/drm/card0-Unknown-*/enabled
disabled
enabled
root@letux:~# cat /sys/class/drm/card0-Unknown-*/status
unknown
connected

In case B) I have no TV out and in case D) I have no LCD.

So it looks as if it works if my LCD and VENC report the same
connection status. And fails if they differ.

Anyone with an explanation or even vague idea where to search
for the real bug?

BR and thanks,
Nikolaus
