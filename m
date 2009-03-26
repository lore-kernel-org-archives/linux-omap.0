From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 00/03] OMAP3 clock: Remove virtual clock nodes
Date: Thu, 26 Mar 2009 11:13:18 -0700
Message-ID: <87iqlwf8zl.fsf@deeprootsystems.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02FAF6EF37@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.27]:55374 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753230AbZCZSNX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Mar 2009 14:13:23 -0400
Received: by qw-out-2122.google.com with SMTP id 8so780067qwh.37
        for <linux-omap@vger.kernel.org>; Thu, 26 Mar 2009 11:13:21 -0700 (PDT)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB02FAF6EF37@dbde02.ent.ti.com> (Rajendra Nayak's message of "Fri\, 20 Mar 2009 19\:20\:02 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nayak, Rajendra" <rnayak@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Nayak, Rajendra" <rnayak@ti.com> writes:

> Hi,
>
> This patch set removes the virtual clock node implementation for
> VDD1/2 on omap3 which was causing issues with recursive locking of spinlocks.
> All references to virtual clock nodes from resource framework and cpufreq
> driver are removed. Resource framework now uses individual dpll clock
> nodes to do frequency scaling.
> Most of the functionality implemented as part of the virtual clock nodes
> is now implemented internally in the resource framework.
>
> Thanks to Tero Kristo <tero.kristo@nokia.com> who has implemented 
> most of these changes.
>
> Patches generated and apply on pm-2.6.28 branch + [PATCH 00/09] OMAP3 clock: Clock rate change notifiers
>

Rajendra,

Paul has released an updated version of the clock notifiers series
which is now included in the latest PM branch.

Can you rebase this series as it doesn't apply against latest clock
notifiers base.

Thanks,

Kevin

