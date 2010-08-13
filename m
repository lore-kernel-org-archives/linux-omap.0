From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 1/4 v2] omap: hwspinlock: uncomment the hwmod part for
 hwspinlock
Date: Fri, 13 Aug 2010 23:04:41 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C667AD68@dbde02.ent.ti.com>
References: <F39349C6FA641B4A831B7BF4EBF4D4E1480D9E46@dlee03.ent.ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301E814705E@dbde02.ent.ti.com>
 <F39349C6FA641B4A831B7BF4EBF4D4E148156ED2@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48086 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755437Ab0HMRet convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Aug 2010 13:34:49 -0400
In-Reply-To: <F39349C6FA641B4A831B7BF4EBF4D4E148156ED2@dlee03.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Que, Simon" <sque@ti.com>, "Premi, Sanjeev" <premi@ti.com>, Linux Omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>

Simon
> -----Original Message-----
> From: Que, Simon
> Sent: Friday, August 13, 2010 8:52 PM
> To: Premi, Sanjeev; Linux Omap; Tony Lindgren
> Cc: Cousson, Benoit; Shilimkar, Santosh; Kanigeri, Hari
> Subject: RE: [PATCH 1/4 v2] omap: hwspinlock: uncomment the hwmod part for
> hwspinlock
> 
> > > arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    2 +-
> > >  1 files changed, 1 insertions(+), 1 deletions(-)
> > >
> > [sp] I did not see this file in any of the "master",
> >      "for-next" or "pm" branches.
> 
> [SQ] This will go into Santosh's omap4_next branch for upstreaming.  That
> branch contains the file.
> 
There is a slight change in the way OMAP4 hwmod database will be merged.
Every driver need to add it's respective databse as part of the series.

Please find more info on the below thread.

http://www.spinics.net/lists/linux-omap/msg34700.html


