From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: Script for applying a set of patches from a folder
Date: Sat, 6 Jun 2009 00:52:55 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030591A59C@dbde02.ent.ti.com>
References: <A3273B39-7050-4382-BFE7-A1416B45DA55@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51777 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751478AbZFETXG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Jun 2009 15:23:06 -0400
In-Reply-To: <A3273B39-7050-4382-BFE7-A1416B45DA55@mac.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Elvis Dowson <elvis.dowson@mac.com>, Linux OMAP Users <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Elvis Dowson
> Sent: Friday, June 05, 2009 9:51 PM
> To: Linux OMAP Users
> Subject: Re: Script for applying a set of patches from a folder
> 
> Hi Kevin,
> 		  I'm using OpenEmbedded, so I have to extract the patches first,  
> then apply them and tweak the generated patches manually by hand.  
> Sometimes, I will end up with some patches that require me to create a  
> temporary workarea, apply all the patches that lead up to a particular  
> change, and then manually apply the offending patch, and then extract  
> a diff from that modification, and then re-insert it back to the  
> OpenEmbedded work area.
> 
> So I just needed this solution, to quickly fast forward to the point  
> that I want to apply the patch. I'll try it out.
> 

How about quilt?

<http://savannah.nongnu.org/projects/quilt>

- Anand

> Best regards,
> 
> Elvis
> 
> 
> 
> On Jun 5, 2009, at 6:38 PM, Kevin Hilman wrote:
> 
> >>
> >
> > Not sure exactly what you're trying to do here, but since the PM
> > branch probably makes up most of those patches, why do you need to
> > apply them?  Can't you just checkout the pm branch and add the other
> > patches on top?  e.g.
> >
> > Create a test branch for your work in progress which is 
> rooted at the
> > pm branch:
> >
> > $ git checkout -b wip/test pm
> >
> > Apply your other patches (dss2, etc.)
> >
> > $ git am <patches>
> >
> > Kevin
> 
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 