From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 0/5] omap:hwspinlock support-omap4
Date: Sat, 24 Jul 2010 21:05:50 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C6255393@dbde02.ent.ti.com>
References: <1279558221-14954-1-git-send-email-h-kanigeri2@ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C6128817@dbde02.ent.ti.com>
 <8F7AF80515AF0D4D93307E594F3CB40E4D00F3A7@dlee03.ent.ti.com>
 <4C4B0119.5020701@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37147 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753739Ab0GXPf6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 24 Jul 2010 11:35:58 -0400
In-Reply-To: <4C4B0119.5020701@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>
Cc: Linux Omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, "Que, Simon" <sque@ti.com>

> -----Original Message-----
> From: Cousson, Benoit
> Sent: Saturday, July 24, 2010 8:35 PM
> To: Kanigeri, Hari
> Cc: Shilimkar, Santosh; Linux Omap; Tony Lindgren; Que, Simon
> Subject: Re: [PATCH 0/5] omap:hwspinlock support-omap4
> 
> Hi Santosh,
> 
> On 7/20/2010 4:12 PM, Kanigeri, Hari wrote:
> > Santosh,
> >
> >
> >>>
> >>> Hari Kanigeri (1):
> >>>    omap:hwspinlocks-ensure the order of registration
> >>>
> >>> Simon Que (4):
> >>>    omap:hwmod-hwspinlock-enable
> >>>    omap:hwspinlock-define HWSPINLOCK base address
> >> I think you should fold patch 1/5 , 2/5 into patch 3/5.
> >> At least patch 2/5 o.w git-bisect will break
> >
> > Can you please explain why this would break ?
> 
> Yep, I'm confused as well...
> 
> In fact 3 & 4 should be merged. In patch 3 we introduce 2 news files
> that will not be compiled until the next patch. We'd better modify the
> makefile in the same patch. For the build point of view, the patch  3
> will be a noop.
> 
I see your point now. So bisect should be ok but I agree with Benoit suggestion.

Additionally, the base address patch can be avoided because
this information can be retrieved from platform data.
	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
	"res->start" is base address
Regards,
Santosh
