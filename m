From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: PM branch updated
Date: Fri, 07 Aug 2009 10:11:20 -0700
Message-ID: <87ws5f35xj.fsf@deeprootsystems.com>
References: <87d479921p.fsf@deeprootsystems.com>
	<4A7B0F22.7030103@deeprootsystems.com>
	<200908071029.30047.jpihet@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.171]:45321 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753245AbZHGRLX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Aug 2009 13:11:23 -0400
Received: by wf-out-1314.google.com with SMTP id 26so674497wfd.4
        for <linux-omap@vger.kernel.org>; Fri, 07 Aug 2009 10:11:23 -0700 (PDT)
In-Reply-To: <200908071029.30047.jpihet@mvista.com> (Jean Pihet's message of "Fri\, 7 Aug 2009 10\:29\:29 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jpihet@mvista.com>
Cc: linux-omap@vger.kernel.org

Jean Pihet <jpihet@mvista.com> writes:

> On Thursday 06 August 2009 19:13:06 Kevin Hilman wrote:
>> Kevin Hilman wrote:
>> > I just pushed an updated PM branch which was rebased to current
>> > omap/master (which is based on v2.6.31-rc5)
>>
>> Also, please check out
>>
>>    http://elinux.org/OMAP_Power_Management
>>
>> This page includes the stuff I normally put in the announcment of a new
>> PM branch, but also tries to describe how to use the various features of
>> the PM branch (which has been sorely missing for a while.)
>
> I think this page had been long-awaited. Thanks a lot for putting it
> together.
>
> One question about it:
>
> What about the cpufreq interface for doing DVFS? Is it preferred way
> to change OPPs or is it using /sys/power/vddx_opp? I think cpufreq
> utils are more standard, easier to use and to understand.

CPUfreq is much preferred.  The /sys/power/vdd* are just for manual
testing and more fore PM developers than PM users.

Hey, sounds like a perfect opportunity for you to update the wiki. ;)

Kevin
