From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 0/3]: Update OPP Table and Voltage Rail Values
Date: Tue, 01 Mar 2011 12:52:39 -0800
Message-ID: <87aahek1go.fsf@ti.com>
References: <1297836995-8747-1-git-send-email-shweta.gulati@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:53930 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757511Ab1CAUwn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Mar 2011 15:52:43 -0500
Received: by mail-iw0-f172.google.com with SMTP id 42so6648390iwl.17
        for <linux-omap@vger.kernel.org>; Tue, 01 Mar 2011 12:52:41 -0800 (PST)
In-Reply-To: <1297836995-8747-1-git-send-email-shweta.gulati@ti.com> (Shweta
	Gulati's message of "Wed, 16 Feb 2011 11:46:35 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shweta Gulati <shweta.gulati@ti.com>
Cc: linux-omap@vger.kernel.org

Shweta Gulati <shweta.gulati@ti.com> writes:

> The series mainly does below:
>
> OMAP4 only
>        - Update MPU VOltage rail values for all OPPs
>        - Enable OPP-Nitro and OPP-Turbo for all boards
> OMAP2PLUS
>        -Replace hardcoded Voltage values in OPP Table
>         with Voltage Macros.
>
> Baseline:
> git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git
> Branch: pm

What is the dependency on the PM branch?

> Tested on OMAP4430 SDP, OMAP3630 SDP and OMAP3430 SDP.

Tested in what way? 

This series looks OK to me, but would like to see an ack/reviewed-by
from Nishanth before merging.

Also, please Cc linux-arm-kernel on patches intended for mainline merge.

Kevin


> Shweta Gulati (2):
>   OMAP4: Revise MPU Voltage rail values.
>   OMAP4: Enable Turbo and Nitro OPP for OMAP4
>
> Vishwanath BS (1):
>   OMAP2+: Replace Voltage values with Macros.
>
>  arch/arm/mach-omap2/opp3xxx_data.c        |   47 +++++++++++++++--------------
>  arch/arm/mach-omap2/opp4xxx_data.c        |   13 ++++----
>  arch/arm/plat-omap/include/plat/voltage.h |    8 ++--
>  3 files changed, 35 insertions(+), 33 deletions(-)
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
