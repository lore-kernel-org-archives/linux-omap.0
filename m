From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [ANNOUNCE] new PM branch, rebased to current master
Date: Thu, 17 Dec 2009 16:31:32 -0800
Message-ID: <8763852kd7.fsf@deeprootsystems.com>
References: <873a3abt4j.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f182.google.com ([209.85.211.182]:35604 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750860AbZLRAbi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Dec 2009 19:31:38 -0500
Received: by ywh12 with SMTP id 12so2901141ywh.21
        for <linux-omap@vger.kernel.org>; Thu, 17 Dec 2009 16:31:38 -0800 (PST)
In-Reply-To: <873a3abt4j.fsf@deeprootsystems.com> (Kevin Hilman's message of "Wed\, 16 Dec 2009 11\:45\:16 -0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

FYI...

I pushed an updated PM branch today, updated to latest omap/master.
Note that this time it was not a rebase, so should remain pull-able.

Important changes:

- dropped /sys/power/vdd* (as I've been saying I would for a while)
  From now on, use CPUfreq interface for controlling OPPs.

For the curious, you'll also notice many pm-* branches on my
linux-omap-pm repo now[1].

I've done a bunch of re-organizing/regrouping of patches into
groups/branches so they can be combined/collected/cleaned-up together
in order to reach mainline.

Here's a brief summary of the branches that are currently included in
the PM branch:

Ones that are almost ready for upstream:

pm-fixes: fixes to queue for 2.6.33-rc series
pm-t2: T2 script updates for 3430SDP 
pm-drivers: PM driver changes
pm-debug: Misc. PM debug 

Branches that need minor help before going upstream:
pm-gpio: GPIO off-mode support
pm-debobs: Debug observability support

Branches that need major help before going upstream:

pm-vc: collection of VC patches
pm-sr: collection of SR patches
pm-srf: collection of SRF patches
pm-remainder: leftovers that are dependent on VC/SR/SRF
pm-cpufreq: CPUfreq driver

There is also a work-in-progress branch for an updated OPP layer from
Nishanth named pm-wip-opp which is rebased to the current PM branch.
This will soon be merged into the PM branch, but I have a little
more-reorganizing to do first, this won't likely happen until early
Jan. since...

also, I'll be taking most of the next two weeks off, so expect slow
responses from me...

Kevin

[1] http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-pm.git
