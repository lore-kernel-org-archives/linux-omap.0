From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: pm_debug/voltage_off_while_idle has gone?
Date: Wed, 23 Jun 2010 11:04:57 -0700
Message-ID: <87d3vhwrp2.fsf@deeprootsystems.com>
References: <4C21FCF1.20600@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:64319 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751804Ab0FWSFA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Jun 2010 14:05:00 -0400
Received: by pxi7 with SMTP id 7so384345pxi.19
        for <linux-omap@vger.kernel.org>; Wed, 23 Jun 2010 11:04:59 -0700 (PDT)
In-Reply-To: <4C21FCF1.20600@compulab.co.il> (Mike Rapoport's message of "Wed,
	23 Jun 2010 15:24:17 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Rapoport <mike@compulab.co.il>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Mike Rapoport <mike@compulab.co.il> writes:

> There used to be 'voltage_off_while_idle' attribute in the PM-enabled
> kernels that allowed to put PMIC into OFF mode.  In the current tip of
> the linux-omap-pm tree this attribute seem to be gone Is there
> possibility to make PMIC enter the OFF mode when suspending to RAM?

Hi Mike,

We are currently in the middle of a major rewrite of the SmartReflex and
voltage layers of the PM branch.

The previous voltage-related work (like voltage_off_while_idle) are
still available in the pm-vc branch of my tree, but are not currently
merged with the new voltage work due to conflicts.

For this particular feature, I suspect you could just apply the first
patch in my pm-vc branch to add back this feature.

Let me know if that works,

Kevin
