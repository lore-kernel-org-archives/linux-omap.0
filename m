From: <Madhusudhan.Gowda@elektrobit.com>
Subject: RE: [GIT PULL] OMAP PM EMU fix for v3.3
Date: Wed, 22 Feb 2012 10:42:27 +0200
Message-ID: <AA48DD8077D5D945A49BD1782C1140F10122E4FF@fioues08.ebgroup.elektrobit.com>
References: <87liw8agk4.fsf@ti.com><AA48DD8077D5D945A49BD1782C1140F1011EBBC7@fioues08.ebgroup.elektrobit.com><20120127190239.GC9339@atomide.com><AA48DD8077D5D945A49BD1782C1140F1011EBBC8@fioues08.ebgroup.elektrobit.com><AA48DD8077D5D945A49BD1782C1140F10122E2B7@fioues08.ebgroup.elektrobit.com> <87linxa5gk.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtpgw2fi.elektrobit.com ([194.136.18.129]:37116 "EHLO
	smtpgw1fi.elektrobit.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752777Ab2BVImd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Feb 2012 03:42:33 -0500
Received: from fioumg02.ebgroup.elektrobit.com (smtpgw2fi.ebgroup.elektrobit.com [127.0.0.1])
	by smtpgw1fi.elektrobit.com (8.13.8/8.13.8) with ESMTP id q1M8gUhp023196
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 22 Feb 2012 10:42:31 +0200
Received: (from defang@localhost)
	by fioumg02.ebgroup.elektrobit.com (8.13.8/8.13.8/Submit) id q1M8gTeC023192
	for <linux-omap@vger.kernel.org>; Wed, 22 Feb 2012 10:42:29 +0200
Content-class: urn:content-classes:message
In-Reply-To: <87linxa5gk.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@ti.com, paul@pwsan.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com

Hi Kevin / Paul,

I have tested this on beagle board as well as on OMAP3630 based
propriatory phone using SDTI serial trace interface.

Also you can test it by just observing the 
CM_EMU (48005100) clkstctrl register
 48 => 00000001
Across MPU OFF alone

[root@beagleboard /]# echo 0 >
/sys/kernel/debug/pm_debug/neon_pwrdm/suspend
[root@beagleboard /]# echo 0 >
/sys/kernel/debug/pm_debug/mpu_pwrdm/suspend
[root@beagleboard /]# echo 1 >
/sys/kernel/debug/pm_debug/core_pwrdm/suspend
[root@beagleboard /]# echo 1 >
/sys/kernel/debug/pm_debug/per_pwrdm/suspend
[root@beagleboard /]# echo mem >/sys/power/state
[   59.694671] PM: Syncing filesystems ... done.
[   59.758209] Freezing user space processes ... (elapsed 0.02 seconds)
done.
[   59.789947] Freezing remaining freezable tasks ... (elapsed 0.02
seconds) done.
[   59.820709] Suspending console(s) (use no_console_suspend to debug)
[   60.055816] PM: suspend of devices complete after 212.493 msecs
[   60.059661] PM: late suspend of devices complete after 3.784 msecs
[   60.059753] Disabling non-boot CPUs ...
[   64.299865] Successfully put all powerdomains to target state
[   64.302551] PM: early resume of devices complete after 2.319 msecs
[   64.636444] PM: resume of devices complete after 332.336 msecs
[   64.688446] Restarting tasks ... done.
[root@beagleboard /]# 

And then print again the CM_EMU (48005100) clkstctrl register offset 48
this will have the reset value and PRM_EMU (48307100) offset e4 =>
00000100 register confirms the domain wakeup reset from OFF.

At this moment the SDTI serial trace interface looses connection.

With my patch applied the CM_EMU (48005100) clkstctrl register restores
it initial setting across MPU OFF.

Thanks
Gowda


-----Original Message-----
From: Kevin Hilman [mailto:khilman@ti.com] 
Sent: 20 February 2012 17:30
To: Gowda Madhusudhan; Paul Walmsley
Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
tony@atomide.com
Subject: Re: [GIT PULL] OMAP PM EMU fix for v3.3

+Paul

Paul maintains the CM core code and should take this patch if he's OK
with it.

Also, it is most helpful if you describe what platforms it was tested on
and exactly how you tested it.

Thanks,

Kevin

<Madhusudhan.Gowda@elektrobit.com> writes:

> Hi Kevin,
>
> I think you have missed my last mail. Could you please ACK the pull 
> request and pull the same.
>
> Best Regards
> Gowda
>
>
> -----Original Message-----
> From: linux-arm-kernel-bounces@lists.infradead.org
> [mailto:linux-arm-kernel-bounces@lists.infradead.org] On Behalf Of
> linux-arm-kernel-bounces+madhusudhan.gowda=elektrobit.com@lists.infrad
> linux-arm-kernel-bounces+ea
> d.org
> Sent: 28 January 2012 09:58
> To: tony@atomide.com; khilman@ti.com
> Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Subject: RE: [GIT PULL] OMAP PM EMU fix for v3.3
>
> Thanks Tony
>
> Hi Kevin
> Please do the needful and pull the same.
>
> Best Regards
> Gowda
>
>
> -----Original Message-----
> From: linux-arm-kernel-bounces@lists.infradead.org
> [mailto:linux-arm-kernel-bounces@lists.infradead.org] On Behalf Of 
> Tony Lindgren
> Sent: 27 January 2012 21:03
> To: Gowda Madhusudhan
> Cc: Kevin Hilman; linux-omap@vger.kernel.org; 
> linux-arm-kernel@lists.infradead.org
> Subject: Re: [GIT PULL] OMAP PM EMU fix for v3.3
>
> Hi,
>
> * Madhusudhan.Gowda@elektrobit.com <Madhusudhan.Gowda@elektrobit.com>
> [120127 10:25]:
>> Hi Tony,
>> 
>> Please pull the PM EMU off mode fix for v3.3
>
> It's best that Kevin queues this as it affects PM. Or it at least 
> needs an ack from Kevin.
>
> Regards,
>
> Tony
>  
>> Thanks
>> Gowda
>> 
>> The following changes since commit
>> 1c6ece3c23e58d0dbc687407d606f3560ded582a:
>> 
>>   Merge branch 'omap_fixes_a_3.3rc' of git://git.pwsan.com/linux-2.6
>> (2012-01-26 16:48:37 -0800)
>> 
>> are available in the git repository at:
>> 
>>   git://github.com/elektrobit/linux.git linux-omap-emu-fix
>> 
>> Madhusudhan Gowda (1):
>>       ARM: OMAP3 PM:Save and restore EMU context across MPU OFF
>> 
>>  arch/arm/mach-omap2/cm2xxx_3xxx.c |   16 ++++++++++++----
>>  arch/arm/mach-omap2/cm2xxx_3xxx.h |    2 ++
>>  arch/arm/mach-omap2/pm34xx.c      |    8 ++++++++
>>  3 files changed, 22 insertions(+), 4 deletions(-)
>> 
>> 
>> ----------------------------------------------------------------
>> Please note: This e-mail may contain confidential information 
>> intended
>
>> solely for the addressee. If you have received this e-mail in error, 
>> please do not disclose it to anyone, notify the sender promptly, and 
>> delete the message from your system.
>> Thank you.
>> 
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
>
> ----------------------------------------------------------------
> Please note: This e-mail may contain confidential information intended

> solely for the addressee. If you have received this e-mail in error, 
> please do not disclose it to anyone, notify the sender promptly, and 
> delete the message from your system.
> Thank you.
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" 
> in the body of a message to majordomo@vger.kernel.org More majordomo 
> info at  http://vger.kernel.org/majordomo-info.html
