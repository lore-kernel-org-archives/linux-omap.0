From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 7/8] OMAP: omap_device: warn about expected latencies only if non-zero
Date: Thu, 19 Nov 2009 11:08:39 -0800
Message-ID: <87r5ru8h8o.fsf@deeprootsystems.com>
References: <1258506313-17115-1-git-send-email-khilman@deeprootsystems.com>
	<1258506313-17115-2-git-send-email-khilman@deeprootsystems.com>
	<1258506313-17115-3-git-send-email-khilman@deeprootsystems.com>
	<1258506313-17115-4-git-send-email-khilman@deeprootsystems.com>
	<1258506313-17115-5-git-send-email-khilman@deeprootsystems.com>
	<1258506313-17115-6-git-send-email-khilman@deeprootsystems.com>
	<1258506313-17115-7-git-send-email-khilman@deeprootsystems.com>
	<1258506313-17115-8-git-send-email-khilman@deeprootsystems.com>
	<alpine.DEB.2.00.0911180412120.25515@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:33201 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751634AbZKSTIe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Nov 2009 14:08:34 -0500
Received: by pwi3 with SMTP id 3so1587337pwi.21
        for <linux-omap@vger.kernel.org>; Thu, 19 Nov 2009 11:08:41 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.0911180412120.25515@utopia.booyaka.com> (Paul Walmsley's message of "Wed\, 18 Nov 2009 04\:19\:20 -0700 \(MST\)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org

Paul Walmsley <paul@pwsan.com> writes:

> Hi,
>
> On Tue, 17 Nov 2009, Kevin Hilman wrote:
>
>> When checking measured [de]activate latencies against expected
>> latencies, only print warning if driver has provided a non-zero
>> latency.
>> 
>> This allows drivers to set their [de]activate latencies to zero when
>> they are not known, or are don't care, and the omap_device core will
>> not complain about unexpected latencies.
>
> I'm concerned that this will effectively mean that no driver maintainers 
> will bother to measure these latencies.   
>
> These are necessary for a reasonable implementation of
> omap_pm_set_max_dev_wakeup_lat().  They should not be difficult to
> measure: boot at the lowest-performance OPPs with the latencies
> uninitialized; then these warnings should indicate numbers that can
> be plugged back into the omap_device structure.  But perhaps I am
> misunderstanding the point you are making?

Part of the issue is being able to do a quick conversion, without
needing to measure latencies (which I'm guilty of.)  

The other part was that I was thinking (the RFC part) was that it
might be useful for performance reasons to not do do any measuring at
all.  Of course, this would preclude a useful max_dev_wakeup_lat() but
we could warn about that.

But, for now I agree. I think getting these latencies in place is more
important than having an optimization for avoiding measurement for now.

Kevin

