From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH] omap3: Change the default silicon
Date: Fri, 13 Nov 2009 15:40:56 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DE4C486C@dbde02.ent.ti.com>
References: <1256826908-14703-1-git-send-email-premi@ti.com>
 <20091112222127.GF24837@atomide.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB030A8C864A@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44616 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755606AbZKMKK4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Nov 2009 05:10:56 -0500
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB030A8C864A@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Gadiyar, Anand 
> Sent: Friday, November 13, 2009 10:41 AM
> To: Tony Lindgren; Premi, Sanjeev
> Cc: linux-omap@vger.kernel.org
> Subject: RE: [PATCH] omap3: Change the default silicon
> 
> Tony Lindgren wrote:
> > * Sanjeev Premi <premi@ti.com> [091029 07:35]:
> > > Currently the default silicon - in absence of
> > > identification - is set to OMAP3630 ES1.0.
> > > 
> > > Though, condition may/should not arise; but
> > > the default should be latest in the most
> > > common silicon variant - currently OMAP3430
> > > ES3.1.
> > 
> > Is this still needed? To me it seems more likely there will
> > more 3630 based silicon than 3430 based silicon?
> > 
> 
> 3430 ES3.1s are the most common I believe. All boards in the wild
> are 3430 based.
> 
> 3630 is just coming up and will take a while to be as common.
> 
> IMO, 3430 ES3.1 should be default.
> 
> - Anand

[sp] That's exactly the reason for this patch.
     There is a small typo in the comment though :(

		/* Unknown. Default to latest among all variants */
Should be:
		/* Unknown. Default to common among all variants */

     Sending a v2 for the same.

~sanjeev

> 
> 
> > Regards,
> > 
> > Tony
> >  
> > > Signed-off-by: Sanjeev Premi <premi@ti.com>
> > > ---
> > >  arch/arm/mach-omap2/id.c |    4 ++--
> > >  1 files changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
> > > index 1c15112..0162623 100644
> > > --- a/arch/arm/mach-omap2/id.c
> > > +++ b/arch/arm/mach-omap2/id.c
> > > @@ -243,8 +243,8 @@ void __init omap3_check_revision(void)
> > >  		}
> > >  		break;
> > >  	default:
> > > -		/* Unknown default to latest silicon rev as default*/
> > > -		omap_revision = OMAP3630_REV_ES1_0;
> > > +		/* Unknown. Default to latest among all variants */
> > > +		omap_revision = OMAP3430_REV_ES3_1;
> > >  	}
> > >  }
> > >  
> 