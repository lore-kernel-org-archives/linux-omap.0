From: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>
Subject: RE: [PATCH 8/9] dspbridge: add map support for big buffers
Date: Tue, 24 Aug 2010 11:31:30 -0500
Message-ID: <496565EC904933469F292DDA3F1663E602F0FA3883@dlee06.ent.ti.com>
References: <1277943660-4112-1-git-send-email-x0095840@ti.com>
	<1277943660-4112-2-git-send-email-x0095840@ti.com>
	<1277943660-4112-3-git-send-email-x0095840@ti.com>
	<1277943660-4112-4-git-send-email-x0095840@ti.com>
	<1277943660-4112-5-git-send-email-x0095840@ti.com>
	<1277943660-4112-6-git-send-email-x0095840@ti.com>
	<1277943660-4112-7-git-send-email-x0095840@ti.com>
	<1277943660-4112-8-git-send-email-x0095840@ti.com>
	<1277943660-4112-9-git-send-email-x0095840@ti.com>
	<8F7AF80515AF0D4D93307E594F3CB40E4CAD34D5@dlee03.ent.ti.com>
	<496565EC904933469F292DDA3F1663E602CBDD3ADE@dlee06.ent.ti.com>
	<8F7AF80515AF0D4D93307E594F3CB40E4CAD39F6@dlee03.ent.ti.com>
	<496565EC904933469F292DDA3F1663E602CBDD3BB2@dlee06.ent.ti.com>
 <AANLkTimENxUjUWJQSZ1dmdkX_9hQ0pjat-kyR9oNjVxf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45153 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754343Ab0HXQbg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Aug 2010 12:31:36 -0400
In-Reply-To: <AANLkTimENxUjUWJQSZ1dmdkX_9hQ0pjat-kyR9oNjVxf@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: "Kanigeri, Hari" <h-kanigeri2@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "ohad@wizery.com" <ohad@wizery.com>, "hiroshi.doyu@nokia.com" <hiroshi.doyu@nokia.com>, "ameya.palande@nokia.com" <ameya.palande@nokia.com>, "felipe.contreras@nokia.com" <felipe.contreras@nokia.com>

 

> -----Original Message-----
> From: Felipe Contreras [mailto:felipe.contreras@gmail.com] 
> Sent: Tuesday, August 24, 2010 5:09 AM
> To: Guzman Lugo, Fernando
> Cc: Kanigeri, Hari; linux-omap@vger.kernel.org; 
> linux-kernel@vger.kernel.org; ohad@wizery.com; 
> hiroshi.doyu@nokia.com; ameya.palande@nokia.com; 
> felipe.contreras@nokia.com
> Subject: Re: [PATCH 8/9] dspbridge: add map support for big buffers
> 
> On Fri, Jul 2, 2010 at 9:39 PM, Guzman Lugo, Fernando 
> <fernando.lugo@ti.com> wrote:
> > I think, it would be good if we get rid of DMMPOOL size, if 
> the liked list grow up as it is needed, there is no memory 
> penalty of have all the possible iommu addresses valid 
> (11000000 - FFFFFFFF). The reservation will only fail when 
> there is no memory. If a software restriction is needed we 
> could define a start and end addresses for iommu module 
> (maybe as a parameter when the iommu handle for iva2 is got) 
> and that boundaries can be taking in account at the moment of 
> reserve the memory.
> 
> What happened to this?
> 
> IIUC what you are proposing is to remove the DMM pool 
> completely, that makes sense to me. However, is it really 
> needed to finish the iommu migration to do this?
> 
> > I think the reserve/unreserved dspbridge api can disappear 
> and just return the da address in the map function.
> 
> This is something I've proposed before, so I agree :)

Yeah, that is how it will be. I have been busy with other stuffs, but now
I have finish a version with all dmm module removed and reserve/unreserve
Api removed as well. But because a the big # of patches merge in dspbrdge
I have to rebase them to the latest, I hope finish this week and send
Them again next week.

Regards,
Fernando.

> 
> --
> Felipe Contreras
> 