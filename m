From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: RE: [RESEND] [PATCH] DSPBRIDGE: Adding protection Resource cleanup
 linked lists
Date: Wed, 17 Feb 2010 19:56:02 -0600
Message-ID: <496565EC904933469F292DDA3F1663E602CA2B9ADB@dlee06.ent.ti.com>
References: <496565EC904933469F292DDA3F1663E602AA725DC6@dlee06.ent.ti.com>
 <1266404123.2063.2.camel@sanganak>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36171 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753797Ab0BRB4F convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Feb 2010 20:56:05 -0500
In-Reply-To: <1266404123.2063.2.camel@sanganak>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@Nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@Nokia.com>, "Contreras Felipe (Nokia-D/Helsinki)" <felipe.contreras@Nokia.com>


Hi,

>-----Original Message-----
>From: Ameya Palande [mailto:ameya.palande@Nokia.com]
>Sent: Wednesday, February 17, 2010 4:55 AM
>To: Guzman Lugo, Fernando
>Cc: linux-omap@vger.kernel.org; Doyu Hiroshi (Nokia-D/Helsinki); Contreras
>Felipe (Nokia-D/Helsinki)
>Subject: Re: [RESEND] [PATCH] DSPBRIDGE: Adding protection Resource cleanup
>linked lists
>
>Hi Fernando,
>
>On Wed, 2010-02-10 at 09:32 +0100, ext Guzman Lugo, Fernando wrote:
>> Please discard previous one.
>>
>> Regards,
>> Fernando.
>>
>> From 6bcdc02f6265246e385194433775e75db7ad44cf Mon Sep 17 00:00:00 2001
>> From: Fernando Guzman Lugo <x0095840@ti.com>
>> Date: Wed, 10 Feb 2010 02:31:40 -0600
>> Subject: [PATCH] DSPBRIDGE: Adding protection Resource cleanup linked
>lists
>>
>> This patch protects the Resorce cleanup lists from
>> concurrent access
>>
>> Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
>> ---
>>  arch/arm/plat-omap/include/dspbridge/drv.h |    3 +
>>  drivers/dsp/bridge/pmgr/wcd.c              |   16 ++++++-
>>  drivers/dsp/bridge/rmgr/drv.c              |   71
>+++++++++++++++++++++++----
>>  drivers/dsp/bridge/rmgr/drv_interface.c    |    8 ++-
>>  4 files changed, 83 insertions(+), 15 deletions(-)
>>
>> diff --git a/arch/arm/plat-omap/include/dspbridge/drv.h b/arch/arm/plat-
>omap/include/dspbridge/drv.h
>> index b6a5fd2..b044291 100644
>> --- a/arch/arm/plat-omap/include/dspbridge/drv.h
>> +++ b/arch/arm/plat-omap/include/dspbridge/drv.h
>> @@ -137,15 +137,18 @@ struct PROCESS_CONTEXT{
>>
>>  	/* DSP Node resources */
>>  	struct NODE_RES_OBJECT *pNodeList;
>> +	struct mutex node_mutex;
>>
>>  	/* DMM resources */
>>  	struct DMM_RES_OBJECT *pDMMList;
>> +	struct mutex dmm_mutex;
>>
>>  	/* DSP Heap resources */
>>  	struct DSPHEAP_RES_OBJECT *pDSPHEAPList;
>>
>>  	/* Stream resources */
>>  	struct STRM_RES_OBJECT *pSTRMList;
>> +	struct mutex strm_mutex;
>>  } ;
>
>Is there a specific reason for using mutex instead of spin_lock?
>
>AFAIU these locks are help for very short time, for inserting / removing
>elements from linked list, or traversing a linked list.

Yes, changing mutex to spinlocks would help in performance. Let me send a patch to change them.

Regards,
Fernando.

>
>Cheers,
>Ameya.

