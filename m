From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH 1/2] AM35xx: Runtime detection of the device
Date: Thu, 29 Oct 2009 00:12:07 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DE16EA15@dbde02.ent.ti.com>
References: <1256652150-5710-1-git-send-email-premi@ti.com>
 <20091027161115.GA16494@nokia.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301DE0DCB84@dbde02.ent.ti.com>
 <20091027210853.GA17061@nokia.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301DE0DD1D0@dbde02.ent.ti.com>
 <20091028165918.GD8820@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39568 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751040AbZJ1SmV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Oct 2009 14:42:21 -0400
In-Reply-To: <20091028165918.GD8820@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>

 

> -----Original Message-----
> From: Felipe Balbi [mailto:felipe.balbi@nokia.com] 
> Sent: Wednesday, October 28, 2009 10:29 PM
> To: Premi, Sanjeev
> Cc: Balbi Felipe (Nokia-D/Helsinki); 
> linux-omap@vger.kernel.org; tony@atomide.com
> Subject: Re: [PATCH 1/2] AM35xx: Runtime detection of the device
> 
> Hi,
> 
> On Wed, Oct 28, 2009 at 01:40:04PM +0100, ext Premi, Sanjeev wrote:
> > >  	case 0xb891:
> > > -		/* Handle 36xx devices */
> > > -		switch (rev) {
> > > -		case 0:
> > > -			omap_revision = OMAP3630_REV_ES1_0;
> > > -			break;
> > > -		default:
> > > -			/* Use the latest known revision as default */
> > > -			omap_revision = OMAP3630_REV_ES1_0;
> > > -		}
> > > -		break;
> > > +	/* FALLTHROUGH */
> > >  	default:
> > >  		/* Unknown default to latest silicon rev as default*/
> > >  		omap_revision = OMAP3630_REV_ES1_0;
> > 
> > [sp] Haven't applied the patch. But, if FALLTHROUGH will 
> make the device
> >      detected as OMAP3630, then it may not be right. The 
> fall through
> >      should be on most common device. OMAP3430 ES21./3.1 
> should be ideal.
> > 
> >      Thoughts?
> 
> see that I didn't change the default clause. It was already
> OMAP3630_REV_ES1_0. If it has to be anything else, the 
> default should be
> changed and the case 0xb891: should do:

I did see that. But since you were already proposing a change
thought it would be good idea.

~sanjeev

> 
> case 0xb891:
> 	omap_revision = OMAP3630_REV_ES1_0;
> 	break;
> 
> -- 
> balbi
> 
> 