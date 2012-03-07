From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: gpmc-smsc911x: only register regulator for first instance
Date: Tue, 06 Mar 2012 17:39:33 -0800
Message-ID: <87sjhlnq96.fsf@ti.com>
References: <1331080771-30687-1-git-send-email-khilman@ti.com>
	<20120307004405.GC12083@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:49041 "HELO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S964983Ab2CGBjg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Mar 2012 20:39:36 -0500
Received: by mail-tul01m020-f181.google.com with SMTP id eq6so7258094obc.12
        for <linux-omap@vger.kernel.org>; Tue, 06 Mar 2012 17:39:36 -0800 (PST)
In-Reply-To: <20120307004405.GC12083@atomide.com> (Tony Lindgren's message of
	"Tue, 6 Mar 2012 16:44:05 -0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Matt Porter <mporter@ti.com>

Tony Lindgren <tony@atomide.com> writes:

> * Kevin Hilman <khilman@ti.com> [120306 16:07]:
>> commit e4b0b2cbbb (ARM: OMAP2+: gpmc-smsc911x: add required smsc911x
>> regulators) added regulators which are registered during
>> gpmc_smsc911x_init().  However, some platforms (OMAP3/Overo) have more
>> than one instance of the SMSC911x and result in attempting to register
>> the same regulator more than once which causes a panic().
>> 
>> Fix this by only registering the regulator when the platform_data id
>> field is zero, indicating its the first instance.
>> 
>> Cc: Matt Porter <mporter@ti.com>
>> Signed-off-by: Kevin Hilman <khilman@ti.com>
>> ---
>> Fix needed for v3.3.
>> Applies on top of Tony's fixes branch.
>> 
>>  arch/arm/mach-omap2/gpmc-smsc911x.c |   11 +++++++----
>>  1 file changed, 7 insertions(+), 4 deletions(-)
>> 
>> diff --git a/arch/arm/mach-omap2/gpmc-smsc911x.c b/arch/arm/mach-omap2/gpmc-smsc911x.c
>> index bbb870c..4d6f1c6 100644
>> --- a/arch/arm/mach-omap2/gpmc-smsc911x.c
>> +++ b/arch/arm/mach-omap2/gpmc-smsc911x.c
>> @@ -101,10 +101,13 @@ void __init gpmc_smsc911x_init(struct omap_smsc911x_platform_data *board_data)
>>  
>>  	gpmc_cfg = board_data;
>>  
>> -	ret = platform_device_register(&gpmc_smsc911x_regulator);
>> -	if (ret < 0) {
>> -		pr_err("Unable to register smsc911x regulators: %d\n", ret);
>> -		return;
>> +	if (!gpmc_cfg) {
>
> Shouldn't this be !gpmc_cfg->id instead..

doh, of course.  Updated patch below.

Kevin

>From 3c17a6fe6fdcc5e4e33f174c2b0982d71e759cf1 Mon Sep 17 00:00:00 2001
From: Kevin Hilman <khilman@ti.com>
Date: Thu, 1 Mar 2012 12:30:42 -0800
Subject: [PATCH] ARM: OMAP2+: gpmc-smsc911x: only register regulator for
 first instance

commit e4b0b2cbbb (ARM: OMAP2+: gpmc-smsc911x: add required smsc911x
regulators) added regulators which are registered during
gpmc_smsc911x_init().  However, some platforms (OMAP3/Overo) have more
than one instance of the SMSC911x and result in attempting to register
the same regulator more than once which causes a panic().

Fix this by only registering the regulator when the platform_data id
field is zero, indicating its the first instance.

Cc: Matt Porter <mporter@ti.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/gpmc-smsc911x.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc-smsc911x.c b/arch/arm/mach-omap2/gpmc-smsc911x.c
index bbb870c..5e5880d 100644
--- a/arch/arm/mach-omap2/gpmc-smsc911x.c
+++ b/arch/arm/mach-omap2/gpmc-smsc911x.c
@@ -101,10 +101,13 @@ void __init gpmc_smsc911x_init(struct omap_smsc911x_platform_data *board_data)
 
 	gpmc_cfg = board_data;
 
-	ret = platform_device_register(&gpmc_smsc911x_regulator);
-	if (ret < 0) {
-		pr_err("Unable to register smsc911x regulators: %d\n", ret);
-		return;
+	if (!gpmc_cfg->id) {
+		ret = platform_device_register(&gpmc_smsc911x_regulator);
+		if (ret < 0) {
+			pr_err("Unable to register smsc911x regulators: %d\n",
+			       ret);
+			return;
+		}
 	}
 
 	if (gpmc_cs_request(gpmc_cfg->cs, SZ_16M, &cs_mem_base) < 0) {
-- 
1.7.9.2

