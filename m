From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [RFC] omap: mailbox: fix detection for previously supported chips
Date: Thu, 23 Sep 2010 17:30:25 -0700
Message-ID: <878w2sm19a.fsf@deeprootsystems.com>
References: <1285201299-18306-1-git-send-email-omar.ramirez@ti.com>
	<27F9C60D11D683428E133F85D2BB4A530450EDDD15@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:63093 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751990Ab0IXAa1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Sep 2010 20:30:27 -0400
Received: by pvg2 with SMTP id 2so525762pvg.19
        for <linux-omap@vger.kernel.org>; Thu, 23 Sep 2010 17:30:27 -0700 (PDT)
In-Reply-To: <27F9C60D11D683428E133F85D2BB4A530450EDDD15@dlee03.ent.ti.com>
	(Ramirez Luna's message of "Thu, 23 Sep 2010 19:08:29 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@gmail.com>, "Anna, Suman" <s-anna@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

"Ramirez Luna, Omar" <omar.ramirez@ti.com> writes:

> Ramirez Luna, Omar wrote:
>> Fix the mailbox support detection for OMAP3630, 3530/25 and 2430.
>> 
>> Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
>> ---
>> - Testing was made under 3630 and 3430 boards.
>> - Given that 2430 uses similar initialization than OMAP3, changes
>>   to handle this case was added to the patch.
>> - HWMOD adaptation hopefully should solve this mess, but as of now
>>   mailbox should work as before at least.
>> 
>>  arch/arm/mach-omap2/mailbox.c |   12 ++++++++----
>>  1 files changed, 8 insertions(+), 4 deletions(-)
>> 
>> diff --git a/arch/arm/mach-omap2/mailbox.c
>> b/arch/arm/mach-omap2/mailbox.c index 42dbfa4..26d6fb0 100644 ---
>> a/arch/arm/mach-omap2/mailbox.c +++ b/arch/arm/mach-omap2/mailbox.c
>> @@ -394,15 +394,19 @@ static int __devinit omap2_mbox_probe(struct
>> platform_device *pdev) 
>> 
>>  	if (false)
>>  		;
>> -#if defined(CONFIG_ARCH_OMAP3430)
>> -	else if (cpu_is_omap3430()) {
>> +#if defined(CONFIG_ARCH_OMAP3)
>> +	else if (omap3_has_iva()) {
>
> Hmm, seems omap3_has_ ##feat are only available for built-in and not module configurations, this patch is not so good after all since it throws:
>
> ERROR: "omap3_features" [arch/arm/mach-omap2/mailbox_mach.ko] undefined!

Well, feature detection certainly should be available to modules.

How about proposing a simple fix for this.  Something like the following
(untested) should work, since the individual omap3_has_* checks are
static inlines.

Kevin


diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 9a879f9..a8c6d19 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -31,6 +31,7 @@ static struct omap_chip_id omap_chip;
 static unsigned int omap_revision;
 
 u32 omap3_features;
+EXPORT_SYMBOL(omap3_features);
 
 unsigned int omap_rev(void)
 {

