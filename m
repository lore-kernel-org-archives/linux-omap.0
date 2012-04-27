From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH-V4 4/4] ARM: OMAP3+: am33xx: Add powerdomain & PRM support
Date: Fri, 27 Apr 2012 13:44:02 -0700
Message-ID: <87lilg52i5.fsf@ti.com>
References: <1333123435-27186-1-git-send-email-hvaibhav@ti.com>
	<1333123435-27186-5-git-send-email-hvaibhav@ti.com>
	<87bome579d.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog131.obsmtp.com ([74.125.149.247]:38880 "EHLO
	na3sys009aog131.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760645Ab2D0UoD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 Apr 2012 16:44:03 -0400
Received: by pbcuo15 with SMTP id uo15so1698349pbc.11
        for <linux-omap@vger.kernel.org>; Fri, 27 Apr 2012 13:44:01 -0700 (PDT)
In-Reply-To: <87bome579d.fsf@ti.com> (Kevin Hilman's message of "Thu, 26 Apr
	2012 17:49:02 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, tony@atomide.com, rnayak@ti.com, Afzal Mohammed <afzal@ti.com>, linux-arm-kernel@lists.infradead.org

Kevin Hilman <khilman@ti.com> writes:

[...]

> I also don't like all the cpu_is* checking currently in omap_hwmod.c
> (which is here before you added this) and have an idea on how to clean
> it up, I should have a patch by tomorrow for this.  That should help
> adding am33xx support here without needing all the cpu_is* checking.

Series just posted: 

   http://marc.info/?l=linux-omap&m=133555727831379&w=2

Kevin
