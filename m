From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 00/08] OMAP3: SR: Fixes in Smartreflex driver - Resending
Date: Tue, 24 Mar 2009 09:13:16 -0700
Message-ID: <87ab7a292b.fsf@deeprootsystems.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02FAFEE9A9@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f118.google.com ([209.85.221.118]:60987 "EHLO
	mail-qy0-f118.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762758AbZCXQNY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Mar 2009 12:13:24 -0400
Received: by qyk16 with SMTP id 16so3394775qyk.33
        for <linux-omap@vger.kernel.org>; Tue, 24 Mar 2009 09:13:19 -0700 (PDT)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB02FAFEE9A9@dbde02.ent.ti.com> (Teerth Reddy's message of "Tue\, 24 Mar 2009 16\:22\:05 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Reddy, Teerth" <teerth@ti.com>, Rajendra Nayak <rnayak@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Reddy, Teerth" <teerth@ti.com> writes:

> Resending the patches sent by Rajendra after fixing Kevin's comments and cleanup.
>
> This series fixes a set of defects/issues in Smartreflex driver. SR autocompensation is now functional and is validated with these patches on a ES3.1 based SDP with the N values in Efuse.
>
> Patches apply on top of the pm-2.6.28 branch from Kevin's pm tree.
> git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git 
>

This series doesn't compile unless SRF is enabled which after a little
more digging makes me see that SmartReflex is not pretty tightly
coupled to SRF. 

I don't think SmartReflex support need to be dependent on SRF?  It
seems like the resource_get_level() calls should be replaced by OMAP
PM layer calls.  In particular, resource_get_level("vdd_opp1") could
be replaced by omap_pm_dsp_get_opp() etc.

Also, one more nitpick about cleanup while we're at it:

Can you convert all the bit defines (0x1 << n) into BIT(n)

Kevin


