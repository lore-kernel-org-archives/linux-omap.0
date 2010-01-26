From: "Andrew Murray" <amurray@mpc-data.co.uk>
Subject: RE: Issue with pm_debug?
Date: Tue, 26 Jan 2010 16:39:01 -0000
Message-ID: <0C997DD87CC88A4F86C897F52650B52B028076F7@MOLSON.mpc-data.co.uk>
References: <0C997DD87CC88A4F86C897F52650B52B025627F2@MOLSON.mpc-data.co.uk> <87my0025gd.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cvs.mpc-ogw.co.uk ([81.2.99.171]:53381 "EHLO
	molson.mpc-data.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753846Ab0AZQjK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Jan 2010 11:39:10 -0500
Content-class: urn:content-classes:message
In-Reply-To: <87my0025gd.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

Hi Kevin,

Thanks for the detailed response. I will try to find an un-solved bug to
report next time ;)

Thanks,

Andrew Murray

-----Original Message-----
From: Kevin Hilman [mailto:khilman@deeprootsystems.com] 
Sent: 26 January 2010 16:32
To: Andrew Murray
Cc: linux-omap@vger.kernel.org
Subject: Re: Issue with pm_debug?

"Andrew Murray" <amurray@mpc-data.co.uk> writes:

> Hello,
>
> I've been studying the power management support on the OMAP 35x EVM
(Rev
> G) and have noticed something which seems inconsistent with the
> documentation. 
>
> According to the elinux OMAP Power Management wiki page
> (http://elinux.org/OMAP_Power_Management) - setting "sleep_while_idle"
> to '1' and setting "enable_off_mode" and "voltage_off_while_idle" to
'0'
> in the debugfs should result in a kernel which will never hit 'off'
> sleep states. 
>
> However in this set up (with both ladder and menu governor) I've found
> that in this state the C5 and C6 states are entered (according to
> /sys/devices/system/cpu/cpu0/cpuidle/state[5/6]/time). However
according
> to the sources these states include the off state. 
>
> Also the /debug/pm_debug/time indicates the off state wasn't reached.
> Therefore is it just the case that the CPUIdle framework requested
C5/6
> and the omap driver accepted by actually used another state?

Yes, you're correct.

(also, as an aside, /debug/pm_debug/count might be useful to you as
well)

> Is this incorrect behaviour? 

Yes, this is a bug.

This is a known problem in that CPUidle statistics are wrong because
we don't correctly report back to CPUidle the actual state that was
entered when enable_off_mode==0.  Sanjeev has proposed a patch for
this and I have requested some changes from him:

   http://patchwork.kernel.org/patch/62533/

after the changes I have proposed, I plan to merge this into the PM
branch.  We have a similar issue with the recently posted OSWR
support, and Sanjeev's patch will address both dynamic enable of
off-mode and of OSWR.

> Or is my understanding of power management implementation incorrect?
> Any clarifications would be of great value.
>
> I've used the 'pm' branch in the khilman linux-omap-pm repository. (Is
> this the most appropriate mailing list?)

Yes, you're in the right place :)

Thanks for reporting the problem and the thorough analysis.

Kevin


No virus found in this incoming message.
Checked by AVG - www.avg.com 
Version: 8.5.432 / Virus Database: 271.1.1/2641 - Release Date: 01/25/10
19:36:00
