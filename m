From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: [PATCH 3/3] omap: zoom3: add zoom3 board support
Date: Wed, 28 Oct 2009 03:06:03 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702FA2DBF1E@dbde02.ent.ti.com>
References: <1256325806-14400-1-git-send-email-vikram.pandita@ti.com>
 <1256325806-14400-2-git-send-email-vikram.pandita@ti.com>
 <1256325806-14400-3-git-send-email-vikram.pandita@ti.com>
 <1256325806-14400-4-git-send-email-vikram.pandita@ti.com>
 <20091023230348.GC13020@gandalf>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56824 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932469AbZJ0Vh2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Oct 2009 17:37:28 -0400
In-Reply-To: <20091023230348.GC13020@gandalf>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "me@felipebalbi.com" <me@felipebalbi.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



>-----Original Message-----
>From: Felipe Balbi [mailto:me@felipebalbi.com]
>Sent: Friday, October 23, 2009 6:04 PM
>To: Pandita, Vikram
>Cc: linux-omap@vger.kernel.org
>Subject: Re: [PATCH 3/3] omap: zoom3: add zoom3 board support
>
>Hi,
>
>On Fri, Oct 23, 2009 at 02:23:26PM -0500, Vikram Pandita wrote:
>> diff --git a/arch/arm/mach-omap2/board-zoom2-zoom3.c b/arch/arm/mach-omap2/board-zoom2-zoom3.c
>> index 4ad9b94..d806dbf 100644
>> --- a/arch/arm/mach-omap2/board-zoom2-zoom3.c
>> +++ b/arch/arm/mach-omap2/board-zoom2-zoom3.c
>> @@ -281,7 +281,11 @@ static void __init omap_zoom2_map_io(void)
>>  	omap2_map_common_io();
>>  }
>>
>> +#ifdef CONFIG_MACH_OMAP_ZOOM3
>> +MACHINE_START(OMAP_ZOOM3, "OMAP ZOOM3 board")
>> +#else
>>  MACHINE_START(OMAP_ZOOM2, "OMAP Zoom2 board")
>> +#endif
>
>what happens if you want to build a kernel for both boards ?
>
>how about just adding a new MACHINE_START() declaration without
>ifdeferry ?
>
>Take a look at arch/arm/mach-omap2/board-n8x0.c for an example ;-)

Yes I will have a look at this. Thanks for all the comments.
My zoom3 board has gone bad and so could not look into this yet.

Will keep posted.

>
>--
>balbi

