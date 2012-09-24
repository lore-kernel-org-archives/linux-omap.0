From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v2 08/15] tidspbridge: Fix VM_PFNMAP mapping
Date: Tue, 25 Sep 2012 01:11:15 +0200
Message-ID: <2509239.EghAKueIs0@avalon>
References: <1348056423-25573-1-git-send-email-laurent.pinchart@ideasonboard.com> <1348056423-25573-9-git-send-email-laurent.pinchart@ideasonboard.com> <CAMP44s2TTTotajCVE5WRwZPGQmFjzJNhuHBhJwMc45ttuDn6yQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:49766 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750930Ab2IXXKk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Sep 2012 19:10:40 -0400
In-Reply-To: <CAMP44s2TTTotajCVE5WRwZPGQmFjzJNhuHBhJwMc45ttuDn6yQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: linux-omap@vger.kernel.org, Omar Ramirez Luna <omar.ramirez@ti.com>

Hi Felipe,

On Friday 21 September 2012 20:37:40 Felipe Contreras wrote:
> On Wed, Sep 19, 2012 at 2:06 PM, Laurent Pinchart wrote:
> > VMAs marked with the VM_PFNMAP flag have no struct page associated with
> > the memory PFNs. Don't call get_page()/put_page() on the pages
> > supposedly associated with the PFNs.
> 
> I don't see anything wrong with the patch, but I think there's a lot
> of changes, and perhaps a bit more of explanation of how it's doing
> this might help.

I'll make the commit message more explicit.

> Also, it seems to be reordering match_exact_map_obj(), which messes up the
> diff a bit.

That's because match_exact_map_obj() logically belonged to 
remove_mapping_information(), but now belongs to find_dsp_mapping(). I've 
split the commit in two, I'll send the result in reply to this e-mail. Please 
let me know if you like that better.

-- 
Regards,

Laurent Pinchart

