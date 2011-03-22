From: Archit Taneja <archit@ti.com>
Subject: Re: [PATCH 1/3] OMAP4: DSS2: Register configuration changes for DSI
Date: Tue, 22 Mar 2011 17:46:44 +0530
Message-ID: <4D88932C.4050501@ti.com>
References: <1300793616-2669-1-git-send-email-archit@ti.com> <1300795615.2498.99.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40851 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753665Ab1CVMMW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Mar 2011 08:12:22 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p2MCCJe0024094
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 22 Mar 2011 07:12:21 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p2MCCIQe026697
	for <linux-omap@vger.kernel.org>; Tue, 22 Mar 2011 17:42:18 +0530 (IST)
In-Reply-To: <1300795615.2498.99.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Tuesday 22 March 2011 05:36 PM, Valkeinen, Tomi wrote:
> On Tue, 2011-03-22 at 06:33 -0500, Taneja, Archit wrote:
>> The following changes have changed from OMAP3 to OMAP4 DSI:
>> -The register field DSI_PLL_FREQSEL in DSI_PLL_CONFIGURATION2 has been removed.
>> -DCS_CMD_ENABLE and DCS_CMD_CODE bits have been moved from DSI_CTRL to
>> DSI_VC_CTRLi, hence the control of the bits is available per VC.
>> -DSI LDO powergood notification doesn't work on OMAP4. This is mentioned in
>> OMAP4 errata revision 1.8(Errata 1.76).
>> -OCP_WIDTH register field is included in DSI_VC_CTRL.
>> -The SCP clock is also required to access DSI PLL registers
>>
>> Introduce dss features for these changes so that DSI runs on both OMAP3 and
>> OMAP4.
>>
>> Signed-off-by: Archit Taneja<archit@ti.com>
>> ---
>>   drivers/video/omap2/dss/dsi.c          |   60 ++++++++++++++++++++-----------
>>   drivers/video/omap2/dss/dss_features.c |    9 +++--
>>   drivers/video/omap2/dss/dss_features.h |   30 +++++++++-------
>>   3 files changed, 62 insertions(+), 37 deletions(-)
>
> The patch itself looks fine, but the subject says this is part 1/3. But
> I presume this is the only patch.

Yes it is. Sorry for the wrong subject.

Archit
>
>   Tomi
>
>

