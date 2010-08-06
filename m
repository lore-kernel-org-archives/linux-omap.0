From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [PM-SR][PATCH 05/12] omap3: sr: device: check for dev_attr
Date: Fri, 6 Aug 2010 12:57:31 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB032401CE5B@dbde02.ent.ti.com>
References: <1281047052-21346-1-git-send-email-nm@ti.com>
 <1281047052-21346-6-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59444 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754606Ab0HFH1e convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Aug 2010 03:27:34 -0400
In-Reply-To: <1281047052-21346-6-git-send-email-nm@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>, linux-omap <linux-omap@vger.kernel.org>
Cc: Kevin Hilman <khilman@deeprootsystems.com>



>>-----Original Message-----
>>From: Menon, Nishanth
>>Sent: Friday, August 06, 2010 3:54 AM
>>To: linux-omap
>>Cc: Menon, Nishanth; Kevin Hilman; Gopinath, Thara
>>Subject: [PM-SR][PATCH 05/12] omap3: sr: device: check for dev_attr
>>
>>In the unlikely case that hwmod database is messed up, dont crash
>>report error and attempt to recover.
>>
>>Cc: Kevin Hilman <khilman@deeprootsystems.com>
>>Cc: Thara Gopinath <thara@ti.com>
>>
>>Signed-off-by: Nishanth Menon <nm@ti.com>
>>---
>> arch/arm/mach-omap2/sr_device.c |    6 ++++++
>> 1 files changed, 6 insertions(+), 0 deletions(-)
>>
>>diff --git a/arch/arm/mach-omap2/sr_device.c b/arch/arm/mach-omap2/sr_device.c
>>index 7d13704..6f70da6 100644
>>--- a/arch/arm/mach-omap2/sr_device.c
>>+++ b/arch/arm/mach-omap2/sr_device.c
>>@@ -130,6 +130,12 @@ static int sr_dev_init(struct omap_hwmod *oh, void *user)
>> 	}
>>
>> 	sr_dev_data = (struct omap_sr_dev_data *)oh->dev_attr;
>>+	if (unlikely(!sr_dev_data)) {
>>+		pr_err("%s: Bad oh->dev_attr!\n", __func__);
>>+		kfree(sr_data);
>>+		return -EINVAL;
>>+	}

Taken in after modifications as per the reply for patch 06/12

Regards
Thara
>>+
>> 	/*
>> 	 * OMAP3430 ES3.1 chips by default come with Efuse burnt
>> 	 * with parameters required for full functionality of
>>--
>>1.6.3.3

