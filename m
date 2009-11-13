From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH] omap3: Change the default silicon
Date: Fri, 13 Nov 2009 16:23:00 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DE4C48C0@dbde02.ent.ti.com>
References: <1256826908-14703-1-git-send-email-premi@ti.com>
 <20091112222127.GF24837@atomide.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB030A8C864A@dbde02.ent.ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301DE4C486C@dbde02.ent.ti.com>
 <4AFD31D3.6060805@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50154 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753835AbZKMKxB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Nov 2009 05:53:01 -0500
In-Reply-To: <4AFD31D3.6060805@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: "Gadiyar, Anand" <gadiyar@ti.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Menon, Nishanth 
> Sent: Friday, November 13, 2009 3:46 PM
> To: Premi, Sanjeev
> Cc: Gadiyar, Anand; Tony Lindgren; linux-omap@vger.kernel.org
> Subject: Re: [PATCH] omap3: Change the default silicon
> 
> Premi, Sanjeev had written, on 11/13/2009 04:10 AM, the following:
> >> -----Original Message-----
> >> From: Gadiyar, Anand 
> >> Sent: Friday, November 13, 2009 10:41 AM
> >> To: Tony Lindgren; Premi, Sanjeev
> >> Cc: linux-omap@vger.kernel.org
> >> Subject: RE: [PATCH] omap3: Change the default silicon
> >>
> >> Tony Lindgren wrote:
> >>> * Sanjeev Premi <premi@ti.com> [091029 07:35]:
> >>>> Currently the default silicon - in absence of
> >>>> identification - is set to OMAP3630 ES1.0.
> >>>>
> >>>> Though, condition may/should not arise; but
> >>>> the default should be latest in the most
> >>>> common silicon variant - currently OMAP3430
> >>>> ES3.1.
> >>> Is this still needed? To me it seems more likely there will
> >>> more 3630 based silicon than 3430 based silicon?
> >>>
> >> 3430 ES3.1s are the most common I believe. All boards in the wild
> >> are 3430 based.
> >>
> >> 3630 is just coming up and will take a while to be as common.
> >>
> >> IMO, 3430 ES3.1 should be default.
> >>
> >> - Anand
> > 
> > [sp] That's exactly the reason for this patch.
> >      There is a small typo in the comment though :(
> > 
> > 		/* Unknown. Default to latest among all variants */
> > Should be:
> > 		/* Unknown. Default to common among all variants */
> > 
> >      Sending a v2 for the same.
> > 
> 
> I believe this patch should be dropped -> here is why -> if 
> you have new 
> silicons that are in 3430 category, you should be sending patches for 
> them ;)..

Default != new si

> 
> The latest and greatest in the bucket of silicons is 3630 and I would 
> rather go with felipe's patch [1] cleaning up the id.c than 

No issues with felipe's patch. It is cleaning the code style.

> this -> in 
> my opinion, hitting this condition is only because you have the next 
> generation of devices..

Since we are talking OMAP3 derivatives, the default should be the
base - in case the condition ever arises. The fall back should
usually be 'most common' than 'latest'.

~sanjeev
> 
> 
> -- 
> Regards,
> Nishanth Menon
> 
> Ref:
> [1]: http://patchwork.kernel.org/patch/59540/
> 