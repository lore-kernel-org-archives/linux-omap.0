From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [PM-SR][PATCH 12/12] omap3: sr: class3: make class3_data static
Date: Fri, 6 Aug 2010 13:02:29 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB032401CE60@dbde02.ent.ti.com>
References: <1281047052-21346-1-git-send-email-nm@ti.com>
 <1281047052-21346-13-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51309 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757837Ab0HFHcc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Aug 2010 03:32:32 -0400
In-Reply-To: <1281047052-21346-13-git-send-email-nm@ti.com>
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
>>Subject: [PM-SR][PATCH 12/12] omap3: sr: class3: make class3_data static
>>
>>we dont expose the structure to the world, so this should be static
>>however, since sr core does not take a copy of the same, we cant make
>>it __init data.
>>
>>fixes sparse warning:
>>arch/arm/mach-omap2/smartreflex-class3.c:50:36: warning: symbol 'class3_data' was not declared.
>>Should it be static?
>>
>>Cc: Kevin Hilman <khilman@deeprootsystems.com>
>>Cc: Thara Gopinath <thara@ti.com>
>>
>>Signed-off-by: Nishanth Menon <nm@ti.com>
>>---
>> arch/arm/mach-omap2/smartreflex-class3.c |    2 +-
>> 1 files changed, 1 insertions(+), 1 deletions(-)
>>
>>diff --git a/arch/arm/mach-omap2/smartreflex-class3.c b/arch/arm/mach-omap2/smartreflex-class3.c
>>index f3b766f..530b2f0 100644
>>--- a/arch/arm/mach-omap2/smartreflex-class3.c
>>+++ b/arch/arm/mach-omap2/smartreflex-class3.c
>>@@ -47,7 +47,7 @@ static int sr_class3_configure(int id)
>> }
>>
>> /* SR class3 structure */
>>-struct omap_smartreflex_class_data class3_data = {
>>+static struct omap_smartreflex_class_data class3_data = {
>> 	.enable = sr_class3_enable,
>> 	.disable = sr_class3_disable,
>> 	.configure = sr_class3_configure,

Taken in 
Regards
Thara
>>--
>>1.6.3.3

