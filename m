From: Archit Taneja <archit@ti.com>
Subject: Re: [PATCH v2 2/3] OMAPDSS: DISPC: VIDEO3 pipeline support
Date: Tue, 20 Sep 2011 12:25:37 +0530
Message-ID: <4E7838E9.6000802@ti.com>
References: <1316155153-24351-1-git-send-email-archit@ti.com> <1316155153-24351-3-git-send-email-archit@ti.com> <19F8576C6E063C45BE387C64729E739404EC811422@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46050 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752815Ab1ITGxV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Sep 2011 02:53:21 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p8K6rImu000805
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 20 Sep 2011 01:53:20 -0500
In-Reply-To: <19F8576C6E063C45BE387C64729E739404EC811422@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Tuesday 20 September 2011 01:13 AM, Hiremath, Vaibhav wrote:
>
>> -----Original Message-----
>> From: Taneja, Archit
>> Sent: Friday, September 16, 2011 12:09 PM
>> To: Valkeinen, Tomi
>> Cc: Hiremath, Vaibhav; linux-omap@vger.kernel.org; Taneja, Archit
>> Subject: [PATCH v2 2/3] OMAPDSS: DISPC: VIDEO3 pipeline support
>>
>> Add support for VIDEO3 pipeline on OMAP4:
>> - Add VIDEO3 pipeline information in dss_features and omapdss.h
>> - Add VIDEO3 pipeline register coefficients in dispc.h
>> - Create a new overlay structure corresponding to VIDEO3.
>> - Make changes in dispc.c for VIDEO3
>>
>> Signed-off-by: Archit Taneja<archit@ti.com>

<snip>

>> diff --git a/drivers/video/omap2/dss/dss_features.h
>> b/drivers/video/omap2/dss/dss_features.h
>> index e81271a..6a6c05d 100644
>> --- a/drivers/video/omap2/dss/dss_features.h
>> +++ b/drivers/video/omap2/dss/dss_features.h
>> @@ -25,7 +25,7 @@
>>   #endif
>>
>>   #define MAX_DSS_MANAGERS     3
>> -#define MAX_DSS_OVERLAYS     3
>> +#define MAX_DSS_OVERLAYS     4
> [Hiremath, Vaibhav] Not related to this patch as such, but I think we should now get rid of these macros and use run-time mechanism.

This macro is used within DSS2 to declare the size of some arrays. So a 
runtime mechanism isn't possible(unless we allocate the arrays 
dynamically itself, but they are used for trivial purposes, and won't be 
large in size, so I don't think that this is needed).

We anyway use the function omap_dss_get_num_overlays() wherever possible.

>
> Overall this patch looks ok to me, I will test it tomorrow and will update you.

Thanks,
Archit

>
> Thanks,
> Vaibhav
>
>>   #define MAX_DSS_LCD_MANAGERS 2
>>   #define MAX_NUM_DSI          2
>>
>> diff --git a/drivers/video/omap2/dss/overlay.c
>> b/drivers/video/omap2/dss/overlay.c
>> index afb7583..11d21e3 100644
>> --- a/drivers/video/omap2/dss/overlay.c
>> +++ b/drivers/video/omap2/dss/overlay.c
>> @@ -615,6 +615,11 @@ void dss_init_overlays(struct platform_device *pdev)
>>                        ovl->id = OMAP_DSS_VIDEO2;
>>                        ovl->info.global_alpha = 255;
>>                        break;
>> +             case 3:
>> +                     ovl->name = "vid3";
>> +                     ovl->id = OMAP_DSS_VIDEO3;
>> +                     ovl->info.global_alpha = 255;
>> +                     break;
>>                }
>>
>>                ovl->set_manager =&omap_dss_set_manager;
>> diff --git a/include/video/omapdss.h b/include/video/omapdss.h
>> index 5f0ce5e..1f12559 100644
>> --- a/include/video/omapdss.h
>> +++ b/include/video/omapdss.h
>> @@ -41,6 +41,8 @@
>>   #define DISPC_IRQ_WAKEUP             (1<<  16)
>>   #define DISPC_IRQ_SYNC_LOST2         (1<<  17)
>>   #define DISPC_IRQ_VSYNC2             (1<<  18)
>> +#define DISPC_IRQ_VID3_END_WIN               (1<<  19)
>> +#define DISPC_IRQ_VID3_FIFO_UNDERFLOW        (1<<  20)
>>   #define DISPC_IRQ_ACBIAS_COUNT_STAT2 (1<<  21)
>>   #define DISPC_IRQ_FRAMEDONE2         (1<<  22)
>>   #define DISPC_IRQ_FRAMEDONEWB                (1<<  23)
>> @@ -63,7 +65,8 @@ enum omap_display_type {
>>   enum omap_plane {
>>        OMAP_DSS_GFX    = 0,
>>        OMAP_DSS_VIDEO1 = 1,
>> -     OMAP_DSS_VIDEO2 = 2
>> +     OMAP_DSS_VIDEO2 = 2,
>> +     OMAP_DSS_VIDEO3 = 3,
>>   };
>>
>>   enum omap_channel {
>> --
>> 1.7.1
>
>

