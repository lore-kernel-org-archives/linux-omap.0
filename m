From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 00/18] OMAP4: PM data big spring cleanup and fixes
Date: Wed, 6 Jul 2011 01:19:38 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1107060017480.4217@utopia.booyaka.com>
References: <1309552901-8944-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:52139 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753129Ab1GFHTj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Jul 2011 03:19:39 -0400
In-Reply-To: <1309552901-8944-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com

Hi,

On Fri, 1 Jul 2011, Benoit Cousson wrote:

> Here are a bunch of cleanups on almost every PRCM related data files.
> Some of them are purely code moves, and will look like a lot of
> noise for nothing, but this is needed if we want to keep the files
> aligned with generator tool and thus ease the future migration to
> whatever format (common clock framework + DT).

Thanks.  I'll split these up into smaller topic branches, I think
that's what Tony wants for this window.

Patches 1-3 and 12 have been queued for 3.1 at 
git://git.pwsan.com/linux-2.6 in the 'prcm_cleanup_a_3.1' branch.

Patches 4-8 and 11 have been queued for 3.1 at
git://git.pwsan.com/linux-2.6 in the 'clock_cleanup_a_3.1' branch.

Patches 9 and 10 have been split into PRCM changes and clock changes. The 
PRCM changes have been queued for 3.1 at git://git.pwsan.com/linux-2.6 in 
the 'prcm_cleanup_a_3.1' branch.  The clock changes have been queued for 
3.1 at git://git.pwsan.com/linux-2.6 in the 'clock_cleanup_a_3.1' branch.

Patches 13-15 have been queued for 3.1 at
git://git.pwsan.com/linux-2.6 in the 'hwmod_cleanup_a_3.1' branch.

Patches 17-18 have been queued for 3.1 at
git://git.pwsan.com/linux-2.6 in the 'hwmod_dss_fix_3.1' branch.

Patch 16, to me, belongs best with the 4460 support series and so I'll see 
if it makes sense to fit it in there somewhere.


- Paul
