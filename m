From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: RE: [PATCH] DSPBRIDGE: driver version 0.1
Date: Mon, 11 Jan 2010 13:28:15 -0600
Message-ID: <27F9C60D11D683428E133F85D2BB4A53042DC95DA5@dlee03.ent.ti.com>
References: <1263232222-30599-1-git-send-email-omar.ramirez@ti.com>
 <1263232222-30599-2-git-send-email-omar.ramirez@ti.com>
 <4B4B6E55.9000406@ti.com>
 <27F9C60D11D683428E133F85D2BB4A53042DC95D1B@dlee03.ent.ti.com>
 <4B4B7420.8090608@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58918 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753885Ab0AKT2W convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jan 2010 14:28:22 -0500
In-Reply-To: <4B4B7420.8090608@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Felipe Contreras <felipe.contreras@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>

>From: Menon, Nishanth
>
>Ramirez Luna, Omar had written, on 01/11/2010 12:46 PM, the following:
>>> From: Menon, Nishanth
>>>
>>> Ramirez Luna, Omar had written, on 01/11/2010 11:50 AM, the following:
>>>> This is the official 0.1 dspbridge version.
>>>>
>>>> CC: Felipe Contreras <felipe.contreras@nokia.com>
>>>> CC: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>
>>>> CC: Ameya Palande <ameya.palande@nokia.com>
>>>> CC: Nishant Menon <nm@ti.com>
>>>>
>>>> Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
>>>> ---
>>>>  drivers/dsp/bridge/rmgr/drv_interface.c |    2 ++
>>>>  1 files changed, 2 insertions(+), 0 deletions(-)
>>>>
>>>> diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
>>>> index c853854..efce35d 100644
>>>> --- a/drivers/dsp/bridge/rmgr/drv_interface.c
>>>> +++ b/drivers/dsp/bridge/rmgr/drv_interface.c
>>>> @@ -101,6 +101,7 @@
>>>>  #define BRIDGE_NAME "C6410"
>>>>  /*  ----------------------------------- Globals */
>>>>  #define DRIVER_NAME  "DspBridge"
>>>> +#define DSPBRIDGE_VERSION	"0.1"
>>>>  s32 dsp_debug;
>>>>
>>>>  struct platform_device *omap_dspbridge_dev;
>>>> @@ -177,6 +178,7 @@ MODULE_PARM_DESC(tc_wordswapon, "TC Word Swap Option. default = 0");
>>>>
>>>>  MODULE_AUTHOR("Texas Instruments");
>>>>  MODULE_LICENSE("GPL");
>>>> +MODULE_VERSION(DSPBRIDGE_VERSION);
>>>>
>>>>  static char *driver_name = DRIVER_NAME;
>>>>
>>> is the IOCTL patch before or after the 0.1?
>>
>> IOCTL patch is after 0.1
>>
>> I'll be resending v2 of IOCTL patch but should be applied after this patch.
>sounds reasonable. I wonder what happened to
>http://marc.info/?l=linux-omap&m=125729526105560&w=2

To the change: currently is on hold given the amount of changes but
scheduled for this month (hopefully ;))

To the request: I have a patch queue to be applied after 0.1 patch and v2 of
ioctl, the patches have already been sent to this mailing list but changes
didn't fit prior to 0.1 alignment

Regards,

omar
