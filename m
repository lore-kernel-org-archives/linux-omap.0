From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: OMAP baseline test results for v3.7-rc5
Date: Tue, 13 Nov 2012 17:07:39 -0800
Message-ID: <87obj1f0v8.fsf@deeprootsystems.com>
References: <alpine.DEB.2.00.1211121921160.12551@utopia.booyaka.com>
	<20121112225830.GW6801@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:57023 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756052Ab2KNBHd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Nov 2012 20:07:33 -0500
Received: by mail-pa0-f46.google.com with SMTP id hz1so5429059pad.19
        for <linux-omap@vger.kernel.org>; Tue, 13 Nov 2012 17:07:32 -0800 (PST)
In-Reply-To: <20121112225830.GW6801@atomide.com> (Tony Lindgren's message of
	"Mon, 12 Nov 2012 14:58:31 -0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Tony Lindgren <tony@atomide.com> writes:

> * Paul Walmsley <paul@pwsan.com> [121112 11:33]:
>> 
>> Here are some basic OMAP test results for Linux v3.7-rc5.
>> Logs and other details at:
>> 
>>     http://www.pwsan.com/omap/testlogs/test_v3.7-rc5/20121111081034/
>> 
>> 
>> Passing tests
>> -------------
>> 
>> Boot to userspace (9/11): 2420n800, 2430sdp, 3517evm, 3530es3beagle,
>>     3730beaglexm, 37xxevm, 4430es2panda, 5912osk, am335xbone
>>   
>> PM ret/off, suspend + dynamic idle (2/4): 3730beaglexm, 37xxevm
>> 
>> 
>> Failing tests: fixed by posted patches
>> --------------------------------------
>> 
>> Boot tests:
>> 
>> * 3530ES3 Beagle: I2C timeouts during userspace init
>>   - Intermittent, appears on 5 out of 6 boots here
>>   - Aaro Koskinen observes this also on N900
>>   - Appears to be caused by commit 3db11feffc1ad2ab9dea27789e6b5b3032827adc
>>     - http://marc.info/?l=linux-arm-kernel&m=135071372426971&w=2
>>     - http://marc.info/?l=linux-omap&m=135197877112220&w=2
>>   - Revert posted, pending I2C maintainers:
>>     - http://marc.info/?l=linux-arm-kernel&m=135221953727077&w=2
>
> Here's one more booting issue I recently ran into:
>
>     - If DEBUG_LL and earlyprintk are enabled, and omap-serial.c
>       is compiled as a module, the kernel boot hangs early as the
>       clocks for serial port are cut while earlyprintk still uses
>       the port. This might be regression from v3.6.
>  

Can you test if the patch below[1] helps?  With that, it seems to finish
booting for me (based solely on a ping test.)

The problem is a race between the late_initcall for omap_device (which
idles devices that have no drivers) and the late_initcall in
kernel/printk.c which turns off the earlyconsole.   Any printks
that happen between this omap_device late initcall and the earlyconsole
late initcall will crash when accessing the UART.

Kevin

[1]

diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index 7a7d1f2..138114a 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -1275,4 +1275,4 @@ static int __init omap_device_late_init(void)
 	bus_for_each_dev(&platform_bus_type, NULL, NULL, omap_device_late_idle);
 	return 0;
 }
-late_initcall(omap_device_late_init);
+late_initcall_sync(omap_device_late_init);
