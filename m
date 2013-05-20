From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH-V2] ARM: OMAP2+: AM33xx: Fix missing reset status data
 to GFX hwmod
Date: Mon, 20 May 2013 17:55:58 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EC8EF8A@DBDE04.ent.ti.com>
References: <1369057116-31423-1-git-send-email-hvaibhav@ti.com>
 <alpine.DEB.2.02.1305201439020.6174@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35927 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755520Ab3ETR43 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 May 2013 13:56:29 -0400
In-Reply-To: <alpine.DEB.2.02.1305201439020.6174@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com]
> Sent: Monday, May 20, 2013 8:09 PM
> To: Hiremath, Vaibhav
> Cc: linux-omap@vger.kernel.org; tony@atomide.com; linux-arm-
> kernel@lists.infradead.org
> Subject: Re: [PATCH-V2] ARM: OMAP2+: AM33xx: Fix missing reset status
> data to GFX hwmod
> 
> On Mon, 20 May 2013, Vaibhav Hiremath wrote:
> 
> > GFX has a reset status register (PRM_GFX.RM_GFX_RSTST),
> > so update the GFX hwmod data with .rstst_off and .st_shift
> > information.
> >
> > Although it doesn't have impact on kernel boot, but this is
> > regression fix from original hwmod commit.
> >
> 
> Did it ever work?  If not, then it's not a regression, right?
> 

As we know none of the GFX sw is available in the mainline, so never got
exercised so far; but kernel boots up fine without any issues.
I was also confused a bit on this, but then thought, this could be regression
As it is fixing wrong/missing data without which GFX will not work.
May be I was wrong.

Thanks,
Vaibhav
