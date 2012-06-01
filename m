From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 0/3] ARM: OMAP3: PM: optimize cpuidle C1 state latency
Date: Fri, 01 Jun 2012 09:26:05 -0700
Message-ID: <87ipfbt2w2.fsf@ti.com>
References: <1338563468-31403-1-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog132.obsmtp.com ([74.125.149.250]:42902 "EHLO
	na3sys009aog132.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759046Ab2FAQ0G (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Jun 2012 12:26:06 -0400
Received: by pbbro12 with SMTP id ro12so3372035pbb.32
        for <linux-omap@vger.kernel.org>; Fri, 01 Jun 2012 09:26:04 -0700 (PDT)
In-Reply-To: <1338563468-31403-1-git-send-email-j-pihet@ti.com> (Jean Pihet's
	message of "Fri, 1 Jun 2012 17:11:05 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Grazvydas Ignotas <notasas@gmail.com>, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>

Hi Jean,

Jean Pihet <jean.pihet@newoldbits.com> writes:

> The C1 state latency can be improved by optimizing the cpuidle low
> level code.
>
> The first patch is a precaution fix for patch 2.
> Patches 2 & 3 are optimization changes.
>
> Rebased on top of the for_3.6/pm/performance branch of
> khilman's tree [1].
>
> Tested on Beagleboard using a DMA-enabled copy from NAND flash
> to /dev/null.

Thanks for following this through.

Adding this series to my for_3.6/pm/performance branch.

Also FYI, combining your series with the various fixes for CORE
retention, I'm seeing CORE hit retention in idle just fine on 3430/n900
and 3530/Overo.

Thanks!

Kevin
