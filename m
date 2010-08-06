From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [PM-SR][PATCH 03/12] omap3: voltage: expose
 omap_change_voltscale_method
Date: Fri, 6 Aug 2010 12:37:30 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB032401CE4A@dbde02.ent.ti.com>
References: <1281047052-21346-1-git-send-email-nm@ti.com>
 <1281047052-21346-4-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39282 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758123Ab0HFHHd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Aug 2010 03:07:33 -0400
In-Reply-To: <1281047052-21346-4-git-send-email-nm@ti.com>
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
>>Subject: [PM-SR][PATCH 03/12] omap3: voltage: expose omap_change_voltscale_method
>>
>>omap_change_voltscale_method is meant to be used for board files
>>desiring to choose a different scaling technique. so this function
>>should be exposed to the world.
>>
>>also fixes sparse warning:
>>arch/arm/mach-omap2/voltage.c:1047:6: warning: symbol 'omap_change_voltscale_method' was not
>>declared. Should it be static?
>>
>>Cc: Kevin Hilman <khilman@deeprootsystems.com>
>>Cc: Thara Gopinath <thara@ti.com>
>>
>>Signed-off-by: Nishanth Menon <nm@ti.com>
>>---
>> arch/arm/mach-omap2/voltage.h |    1 +
>> 1 files changed, 1 insertions(+), 0 deletions(-)
>>
>>diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
>>index a7be515..6dc8ce4 100644
>>--- a/arch/arm/mach-omap2/voltage.h
>>+++ b/arch/arm/mach-omap2/voltage.h
>>@@ -113,6 +113,7 @@ void omap_voltageprocessor_enable(int vp_id);
>> void omap_voltageprocessor_disable(int vp_id);
>> int omap_voltage_scale(int vdd, unsigned long target_volt);
>> void omap_reset_voltage(int vdd);
>>+void omap_change_voltscale_method(int voltscale_method);

Collated with rest of the series

Regards
Thara
>> int omap_get_voltage_table(int vdd, struct omap_volt_data **volt_data);
>> struct omap_volt_data *omap_get_volt_data(int vdd, unsigned long volt);
>> void omap_voltage_register_pmic(struct omap_volt_pmic_info *pmic_info);
>>--
>>1.6.3.3

