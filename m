From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: Update DSS2 patches for latest kernel changes
Date: Tue, 3 Nov 2009 14:32:16 +0530
Message-ID: <19F8576C6E063C45BE387C64729E73940436EEB86B@dbde02.ent.ti.com>
References: <19F8576C6E063C45BE387C64729E73940436EEB692@dbde02.ent.ti.com>
 <1257238471.13331.2.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36033 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755657AbZKCJCU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Nov 2009 04:02:20 -0500
In-Reply-To: <1257238471.13331.2.camel@tubuntu.research.nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Tomi Valkeinen [mailto:tomi.valkeinen@nokia.com]
> Sent: Tuesday, November 03, 2009 2:25 PM
> To: Hiremath, Vaibhav
> Cc: linux-omap@vger.kernel.org
> Subject: Re: Update DSS2 patches for latest kernel changes
> 
> Hi,
> 
> On Mon, 2009-11-02 at 16:02 +0100, ext Hiremath, Vaibhav wrote:
> > Hi Tomi,
> >
> > (Tomi, Sorry for resending it again, somehow last mail did not
> reach to list, so sending it again by removing patches attached.)
> >
> > DSS2 patches needs to be updated against the latest kernel
> changes, especially after commit "omap: headers: Move remaining
> headers from include/mach to include/plat"
> >
> > Since this patch has already merged to "for-next", I have done
> required modification to your commits (for both master and pm
> branch), keeping rest of the stuff as is.
> > I could able to validate it only on OMAP3EVM (since I don't have
> other EVMs) with DPI/Venc interface.
> >
> > If you could validate rest of the interfaces then we can update
> the DSS2 branch with latest kernel.
> >
> > You can access the patches from the repository -
> >
> > http://arago-project.org/git/people/?p=vaibhav/ti-psp-omap-
> video.git;a=shortlog;h=refs/heads/ti_display
> 
> Thanks, although I have already done that =). 
[Hiremath, Vaibhav] I cross-checked your repository and could not find anything there, so I started rebasing it myself.

Anyway, please let me know once you are done with it.

Thanks,
Vaibhav

> I'm in the process of
> integrating new patches (mostly VRFB and DSI fixes) to the DSS patch
> set. When I'm done I'll post them.
> 
>  Tomi
> 
> 

