From: Archit Taneja <a0393947@ti.com>
Subject: Re: Problems with 3.4-rc5
Date: Thu, 3 May 2012 15:32:13 +0530
Message-ID: <4FA257A5.1010902@ti.com>
References: <WC20120502115251.8503FF@terrafix.co.uk> <4FA12775.1090206@ti.com> <WC20120502124638.320406@terrafix.co.uk> <1336033721.14378.2.camel@deskari> <WC20120503084938.900446@terrafix.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42058 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754741Ab2ECKDo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 May 2012 06:03:44 -0400
In-Reply-To: <WC20120503084938.900446@terrafix.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joe Woodward <jw@terrafix.co.uk>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org

On Thursday 03 May 2012 02:19 PM, Joe Woodward wrote:
> -----Original Message-----
> From: Tomi Valkeinen<tomi.valkeinen@ti.com>
> To: Joe Woodward<jw@terrafix.co.uk>
> Cc: Archit Taneja<a0393947@ti.com>, linux-omap@vger.kernel.org
> Date: Thu, 03 May 2012 11:28:41 +0300
> Subject: Re: Problems with 3.4-rc5
>
>> On Wed, 2012-05-02 at 13:46 +0100, Joe Woodward wrote:
>>
>>>>> Secondly, I get the following when booted:
>>>>> ...
>>>>> [    4.701232] devtmpfs: mounted
>>>>> [    4.704772] Freeing init memory: 168K
>>>>> [    4.827301] omapdss DISPC error: FIFO UNDERFLOW on gfx,
>> disabling
>>>> the overlay
>>>>> ...
>>>>>
>>>>
>>>> Could you add some dss debug prints? You can add "omapdss.debug=1
>>>> debug"
>>>> in the bootargs to get that.
>>>>
>>>> There was a feature called fifo merge added in 3.4, this might lead
>> to
>>>> underflow, we had tested this using a DVI monitor on beagle but
>> didn't
>>>> see any underflows.
>>>>
>>>> Are you trying this out on 3.4 for the first time? What was the
>> last
>>>> kernel revision on which you tested this and didn't see any issues?
>>
>> Can you try the following changes (separately):
>>
>>
>> diff --git a/drivers/video/omap2/dss/dispc.c
>> b/drivers/video/omap2/dss/dispc.c
>> index ee30937..aca4eb1 100644
>> --- a/drivers/video/omap2/dss/dispc.c
>> +++ b/drivers/video/omap2/dss/dispc.c
>> @@ -1091,13 +1091,8 @@ void dispc_ovl_compute_fifo_thresholds(enum
>> omap_plane plane,
>>   	 * combined fifo size
>>   	 */
>>
>> -	if (dss_has_feature(FEAT_OMAP3_DSI_FIFO_BUG)) {
>> -		*fifo_low = ovl_fifo_size - burst_size * 2;
>> -		*fifo_high = total_fifo_size - burst_size;
>> -	} else {
>> -		*fifo_low = ovl_fifo_size - burst_size;
>> -		*fifo_high = total_fifo_size - buf_unit;
>> -	}
>> +	*fifo_low = ovl_fifo_size - burst_size;
>> +	*fifo_high = total_fifo_size - buf_unit;
>>   }
>>
>>   static void dispc_ovl_set_fir(enum omap_plane plane,
>>
>> ---
>
> The above patch fixes the problem (I no longer see any underflows).

Tomi,

Before FIFO merge was added, the special fifo_low/high calculation was 
only done for DSI on OMAP3, now it seems to be done on OMAP3 and for all 
interfaces. Maybe this is the difference between 3.3.

>
>
>>
>> diff --git a/drivers/video/omap2/dss/dispc.c
>> b/drivers/video/omap2/dss/dispc.c
>> index ee30937..d63f1a3 100644
>> --- a/drivers/video/omap2/dss/dispc.c
>> +++ b/drivers/video/omap2/dss/dispc.c
>> @@ -1077,13 +1077,7 @@ void dispc_ovl_compute_fifo_thresholds(enum
>> omap_plane plane,
>>   	burst_size = dispc_ovl_get_burst_size(plane);
>>   	ovl_fifo_size = dispc_ovl_get_fifo_size(plane);
>>
>> -	if (use_fifomerge) {
>> -		total_fifo_size = 0;
>> -		for (i = 0; i<  omap_dss_get_num_overlays(); ++i)
>> -			total_fifo_size += dispc_ovl_get_fifo_size(i);
>> -	} else {
>> -		total_fifo_size = ovl_fifo_size;
>> -	}
>> +	total_fifo_size = ovl_fifo_size;
>>
>>   	/*
>>   	 * We use the same low threshold for both fifomerge and non-fifomerge
>>
>
> The above patch has no effect (I still see underflows).
>
> Both patches together results in slightly different behaviour, the display is still broken-
> it flickers on and off with occassional underflows before breaking completely.

With both the patches combined, we are configuring DSS with FIFO merge 
enabled, but configuring thresholds normally and not utilising the large 
FIFO. Getting underflows with this is strange, because it's more or less 
similar to what it was on 3.3 without FIFO merge.

Archit

>
> Cheers,
> Joe
>
>>   Tomi
>>
>
>
>

