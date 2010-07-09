From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [PATCH 2/2] omap3: sr: improve errors handling
Date: Fri, 9 Jul 2010 20:35:06 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB032391F34E@dbde02.ent.ti.com>
References: <1278681612-10521-1-git-send-email-dedekind1@gmail.com>
 <1278681612-10521-2-git-send-email-dedekind1@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44901 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755970Ab0GIPFO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Jul 2010 11:05:14 -0400
In-Reply-To: <1278681612-10521-2-git-send-email-dedekind1@gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Artem Bityutskiy <dedekind1@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Menon, Nishanth" <nm@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Peter p2 De Schrijver <peter.de-schrijver@nokia.com>



>>-----Original Message-----
>>From: Artem Bityutskiy [mailto:dedekind1@gmail.com]
>>Sent: Friday, July 09, 2010 6:50 PM
>>To: linux-omap@vger.kernel.org
>>Cc: Menon, Nishanth; Kevin Hilman; Gopinath, Thara; Peter p2 De Schrijver
>>Subject: [PATCH 2/2] omap3: sr: improve errors handling
>>
>>From: Artem Bityutskiy <Artem.Bityutskiy@nokia.com>
>>
>>Do not forget to check the 'platform_device_add_data()' error code
>>in 'omap_device_build_ss()'.

Hello Artem,

Can we have a better subject and description. The subject esp has got
nothing to do with the fix.

Regards
Thara

>>
>>Signed-off-by: Artem Bityutskiy <Artem.Bityutskiy@nokia.com>
>>---
>> arch/arm/plat-omap/omap_device.c |    4 +++-
>> 1 files changed, 3 insertions(+), 1 deletions(-)
>>
>>diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
>>index f2bd2e2..e8da192 100644
>>--- a/arch/arm/plat-omap/omap_device.c
>>+++ b/arch/arm/plat-omap/omap_device.c
>>@@ -414,7 +414,9 @@ struct omap_device *omap_device_build_ss(const char *pdev_name, int pdev_id,
>> 	od->pdev.num_resources = res_count;
>> 	od->pdev.resource = res;
>>
>>-	platform_device_add_data(&od->pdev, pdata, pdata_len);
>>+	ret = platform_device_add_data(&od->pdev, pdata, pdata_len);
>>+	if (ret)
>>+		goto odbs_exit4;
>>
>> 	od->pm_lats = pm_lats;
>> 	od->pm_lats_cnt = pm_lats_cnt;
>>--
>>1.7.1.1

