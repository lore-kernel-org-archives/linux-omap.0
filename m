From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH 0/3] Add support for OMAP35x processors
Date: Fri, 9 Jan 2009 22:29:21 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301BB858A3B@dbde02.ent.ti.com>
References: <1231513323-27379-1-git-send-email-premi@ti.com>
 <A24693684029E5489D1D202277BE8944163AB5F7@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43498 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751044AbZAIQ7b convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Jan 2009 11:59:31 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n09GxO1g020595
	for <linux-omap@vger.kernel.org>; Fri, 9 Jan 2009 10:59:30 -0600
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n09GxN05015088
	for <linux-omap@vger.kernel.org>; Fri, 9 Jan 2009 22:29:24 +0530 (IST)
In-Reply-To: <A24693684029E5489D1D202277BE8944163AB5F7@dlee02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

<snip>

> > +config ARCH_OMAP35XX
> > +	bool "OMAP35x Family"
> > +	select ARCH_OMAP3
> > +	select ARCH_OMAP34XX
> > +	select ARCH_OMAP3430
> > +	select OMAP3430_ES2
> 
> AFAIK the above select (OMAP3430_ES2) doesn't exist. 
> omap_rev() is used in drivers to check instead.

[sp] Wasn't aware; will remove it.

> Question to all,
> 
> Why don't making above options as choice.. endchoice. Or is 
> there any case that multiple boards are compiled at once?

[sp] It is a quick change; will wait for a day - just in case there is a different opinion.

> Regards,
> Sergio
> 

Best regards,
Sanjeev