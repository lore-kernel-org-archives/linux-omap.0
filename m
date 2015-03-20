From: "Grygorii.Strashko@linaro.org" <grygorii.strashko@linaro.org>
Subject: Re: [PATCH] omapdss: extend pm notifier to handle hibernation
Date: Fri, 20 Mar 2015 16:57:09 +0200
Message-ID: <550C3545.8060702@linaro.org>
References: <1424883836-9119-1-git-send-email-grygorii.strashko@linaro.org> <550C108E.3020907@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177]:35687 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751439AbbCTO5T (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Mar 2015 10:57:19 -0400
Received: by lbcgn8 with SMTP id gn8so77115044lbc.2
        for <linux-omap@vger.kernel.org>; Fri, 20 Mar 2015 07:57:18 -0700 (PDT)
In-Reply-To: <550C108E.3020907@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, nm@ti.com, sumit.semwal@linaro.org, linux-omap@vger.kernel.org, kishon@ti.com, linux-fbdev@vger.kernel.org

Hi Tomi,

On 03/20/2015 02:20 PM, Tomi Valkeinen wrote:
> On 25/02/15 19:03, grygorii.strashko@linaro.org wrote:
>> From: Grygorii Strashko <Grygorii.Strashko@linaro.org>
>>
>> Add handling of missed events in omap_dss_pm_notif which are
>> needed to support hibernation (suspend to disk).
>>
>> Signed-off-by: Grygorii Strashko <Grygorii.Strashko@linaro.org>
>> ---
>>   drivers/video/fbdev/omap2/dss/core.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/video/fbdev/omap2/dss/core.c b/drivers/video/fbdev/omap2/dss/core.c
>> index 6b74f73..e60976a 100644
>> --- a/drivers/video/fbdev/omap2/dss/core.c
>> +++ b/drivers/video/fbdev/omap2/dss/core.c
>> @@ -178,11 +178,15 @@ static int omap_dss_pm_notif(struct notifier_block *b, unsigned long v, void *d)
>>   	DSSDBG("pm notif %lu\n", v);
>>   
>>   	switch (v) {
>> +	case PM_HIBERNATION_PREPARE:
>>   	case PM_SUSPEND_PREPARE:
>> +	case PM_RESTORE_PREPARE:
>>   		DSSDBG("suspending displays\n");
>>   		return dss_suspend_all_devices();
>>   
>>   	case PM_POST_SUSPEND:
>> +	case PM_POST_HIBERNATION:
>> +	case PM_POST_RESTORE:
>>   		DSSDBG("resuming displays\n");
>>   		return dss_resume_all_devices();
>>   
> 
> Why suspend displays when PM_RESTORE_PREPARE happens? Why resume when
> PM_POST_RESTORE happens?

We have following sequence when system is restored from hibernation:
- original kernel booted;
- late_initcall_sync(software_resume);
  - pm_notifier_call_chain(PM_RESTORE_PREPARE);
  - freeze_processes
  - check & read hibernation image
  - suspend all devices (.freeze())
  - jump to stored kernel
  - restore devices
  ...

So, all devices should be in frozen/suspended state when we will jump to stored kernel
(device's state should be the same as before creating hib image).

Without this patch I can see a lot of log messages like below:

[    3.642499] Freezing user space processes ... 
[    3.647029]  mmcblk1boot1: unknown partition table
[    3.647043] (elapsed 0.000 seconds) done.
[    3.686414]  mmcblk1boot0: unknown partition table
[    3.714552] PM: Using 1 thread(s) for decompression.
[    3.714552] PM: Loading and decompressing image data (144641 pages)...
[    4.520388] PM: Image loading progress:   0%
[    5.153715] PM: Image loading progress:  10%
[    5.847731] PM: Image loading progress:  20%
[    6.622024] PM: Image loading progress:  30%
[    7.023830] PM: Image loading progress:  40%
[    7.455959] PM: Image loading progress:  50%
[    8.137186] PM: Image loading progress:  60%
[    8.567899] PM: Image loading progress:  70%
[    9.670371] PM: Image loading progress:  80%
[   10.130646] PM: Image loading progress:  90%
[   10.525035] PM: Image loading progress: 100%
[   10.529565] PM: Image loading done.
[   10.533262] PM: Read 578564 kbytes in 6.80 seconds (85.08 MB/s)
[   10.545313] Suspending console(s) (use no_console_suspend to debug)
[  193.721284] PM: freeze of devices complete after 7.891 msecs
[  193.722618] PM: late freeze of devices complete after 1.325 msecs
[  193.723969] PM: noirq freeze of devices complete after 1.343 msecs
[  193.724133] Disabling non-boot CPUs ...
[  193.724792] CPU1: shutdown
[  193.725387] PM: Creating hibernation image:
[  193.725387] PM: Need to copy 144499 pages
[  193.725439] Enabling non-boot CPUs ...
[  193.725783] CPU1: smp_ops.cpu_die() returned, trying to resuscitate
[  193.725790] CPU1: Booted secondary processor
[  193.726069] CPU1 is up
[  193.743772] PM: noirq restore of devices complete after 17.693 msecs
[  193.744691] PM: early restore of devices complete after 0.634 msecs
[  193.951382] [drm:omap_crtc_error_irq] *ERROR* tv: errors: 00008000
[  193.951389] [drm:omap_plane_error_irq] *ERROR* gfx: errors: 00000040
[  193.951402] [drm:omap_crtc_error_irq] *ERROR* tv: errors: 00008000
[  193.951413] [drm:omap_crtc_error_irq] *ERROR* tv: errors: 00008000
[  193.951424] [drm:omap_crtc_error_irq] *ERROR* tv: errors: 00008000
[  193.951435] [drm:omap_crtc_error_irq] *ERROR* tv: errors: 00008000
[  193.951445] [drm:omap_crtc_error_irq] *ERROR* tv: errors: 00008000
[  193.951455] [drm:omap_crtc_error_irq] *ERROR* tv: errors: 00008000
[  193.951465] [drm:omap_crtc_error_irq] *ERROR* tv: errors: 00008000
[  193.951475] [drm:omap_crtc_error_irq] *ERROR* tv: errors: 00008000
[  193.951484] [drm:omap_crtc_error_irq] *ERROR* tv: errors: 00008000
[  193.951567] omap_l3_noc 44000000.ocp: L3 application error: target 2 mod:1 (unclearable)
[  193.951605] omap_l3_noc 44000000.ocp: L3 debug error: target 2 mod:1 (unclearable)
[  194.293226] ata1: SATA link down (SStatus 0 SControl 300)
[  194.560684] PM: restore of devices complete after 610.740 msecs

-- 
regards,
-grygorii
