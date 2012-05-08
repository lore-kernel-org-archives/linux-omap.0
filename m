From: Archit Taneja <a0393947@ti.com>
Subject: Re: [PATCH 0/2] OMAPDSS: HDMI: Fix register dump of CORE registers
Date: Tue, 8 May 2012 17:39:55 +0530
Message-ID: <4FA90D13.6010307@ti.com>
References: <1336396828-29311-1-git-send-email-archit@ti.com> <1336478684.5761.30.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46224 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753767Ab2EHMKh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 May 2012 08:10:37 -0400
In-Reply-To: <1336478684.5761.30.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

Hi,

On Tuesday 08 May 2012 05:34 PM, Tomi Valkeinen wrote:
> On Mon, 2012-05-07 at 18:50 +0530, Archit Taneja wrote:
>> The HDMI CORE registers are dumped incorrectly due to incorrect register offset
>> calculations. They are also dumped in a random order, with some of the registers
>> repeated. This series fixes these issues.
>>
>> The patches apply over:
>>
>> git://gitorious.org/linux-omap-dss2/linux.git dev
>>
>> Tested on OMAP4 SDP.
>>
>> Archit Taneja (2):
>>    OMAPDSS: HDMI: Fix ti_hdmi_4xxx_core_dump
>>    OMAPDSS: HDMI: define and dump CORE registers in correct order
>>
>>   drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c |  163 +++++++++++++++--------------
>>   drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h |   57 +++++------
>>   2 files changed, 109 insertions(+), 111 deletions(-)
>
> Thanks, applying these.

In the second patch, there are some unnecessary lines left in the 
core_dump function():

-	DUMPCOREAV(HDMI_CORE_AV_AVI_CHSUM);

-	for (i = 0; i < HDMI_CORE_AV_AVI_DBYTE_NELEMS; i++)
-		DUMPCOREAV2(i, HDMI_CORE_AV_AVI_DBYTE);

-	for (i = 0; i < HDMI_CORE_AV_SPD_DBYTE_NELEMS; i++)
-		DUMPCOREAV2(i, HDMI_CORE_AV_SPD_DBYTE);

-	for (i = 0; i < HDMI_CORE_AV_AUD_DBYTE_NELEMS; i++)
-		DUMPCOREAV2(i, HDMI_CORE_AV_AUD_DBYTE);
-
-	for (i = 0; i < HDMI_CORE_AV_MPEG_DBYTE_NELEMS; i++)
-		DUMPCOREAV2(i, HDMI_CORE_AV_MPEG_DBYTE);

-	for (i = 0; i < HDMI_CORE_AV_GEN_DBYTE_NELEMS; i++)
-		DUMPCOREAV2(i, HDMI_CORE_AV_GEN_DBYTE);
-
-	for (i = 0; i < HDMI_CORE_AV_GEN2_DBYTE_NELEMS; i++)
-		DUMPCOREAV2(i, HDMI_CORE_AV_GEN2_DBYTE);

So you will see 5 annoying empty lines, could you remove those when you 
apply, i totally missed this out..

Thanks,
Archit

>
>   Tomi
>

