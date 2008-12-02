From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: Oops in MMC
Date: Tue, 2 Dec 2008 17:47:35 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301B6F469CA@dbde02.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301B6F46990@dbde02.ent.ti.com>
 <493525C4.9040000@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33093 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751505AbYLBMRs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Dec 2008 07:17:48 -0500
In-Reply-To: <493525C4.9040000@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Adrian Hunter <ext-adrian.hunter@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Adrian Hunter [mailto:ext-adrian.hunter@nokia.com] 
> Sent: Tuesday, December 02, 2008 5:41 PM
> To: Premi, Sanjeev
> Cc: linux-omap@vger.kernel.org
> Subject: Re: Oops in MMC
> 
> Premi, Sanjeev wrote:
> > I was trying to mount the filesystem from MMC card on OMAP3EVM.
> > Came across this oops.
> 
> [snip]
> 
> > Starting system logger: <1>Unhandled fault: external abort on 
> > non-linefetch (0x1808) at 0xd809c104 Unhandled fault: 
> external abort 
> > on non-linefetch (0x1808) at 0xd809c104
> 
> [snip]
> 
> > PC is at omap_mmc_request+0x64/0x264
> 
> [snip]
> 
> Do you have the latest HSMMC patches?
> 
> Tony has refused to apply them but they are in the list 
> archive and here:
> 
> git://git.infradead.org/users/ahunter/omap_hsmmc.git 
> 
> in branch 
> 
> omap_hsmmc
> 

Thanks. Will try them. I am able to view branch over http (not git://) but unable to view them raw.
Will take bit long :(

> 