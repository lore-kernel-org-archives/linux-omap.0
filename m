From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [PM-SR][PATCH 07/12] omap3: sr: device: make omap_sr_latency
 static
Date: Fri, 6 Aug 2010 12:54:50 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB032401CE5A@dbde02.ent.ti.com>
References: <1281047052-21346-1-git-send-email-nm@ti.com>
 <1281047052-21346-8-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49579 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757837Ab0HFHYy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Aug 2010 03:24:54 -0400
In-Reply-To: <1281047052-21346-8-git-send-email-nm@ti.com>
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
>>Subject: [PM-SR][PATCH 07/12] omap3: sr: device: make omap_sr_latency static
>>
>>omap_sr_latency definition does not need to be exposed to the world
>>but we cant make it __init data as the pointer is stored in odev
>>to be used beyond basic kernel boot.
>>
>>also fixes sparse warning:
>>arch/arm/mach-omap2/sr_device.c:32:31: warning: symbol 'omap_sr_latency' was not declared. Should it
>>be static?
>>
>>Cc: Kevin Hilman <khilman@deeprootsystems.com>
>>Cc: Thara Gopinath <thara@ti.com>
>>
>>Signed-off-by: Nishanth Menon <nm@ti.com>
>>---
>> arch/arm/mach-omap2/sr_device.c |    2 +-
>> 1 files changed, 1 insertions(+), 1 deletions(-)
>>
>>diff --git a/arch/arm/mach-omap2/sr_device.c b/arch/arm/mach-omap2/sr_device.c
>>index 8fb60d8..e816666 100644
>>--- a/arch/arm/mach-omap2/sr_device.c
>>+++ b/arch/arm/mach-omap2/sr_device.c
>>@@ -29,7 +29,7 @@
>>
>> #include "voltage.h"
>>
>>-struct omap_device_pm_latency omap_sr_latency[] = {
>>+static struct omap_device_pm_latency omap_sr_latency[] = {
>> 	{
>> 		.deactivate_func = omap_device_idle_hwmods,
>> 		.activate_func	 = omap_device_enable_hwmods,

Taken in

Regards
Thara
>>--
>>1.6.3.3

