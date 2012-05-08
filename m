From: Archit Taneja <a0393947@ti.com>
Subject: Re: [PATCH 0/6] OMAPDSS: Misc fixes and cleanups
Date: Tue, 8 May 2012 17:42:04 +0530
Message-ID: <4FA90D94.3020705@ti.com>
References: <1336389696-21636-1-git-send-email-archit@ti.com> <1336478337.5761.29.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33624 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751307Ab2EHMMp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 May 2012 08:12:45 -0400
In-Reply-To: <1336478337.5761.29.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Tuesday 08 May 2012 05:28 PM, Tomi Valkeinen wrote:
> On Mon, 2012-05-07 at 16:51 +0530, Archit Taneja wrote:
>> The first patch in this series is a follow up on the previously posted series
>> 'OMAPDSS: APPLY: Treat overlay manager timings as shadow registers'. It is
>> required for HDMI and DPI interfaces to work properly, it ensures manager
>> timings are applied in the set_timing() ops for these interfaces.
>>
>> The next 3 patches remove some unnecessary usage of omap_dss_device pointer in
>> DISPC and APPLY.
>>
>> The last 2 patches are miscellaneous fixes and are self explanatory.
>>
>> Reference tree containing this series:
>>
>> git://gitorious.org/~boddob/linux-omap-dss2/archit-dss2-clone.git mgr_timing_and_fixes
>>
>> Tested on OMAP4 SDP.
>>
>> Archit Taneja (6):
>>    OMAPDSS: DPI/HDMI: Apply manager timings even if panel is disabled
>>    OMAPDSS: APPLY: Remove an unnecessary omap_dss_device pointer
>>    OMAPDSS: DISPC: Remove omap_dss_device pointer usage from
>>      dispc_mgr_pclk_rate()
>>    OMAPDSS: DISPC: Remove usage of dispc_mgr_get_device()
>>    OMAPDSS: Fix DSI_FCLK clock source selection
>>    OMAPDSS: DISPC: Remove Fake VSYNC support
>
> The first four patches seem to be related (or at least based) to the
> set_timings series (and the first patch you already had included in
> later version).
>
> Should I take the two last patches and apply them already, as they are
> fine and don't depend on anything? You could add the first 4 patches
> into the set_timings series.

Yes, you can apply the last 2 patches.

Thanks,
Archit

>
>   Tomi
>

