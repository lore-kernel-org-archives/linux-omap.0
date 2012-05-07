From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 1/2 v4] ARM: OMAP2+: omap_hwmod: Add api to enable/disable module level wakeup events
Date: Mon, 07 May 2012 11:12:23 -0700
Message-ID: <874nrr508o.fsf@ti.com>
References: <1335276552-24340-1-git-send-email-govindraj.raja@ti.com>
	<1335338237-4095-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:56938 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755028Ab2EGSMP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 May 2012 14:12:15 -0400
Received: by pbbrr13 with SMTP id rr13so8680566pbb.40
        for <linux-omap@vger.kernel.org>; Mon, 07 May 2012 11:12:13 -0700 (PDT)
In-Reply-To: <1335338237-4095-1-git-send-email-govindraj.raja@ti.com>
	(Govindraj R.'s message of "Wed, 25 Apr 2012 12:47:17 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tero Kristo <t-kristo@ti.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

"Govindraj.R" <govindraj.raja@ti.com> writes:

> From: "Govindraj.R" <govindraj.raja@ti.com>
>
> On 24xx/34xx/36xx Module level wakeup events are enabled/disabled using
> PM_WKEN1_CORE/PM_WKEN_PER regs.
>
> Add api to control the module level wakeup mechanism from info provided from
> hwmod data.

Can you rework this slightly on top of the new SoC detection support
recently added to hwmod[1].   That series adds support for init-time, SoC
specific function pointers for this kind of SoC specific feature.

Kevin

[1] git://git.pwsan.com/linux-2.6 hwmod_soc_conditional_cleanup_3.5
