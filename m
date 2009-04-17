From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 00/10] OMAP3: SR: Fixes in Smartreflex driver
Date: Fri, 17 Apr 2009 08:35:24 -0500
Message-ID: <87tz4n8ktf.fsf@deeprootsystems.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02FB25180A@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:44414 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752618AbZDQNf2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Apr 2009 09:35:28 -0400
Received: by wa-out-1112.google.com with SMTP id j5so501515wah.21
        for <linux-omap@vger.kernel.org>; Fri, 17 Apr 2009 06:35:26 -0700 (PDT)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB02FB25180A@dbde02.ent.ti.com> (Rajendra Nayak's message of "Wed\, 15 Apr 2009 18\:25\:05 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nayak, Rajendra" <rnayak@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

"Nayak, Rajendra" <rnayak@ti.com> writes:

> Re-sending this patch-set with some mailer issues resolved. They now apply cleanly
> with a git-am/git-apply.
>
> Hi,
>
> This series fixes a set of defects/issues in Smartreflex driver. SR autocompensation is now
> functional and is validated with these patches on a ES3.1 based SDP with the N values in Efuse.
>
> The patches also make the Smartreflex driver independent of SRF by using the OMAP PM apis
> instead of calls to SRF.
>
> Patches apply on top of the latest pm branch from Kevin's pm tree.
> git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git 
>

Thanks, pushing this series to PM branch.

Kevin
