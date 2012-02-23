From: Joerg Roedel <Joerg.Roedel@amd.com>
Subject: Re: [PATCH v2 2/2] iommu/omap: fix NULL pointer dereference
Date: Thu, 23 Feb 2012 17:37:52 +0100
Message-ID: <20120223163752.GD2454@amd.com>
References: <1329902086-13868-1-git-send-email-ohad@wizery.com>
 <20120223161109.GB2454@amd.com>
 <CAK=WgbYufgQY-O_MBcXc3aE23sx+r5ZQLS4h_bLUh6DKpLVqAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from db3ehsobe002.messaging.microsoft.com ([213.199.154.140]:45589
	"EHLO DB3EHSOBE006.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751851Ab2BWQiF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Feb 2012 11:38:05 -0500
Content-Disposition: inline
In-Reply-To: <CAK=WgbYufgQY-O_MBcXc3aE23sx+r5ZQLS4h_bLUh6DKpLVqAg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: iommu@lists.linux-foundation.org, linux-omap@vger.kernel.org, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Hiroshi Doyu <hdoyu@nvidia.com>

On Thu, Feb 23, 2012 at 06:16:59PM +0200, Ohad Ben-Cohen wrote:
> On Thu, Feb 23, 2012 at 6:11 PM, Joerg Roedel <Joerg.Roedel@amd.com> wrote:
> > I guess these patches are 3.3 material?
> 
> Yes.
> 
> > How about tagging them for stable too?
> 
> Good point. But it's only relevant for this 2nd patch (the NULL
> pointer dereference fix), as the first one is a 3.3 regression. Let me
> know if you want me to resend the 2nd one with the stable tag.

Not necessary. I'll add it when I apply the patch.

Thanks,

	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632

