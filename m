From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCHv3 0/2] OMAP3: PM: OMAP3630 support for smartreflex driver
Date: Tue, 20 Apr 2010 16:50:17 -0700
Message-ID: <87wrw1adl2.fsf@deeprootsystems.com>
References: <1271413196-6087-1-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:38475 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752638Ab0DTXuU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Apr 2010 19:50:20 -0400
Received: by pvg13 with SMTP id 13so411295pvg.19
        for <linux-omap@vger.kernel.org>; Tue, 20 Apr 2010 16:50:20 -0700 (PDT)
In-Reply-To: <1271413196-6087-1-git-send-email-thara@ti.com> (Thara Gopinath's message of "Fri\, 16 Apr 2010 15\:49\:54 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com

Thara Gopinath <thara@ti.com> writes:

> This patch series adds support for the updated 45nm smrtrelfex IP
> supported in OMAP3630 and OMAP4 in the smartreflex driver and
> adds support to enable smartreflex autocompensation for OMAP3630
> using test nvalues.
>
> This patch series is based on the V3 version of Smartreflex and
> voltage revamp  patch series.
>
> This patch series has been tested on OMAP3630 SDP board with
> CONFIG_OMAP_SMARTREFLEX_TESTING option enabled in the menuconfig.
>
> This patch series has been based on Kevin's PM tree
> origin/pm-wip-opp branch.

Will get to reviewing this later this week, but in the mean time, added
this series to pm-wip-sr branch.

Kevin
