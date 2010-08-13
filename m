From: "Que, Simon" <sque@ti.com>
Subject: RE: [PATCH 2/4 v2] omap: hwspinlock: Add HWSPINLOCK base address
 information in omap44xx.h
Date: Fri, 13 Aug 2010 10:23:06 -0500
Message-ID: <F39349C6FA641B4A831B7BF4EBF4D4E148156ED6@dlee03.ent.ti.com>
References: <F39349C6FA641B4A831B7BF4EBF4D4E1480D9E47@dlee03.ent.ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301E8147031@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40552 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934427Ab0HMPXI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Aug 2010 11:23:08 -0400
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301E8147031@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>, Linux Omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>


> > +#define OMAP44XX_SPINLOCK_BASE         (L4_44XX_BASE + 0xF6000)
> > +
> 
> [sp] Can this be simply OMAP4_SPINLOCK_BASE equiv to OMAP4_MMUx_BASE
>      defined just above. OR is this address specific to OMAP44xx only?
>      (I haven't checked what is the the convention followed in rest of
>      the file)

[SQ] Yes, I'll change it to "OMAP4_"

Thanks,
Simon
