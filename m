From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: PM branch rebased to 2.6.29... for real this time
Date: Tue, 31 Mar 2009 22:11:54 -0700
Message-ID: <87ljqllzz9.fsf@deeprootsystems.com>
References: <87k56dp5zc.fsf@deeprootsystems.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301CC5F02C1@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.168]:50089 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751524AbZDAFMA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Apr 2009 01:12:00 -0400
Received: by wf-out-1314.google.com with SMTP id 29so3581122wff.4
        for <linux-omap@vger.kernel.org>; Tue, 31 Mar 2009 22:11:58 -0700 (PDT)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301CC5F02C1@dbde02.ent.ti.com> (Sanjeev Premi's message of "Tue\, 31 Mar 2009 20\:25\:55 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Rajendra Nayak <rnayak@ti.com>

"Premi, Sanjeev" <premi@ti.com> writes:

>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org 
>> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Kevin Hilman
>> Sent: Thursday, March 26, 2009 4:26 AM
>> To: linux-omap@vger.kernel.org
>> Subject: PM branch rebased to 2.6.29... for real this time
>> 
>> Hello,
>> 
>> The previous rebase was actually to 2.6.29-rc8.  Now that 2.6.29 is
>> out, I've rebased the PM brach onto linux-omap HEAD just after the
>> 2.6.29 merge.
>> 
>> Minimal retention and off-mode on Beagle and RX51.
>
> Another problem that I found on OMAP3EVM:
>
> When I compiled in CPUidle and CPUfreq (over omap3_evm_defconfig),
> the kernel did not boot-up. The last few statements are:

There are known problems with CPUfreq on top of the new clock
notifiers series.

I am waiting for Rajendra to re-send his series which removes the virt
clocks on top of the latest PM branch.

> <3>clock: dpll5_ck failed transition to 'locked'
> clock: dpll5_ck failed transition to 'locked'
> <6>Disabling unused clock "dpll4_m6x2_ck"
> Disabling unused clock "dpll4_m6x2_ck"
> <6>Disabling unused clock "dpll3_m3x2_ck"
> Disabling unused clock "dpll3_m3x2_ck"
> <6>Disabling unused clock "sys_clkout1"
> Disabling unused clock "sys_clkout1"
>
> The PC is at the WFI statement.
>
> Tried other combinations as well:
>
> 1) only CPUidle enabled - okay.
> 2) only CPUfreq enabled - not okay.
>

Sounds to me like CPUfreq is changing frequencies during bootup.  Did
you select ondemand as the default CPUfreq governor?  If so, can you
try with performance as the default governor.

If you're already using performance, then u-boot is setting a slower
speed and CPUfreq may decide to change it during boot.  If so, can you
try the userspace governor as the default governor.  This should
prevent any automatic CPUFreq changes during bootup.

Kevin



