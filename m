From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 08/15] tidspbridge: Fix VM_PFNMAP mapping
Date: Fri, 21 Sep 2012 20:37:40 +0200
Message-ID: <CAMP44s2TTTotajCVE5WRwZPGQmFjzJNhuHBhJwMc45ttuDn6yQ@mail.gmail.com>
References: <1348056423-25573-1-git-send-email-laurent.pinchart@ideasonboard.com>
	<1348056423-25573-9-git-send-email-laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:42690 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757369Ab2IUShl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Sep 2012 14:37:41 -0400
Received: by obbuo13 with SMTP id uo13so2892390obb.19
        for <linux-omap@vger.kernel.org>; Fri, 21 Sep 2012 11:37:41 -0700 (PDT)
In-Reply-To: <1348056423-25573-9-git-send-email-laurent.pinchart@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-omap@vger.kernel.org, Omar Ramirez Luna <omar.ramirez@ti.com>

On Wed, Sep 19, 2012 at 2:06 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> VMAs marked with the VM_PFNMAP flag have no struct page associated with
> the memory PFNs. Don't call get_page()/put_page() on the pages
> supposedly associated with the PFNs.

I don't see anything wrong with the patch, but I think there's a lot
of changes, and perhaps a bit more of explanation of how it's doing
this might help. Also, it seems to be reordering
match_exact_map_obj(), which messes up the diff a bit.

Cheers.

-- 
Felipe Contreras
