From: Joerg Roedel <Joerg.Roedel@amd.com>
Subject: Re: [PATCH] ARM: OMAP: make iommu subsys_initcall to fix builtin
 omap3isp
Date: Mon, 27 Feb 2012 13:02:57 +0100
Message-ID: <20120227120257.GB7905@amd.com>
References: <1330251254-14693-1-git-send-email-ohad@wizery.com>
 <3215700.hj2jFm3b0A@avalon>
 <CAK=WgbYkVALqrVMVv1ma3WzN5dYriM8X0MfwH4knwWwojB6hjg@mail.gmail.com>
 <35010303.ArkW8BdIu6@avalon>
 <CAK=WgbZRjGEyx0mKmgoWYiOnuvUAka0kTzpLAYbra94Mfpp6qg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from db3ehsobe006.messaging.microsoft.com ([213.199.154.144]:8781
	"EHLO DB3EHSOBE001.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753077Ab2B0MDH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 27 Feb 2012 07:03:07 -0500
Content-Disposition: inline
In-Reply-To: <CAK=WgbZRjGEyx0mKmgoWYiOnuvUAka0kTzpLAYbra94Mfpp6qg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org, Hiroshi Doyu <hdoyu@nvidia.com>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>

On Mon, Feb 27, 2012 at 09:00:51AM +0200, Ohad Ben-Cohen wrote:
> On Mon, Feb 27, 2012 at 12:47 AM, Laurent Pinchart
> > That's what the comment in the Makefile is for ;-) I don't think it's a
> > perfect solution either, but it avoids playing with the various initcalls. The
> > OMAP3 IOMMU isn't a subsystem, subsys_initcall() looks a bit like an API abuse
> > to me.
> 
> Yes, it's dirty.
> 
> But it's explicit and consistent across build system changes (without
> imposing anything on the build system). We do it all the time with
> other subsystems. We don't like it, but luckily Grant came up with the
> deferred probing mechanism, which will fix this all very nicely.

Agreed. It is not the best fix, but at least more reliable then the
Makefile change.


	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632

