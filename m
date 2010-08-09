From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v3 0/7] OMAP: hwmod: Full data set for OMAP4430 ES1 & ES2
Date: Mon, 09 Aug 2010 12:11:53 -0700
Message-ID: <878w4fk3d2.fsf@deeprootsystems.com>
References: <1281023276-15679-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:36410 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752547Ab0HITLz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Aug 2010 15:11:55 -0400
Received: by pzk26 with SMTP id 26so3778216pzk.19
        for <linux-omap@vger.kernel.org>; Mon, 09 Aug 2010 12:11:55 -0700 (PDT)
In-Reply-To: <1281023276-15679-1-git-send-email-b-cousson@ti.com> (Benoit
	Cousson's message of "Thu, 5 Aug 2010 17:47:49 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, rnayak@ti.com, santosh.shilimkar@ti.com

Benoit Cousson <b-cousson@ti.com> writes:

> Hi Kevin & Paul,
>
> Here is the OMAP4430 ES1 & ES2 hwmod data v3 series.
>
> Please note that there is no difference between the ES1 & ES2 wrt hwmod.
>
> This series is re-organised in order to allow initial submission for upstream
> with minimal interconnect data set + mpu.
>
> Further data will be sent along with the driver once adapted to hwmod.
> A first patch is done for the TIMER IP as an example.
>
> Patches are based on lo/for-next + for-next-fixes + pm-wip/hwmods-reset
> + pm-wip/hwmods-debugfs and are available here:
> git://dev.omapzoom.org/pub/scm/swarch/linux-omap-adv.git pm-wip/hwmods-omap4
>
> Tested on OMAP4430 ES1.0 GP device using PAB board.

This is looking good to me.  Of course, as you noted we need to
understand the root cause of need for those temporary patches before
merging.

To facilitate broader testing with the other hwmod conversions in
progress, and to test with runtime PM, I've updated my
pm-wip/hwmods-omap4 branch now includes your series (and its
dependencies.)

IOW, my pm-wip/hwmods-omap4 branch is just a merge of my pm-wip/runtime
branch and your pm-wip/hwmods-omap4 branch.

Kevin
