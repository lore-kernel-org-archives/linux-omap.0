From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] arm: omap: Fix errors and warnings when building
 for one board
Date: Thu, 3 Nov 2011 11:26:31 -0700
Message-ID: <20111103182631.GT31337@atomide.com>
References: <1318522450-18425-1-git-send-email-premi@ti.com>
 <E28AAFD00EFAA646AE3DF9B89CD24A8901CD80@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:24061 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933883Ab1KCS0e (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Nov 2011 14:26:34 -0400
Content-Disposition: inline
In-Reply-To: <E28AAFD00EFAA646AE3DF9B89CD24A8901CD80@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Premi, Sanjeev <premi@ti.com> [111028 06:36]:
> > -----Original Message-----
> > From: Premi, Sanjeev 
> > Sent: Thursday, October 13, 2011 9:44 PM
> > To: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> > Cc: Premi, Sanjeev
> > Subject: [PATCH v2] arm: omap: Fix errors and warnings when 
> > building for one board
> > 
> > When customizing omap2plus_defconfig to build for only
> > one board (omap3evm), I came across these warnings and
> > errors (filenames truncated):
> 
> Just wanted to check the status of this patch.

Thanks, now with the DT patches merged, I'll apply this into fixes.
Also moved around the ifdef a little to avoid a build warning for
when omap3 is not selected.

Regards,

Tony
