From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 00/02] OMAP3 clock: Remove virtual clock nodes
Date: Fri, 03 Apr 2009 09:59:21 -0700
Message-ID: <873acpzn9y.fsf@deeprootsystems.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02FB102C27@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.168]:17893 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764753AbZDCQ7Z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Apr 2009 12:59:25 -0400
Received: by wf-out-1314.google.com with SMTP id 29so1280199wff.4
        for <linux-omap@vger.kernel.org>; Fri, 03 Apr 2009 09:59:23 -0700 (PDT)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB02FB102C27@dbde02.ent.ti.com> (Rajendra Nayak's message of "Fri\, 3 Apr 2009 21\:49\:58 +0530")
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
> Patches generated and apply on latest pm branch from Kevin's pm tree.
>

Rajendra,

This series does not apply against the PM branch.

It seems your patches have TABs converted to spaces.  For example, in
01/02 the first hunk which removes a bunch of code is trying to remove
lines with spaces and the original code is all TABs, so the patch
fails.

Please resubmit with correct formatting so it applies cleanly.

Kevin

