From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: Multiple errors while compiling from master
Date: Wed, 17 Mar 2010 12:47:19 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301E623C00E@dbde02.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301E623BAC0@dbde02.ent.ti.com>
 <20100315160259.GQ2900@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58014 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753018Ab0CQHRb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Mar 2010 03:17:31 -0400
In-Reply-To: <20100315160259.GQ2900@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com] 
> Sent: Monday, March 15, 2010 9:33 PM
> To: Premi, Sanjeev
> Cc: linux-omap@vger.kernel.org
> Subject: Re: Multiple errors while compiling from master
> 
> * Premi, Sanjeev <premi@ti.com> [100315 07:30]:
> > Hi all,
> > 
> > While trying to build kernel from master, I encounter many 
> errors (pasted below).
> > 
> > I believe the reason is missing headers - plat/resource.h 
> and smartreflex.h
> > ...but I couldn't find them in the tree.
> > 
> > premi # ls -l arch/arm/plat-omap/include/plat/res*
> > ls: No match.
> > premi # ls -l arch/arm/mach-omap2/smart*
> > ls: No match.
> > premi #
> > 
> > I am at commit: a842b5f9ce70e1b738eabb4d719860070180ed1c
> 
> It should build fine for all omaps now. Maybe do git status and see
> if you have something extra applied? Those files are currently
> only in Kevin's PM branch.

Sorry! It was due to wrong commit pushed on the master; did not
realize it earlier.

Verified the build after removing this commit.

Best regards,
Sanjeev

> 
> Regards,
> 
> Tony
> 