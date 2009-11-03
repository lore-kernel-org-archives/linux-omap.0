From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: Update DSS2 patches for latest kernel changes
Date: Tue, 03 Nov 2009 10:54:31 +0200
Message-ID: <1257238471.13331.2.camel@tubuntu.research.nokia.com>
References: <19F8576C6E063C45BE387C64729E73940436EEB692@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:59846 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755694AbZKCIyh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Nov 2009 03:54:37 -0500
In-Reply-To: <19F8576C6E063C45BE387C64729E73940436EEB692@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Mon, 2009-11-02 at 16:02 +0100, ext Hiremath, Vaibhav wrote:
> Hi Tomi,
> 
> (Tomi, Sorry for resending it again, somehow last mail did not reach to list, so sending it again by removing patches attached.)
> 
> DSS2 patches needs to be updated against the latest kernel changes, especially after commit "omap: headers: Move remaining headers from include/mach to include/plat"
> 
> Since this patch has already merged to "for-next", I have done required modification to your commits (for both master and pm branch), keeping rest of the stuff as is. 
> I could able to validate it only on OMAP3EVM (since I don't have other EVMs) with DPI/Venc interface. 
> 
> If you could validate rest of the interfaces then we can update the DSS2 branch with latest kernel.
> 
> You can access the patches from the repository - 
> 
> http://arago-project.org/git/people/?p=vaibhav/ti-psp-omap-video.git;a=shortlog;h=refs/heads/ti_display

Thanks, although I have already done that =). I'm in the process of
integrating new patches (mostly VRFB and DSI fixes) to the DSS patch
set. When I'm done I'll post them.

 Tomi


