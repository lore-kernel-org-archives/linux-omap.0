From: "Que, Simon" <sque@ti.com>
Subject: RE: [PATCH 1/4 v2] omap: hwspinlock: uncomment the hwmod part for
 hwspinlock
Date: Fri, 13 Aug 2010 10:22:18 -0500
Message-ID: <F39349C6FA641B4A831B7BF4EBF4D4E148156ED2@dlee03.ent.ti.com>
References: <F39349C6FA641B4A831B7BF4EBF4D4E1480D9E46@dlee03.ent.ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301E814705E@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40506 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934402Ab0HMPWW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Aug 2010 11:22:22 -0400
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301E814705E@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>, Linux Omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>

> > arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >
> [sp] I did not see this file in any of the "master",
>      "for-next" or "pm" branches.

[SQ] This will go into Santosh's omap4_next branch for upstreaming.  That branch contains the file.

Thanks,
Simon
