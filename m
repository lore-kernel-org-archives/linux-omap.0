From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH 1/1] ARM: OMAP4: PM: Add check for avoiding dependency
 related update.
Date: Wed, 6 Jan 2010 14:09:58 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1001061401560.10034@utopia.booyaka.com>
References: <1261583238-22187-1-git-send-email-abhijitpagare@ti.com> <alpine.DEB.2.00.0912300125320.24862@utopia.booyaka.com> <EAF47CD23C76F840A9E7FCE10091EFAB02C02E919C@dbde02.ent.ti.com> <alpine.DEB.2.00.1001051608340.21295@utopia.booyaka.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C041BB3A@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:43623 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932276Ab0AFVJ7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Jan 2010 16:09:59 -0500
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C041BB3A@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pagare, Abhijit" <abhijitpagare@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hello Abhijit,

On Wed, 6 Jan 2010, Pagare, Abhijit wrote:

> I checked the dependency patch-set. The complete stuff looks really 
> neat. Applying OMAP4 on top of this would be feasible. The only thing is 
> that till the point the OMAP4 dependency patches go in the "autodeps" 
> variable in arch/arm/clockdomain.c would not be initialized which will 
> cause a kernel boot-crash for the functions _clkdm_add_autodeps(clkdm) 
> and _clkdm_del_autodeps(clkdm). Hence the hack patch referred to in the 
> subject above is essential. Should I re-post it with the missing FIXME 
> indication that you had recommended?

My concern is that we don't want to forget about the OMAP4 sleep and 
wakeup dependencies.  How long do you think it will take to add them?


- Paul
