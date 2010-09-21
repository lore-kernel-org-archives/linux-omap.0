From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH] OMAP: hwmod: softreset fixes with opt clocks
Date: Tue, 21 Sep 2010 19:03:43 +0200
Message-ID: <4C98E56F.3030202@ti.com>
References: <1285088279-425-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42453 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754985Ab0IURDq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Sep 2010 13:03:46 -0400
In-Reply-To: <1285088279-425-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Nayak, Rajendra" <rnayak@ti.com>, "Basak, Partha" <p-basak2@ti.com>

On 9/21/2010 6:57 PM, Cousson, Benoit wrote:
> Hi Paul,
>
> Here are some fixes for the softreset issues that were highlighted
> on some IPs like GPIO or DSS.
>
> For the moment they are still based on your previous series:
> git://git.pwsan.com/linux-2.6 hwmod_hardreset_dev
>
> If you are OK with these, I'll rebase that on top of your latest submission to l-o / linux-arm-kernel.
>
> Thanks,
> Benoit
>
>
> Benoit Cousson (2):
>    OMAP: hwmod: Fix softreset for modules with optional clocks
>    OMAP: hwmod: Fix softreset status check for some new OMAP4 IPs
>
>   arch/arm/mach-omap2/omap_hwmod.c             |   73 ++++++++++++++++++++++----
>   arch/arm/plat-omap/include/plat/omap_hwmod.h |    8 +++-
>   2 files changed, 70 insertions(+), 11 deletions(-)
>

Oops, I forgot... The patches are available here:

git://gitorious.org/omap-pm/linux.git pm-wip/hwmods-reset-fixes

Regards,
Benoit
