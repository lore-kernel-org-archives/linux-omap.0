From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 7/8] OMAP: omap_device: warn about expected latencies
 only if non-zero
Date: Wed, 18 Nov 2009 04:19:20 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0911180412120.25515@utopia.booyaka.com>
References: <1258506313-17115-1-git-send-email-khilman@deeprootsystems.com> <1258506313-17115-2-git-send-email-khilman@deeprootsystems.com> <1258506313-17115-3-git-send-email-khilman@deeprootsystems.com> <1258506313-17115-4-git-send-email-khilman@deeprootsystems.com>
 <1258506313-17115-5-git-send-email-khilman@deeprootsystems.com> <1258506313-17115-6-git-send-email-khilman@deeprootsystems.com> <1258506313-17115-7-git-send-email-khilman@deeprootsystems.com> <1258506313-17115-8-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:56785 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751284AbZKRLTO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Nov 2009 06:19:14 -0500
In-Reply-To: <1258506313-17115-8-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

Hi,

On Tue, 17 Nov 2009, Kevin Hilman wrote:

> When checking measured [de]activate latencies against expected
> latencies, only print warning if driver has provided a non-zero
> latency.
> 
> This allows drivers to set their [de]activate latencies to zero when
> they are not known, or are don't care, and the omap_device core will
> not complain about unexpected latencies.

I'm concerned that this will effectively mean that no driver maintainers 
will bother to measure these latencies.   These are necessary for 
a reasonable implementation of omap_pm_set_max_dev_wakeup_lat().
They should not be difficult to measure: boot at the lowest-performance 
OPPs with the latencies uninitialized; then these warnings should indicate 
numbers that can be plugged back into the omap_device structure.  But 
perhaps I am misunderstanding the point you are making?


- Paul
