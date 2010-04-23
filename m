From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: new PM branch: OPP layer included
Date: Fri, 23 Apr 2010 16:23:59 -0700
Message-ID: <87hbn1u50w.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:46072 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753928Ab0DWXYE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Apr 2010 19:24:04 -0400
Received: by pvc7 with SMTP id 7so394670pvc.19
        for <linux-omap@vger.kernel.org>; Fri, 23 Apr 2010 16:24:02 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello,

I just pushed a new PM branch.  I did a bunch of reordering and
restructuring of branches to include the OPP layer (more on this
below.)


OPP layer: 

pm-wip-opp branch gone, merged into PM branch

What was in pm-wip-opp has now been broken up into a set of patches
that can be combined and queued for upstream (pm-opp branch) as well
as sets of patches for SR and SRF which are now on their respective
branches (pm-sr, pm-srf)

Next step is to combine the patches in pm-opp branch into a sensible
series that can be submitted for the next merge window.


Smart Reflex:

Thara's v3 series available as pm-wip-sr.  This is now based directly
on the new PM branch instead of on pm-wip-opp.

NOTE: the hwmod patches are now merged into l-o (omap-fixes branch)
      so they are no longer in pm-wip-sr.

I didn't get to reviewing this series yet, but did test it out a bit
on top of thenew PM branch.  I gave this some basic testing on n900
and Zoom3 (required a u-boot update first) but basic OPP changes from
userspace governor worked on both.

  
SRF:

This is still included in the PM branch (pm-srf branch), but will be
removed from the official PM branch.  It will be maintained as a
separate branch for a short time (1 month max) and then dropped.
Anyone else who wants to continue maintenance of SRF is free to do so.


Kevin
