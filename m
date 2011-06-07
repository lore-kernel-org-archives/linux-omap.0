From: Alexander Holler <holler@ahsoftware.de>
Subject: Re: [PATCH] arm: omap3: beagle: Ensure msecure is mux'd to be able
 to set the RTC
Date: Tue, 07 Jun 2011 10:01:58 +0200
Message-ID: <4DEDDAF6.2070505@ahsoftware.de>
References: <4D9AEB76.2060509@ahsoftware.de> <1302010808-3065-1-git-send-email-holler@ahsoftware.de> <20110531102903.GU11352@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from h1446028.stratoserver.net ([85.214.92.142]:55213 "EHLO
	mail.ahsoftware.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751261Ab1FGIKw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Jun 2011 04:10:52 -0400
Received: from eiche.ahsoftware (p57B2165D.dip0.t-ipconnect.de [87.178.22.93])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.ahsoftware.de (Postfix) with ESMTPSA id 60BC74344AD
	for <linux-omap@vger.kernel.org>; Tue,  7 Jun 2011 10:02:21 +0200 (CEST)
In-Reply-To: <20110531102903.GU11352@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Am 31.05.2011 12:29, schrieb Tony Lindgren:
> * Alexander Holler<holler@ahsoftware.de>  [110405 06:38]:
>> Without msecure beeing high it isn't possible to set (or start)
>> the RTC.
>>
>> Tested with a BeagleBoard C4.
>
> Adding this into fixes.
>
> Tony
>
>> Signed-off-by: Alexander Holler<holler@ahsoftware.de>
>> ---
>>   arch/arm/mach-omap2/board-omap3beagle.c |    3 +++
>>   1 files changed, 3 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
>> index 46d814a..ebe3a7e 100644
>> --- a/arch/arm/mach-omap2/board-omap3beagle.c
>> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
>> @@ -628,6 +628,9 @@ static void __init omap3_beagle_init(void)
>>   	usb_ehci_init(&ehci_pdata);
>>   	omap3beagle_flash_init();
>>
>> +	/* Ensure msecure is mux'd to be able to set the RTC. */
>> +	omap_mux_init_signal("sys_drm_msecure", OMAP_PIN_OFF_OUTPUT_HIGH);
>> +
>>   	/* Ensure SDRC pins are mux'd for self-refresh */
>>   	omap_mux_init_signal("sdrc_cke0", OMAP_PIN_OUTPUT);
>>   	omap_mux_init_signal("sdrc_cke1", OMAP_PIN_OUTPUT);
>> --
>> 1.7.3.4
>>

I've later switched to the following patch which muxes msecure as GPIO 
(the drm-mode isn't explained in the TRM) and also exports the GPIO, so 
root could easily switch it to prevent modifications on the RTC.

(Warning, either my clipboard or the version of Thunderbird I'm 
currently using replaces the tabs with spaces in the pasted patch and 
I'm currently too lazy to search a workaround).

---
  arch/arm/mach-omap2/board-omap3beagle.c |    6 ++++++
  1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c 
b/arch/arm/mach-omap2/board-omap3beagle.c
index 33007fd..24b4417 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -673,6 +673,12 @@ static void __init omap3_beagle_init(void)
         usbhs_init(&usbhs_bdata);
         omap3beagle_flash_init();

+       /* Ensure msecure is high to be able to set the RTC. */
+       omap_mux_init_signal("gpio_22", OMAP_PIN_OFF_OUTPUT_HIGH);
+       gpio_request(22, "msecure");
+       gpio_direction_output(22, true);
+       gpio_export(22, false);
+
         /* Ensure SDRC pins are mux'd for self-refresh */
         omap_mux_init_signal("sdrc_cke0", OMAP_PIN_OUTPUT);
         omap_mux_init_signal("sdrc_cke1", OMAP_PIN_OUTPUT);
-- 
1.7.3.4

Regards,

Alexander Holler
